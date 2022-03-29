import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:organic/graphql/client.dart';
import 'package:organic/models/ad.dart';

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

enum StoreState {
  loading,
  available,
  notAvailable,
}

class PurchasableProduct {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;

  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
}

class BoostPurchase extends ChangeNotifier {
  static const storeKeyConsumable = "boost";
  Ad ad;
  String UserToken;
  final Perform perform = Perform();
  StreamSubscription<List<PurchaseDetails>> _subscription;
  final iapConnection = InAppPurchase.instance;
  StoreState storeState = StoreState.loading;
  List<PurchasableProduct> products = [];
  Function onFail;
  Function onSuccess;
  BoostPurchase() {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }
  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }
    const ids = <String>{
      storeKeyConsumable,
    };
    final response = await iapConnection.queryProductDetails(ids);

    products =
        response.productDetails.map((e) => PurchasableProduct(e)).toList();
    storeState = StoreState.available;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> buy({
    PurchasableProduct product,
    Ad ad,
    String token,
    Function onFail,
    Function onSuccess,
  }) async {
    this.ad = ad;
    UserToken = token;
    this.onFail = onFail;
    this.onSuccess = onSuccess;
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    if (product.id == storeKeyConsumable) {
      await iapConnection.buyConsumable(purchaseParam: purchaseParam);
    } else {
      throw ArgumentError.value(
          product.productDetails, '${product.id} is not a known product');
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
    notifyListeners();
  }

  void _handlePurchase(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      if (purchaseDetails.productID == storeKeyConsumable) {
        perform.Buy_Boost(ad.id, UserToken, purchaseDetails.verificationData.serverVerificationData).then((value) => value.hasException?onFail(value.exception.toString()):onSuccess());
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      iapConnection.completePurchase(purchaseDetails);
    }
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
    onSuccess();
  }

  void _updateStreamOnError(dynamic error) {
    onFail(error.toString());
  }
}
