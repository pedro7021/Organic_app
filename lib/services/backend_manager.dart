import 'dart:io';
import 'package:organic/components/bottom_success_message.dart';
import 'package:organic/models/denounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:organic/components/bottom_error_message.dart';
import 'package:organic/graphql/client.dart';
import 'package:organic/models/ad.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../routes.dart';

class BackendManager {
  final Perform perform = Perform();

  void _OpenDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("Salvando anúncio...")
            ],
          ),
        );
      },
    );
  }

  Future<void> SaveAd({
    @required String token,
    @required BuildContext context,
    @required Ad ad,
    @required List<File> images,
  }) async {
    _OpenDialog(context);

    try {
      await Permission.location.request();
      final Position currentPosition = await Geolocator.getCurrentPosition();
      ad.latitude = currentPosition.latitude;
      ad.longitude = currentPosition.longitude;
      MultipartFile file;
      for (final image in images) {
        file = MultipartFile.fromFileSync(image.path,
            contentType: MediaType("image", "jpg"));
        ad.imagesFiles.add(file);
      }
      final dio = Dio();
      final formData = FormData.fromMap(ad.toMap());
      dio.options.baseUrl = "https://organic-api-i4ht3h4sba-rj.a.run.app";
      final response = await dio.post('/ads/new',
          data: formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode != 200) {
        throw "não é codigo 200";
      }
      Navigator.popUntil(
          context, ModalRoute.withName(AppRoutes.NAVIGATION_SCREEN));
    } catch (e) {
      Navigator.pop(context);
      BottomErrorMessage(
          context: context, errorMessage: "Erro ao Publicar Anúncio.");
    }
  }

  Future<void> SendDenounce({
    @required BuildContext context,
    @required Denounce denounce,
  }) async {
    try {
      perform.Create_Complaint(denounce.toMap());
      Navigator.popUntil(
          context, ModalRoute.withName(AppRoutes.NAVIGATION_SCREEN));
      BottomSuccessMessage(
          context: context, message: "Denúncia Enviada com Sucesso.");
    } catch (e) {
      BottomErrorMessage(context: context, errorMessage: "Erro ao Denunciar.");
    }
  }
}
