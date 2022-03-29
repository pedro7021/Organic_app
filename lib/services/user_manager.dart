import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:organic/graphql/client.dart';
import 'package:organic/models/auth_errors.dart';

import '../models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadLoggedUser();
  }

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final perform = Perform();
  User user;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => user != null;

// TODO Um monte de coisa
  Future<void> Login({
    @required User user,
    @required Function onFail,
    @required Function onSuccess,
  }) async {
    loading = true;
    try {
      final result = await perform.Authenticate_User(user);
      if (result.hasException) {
        throw result.exception.graphqlErrors[0].extensions["exception"]['data']
            ['message'][0]["messages"][0]["id"];
      }
      _loadNewUser(result.data['login']["jwt"] as String);

      onSuccess();
    } catch (e) {
      onFail(getErrorString(e.toString()));
    }
    loading = false;
  }

  Future<void> signUp({
    @required User user,
    @required Function onFail,
    @required Function onSuccess,
  }) async {
    loading = true;
    try {
      final result = await perform.Create_User(user);
      if (result.hasException) {
        throw result.exception.graphqlErrors[0].extensions["exception"]['data']
            ['message'][0]["messages"][0]["id"];
      }
      _loadNewUser(result.data['register']["jwt"] as String);
      onSuccess();
    } catch (e) {
      onFail(getErrorString(e.toString()));
    }
    loading = false;
  }

  void signOut() {
    storage.delete(key: 'token');
    user = null;
    notifyListeners();
  }

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  Future<void> _loadLoggedUser() async {
    final String userToken = await storage.read(key: 'token');
    if (userToken != null) {
      user = User.Token(userToken);
      notifyListeners();
    }
  }

  Future<void> _loadNewUser(String token) async {
    user = User.Token(token);
    notifyListeners();
    await storage.write(key: 'token', value: token);
  }

  Future<void> recoverPassword({
    @required String email,
    @required Function onFail,
    @required Function onSuccess,
  }) async {
    loading = true;
    try {
      final result = await perform.Forgot_Password(email);
      if (result.hasException) {
        throw result.exception.graphqlErrors[0].extensions["exception"]['data']
            ['message'][0]["messages"][0]["id"];
      }
      onSuccess();
    } catch (e) {
      onFail(getErrorString(e.toString()));
    }
    loading = false;
  }
}
  

  //
  //
  // Future<void> ChangePassword({
  //   @required String senhaAntiga,
  //   @required String senhaNova,
  //   @required Function onFail,
  //   @required Function onSuccess,
  // }) async {
  //   loading = true;
  //   try {
  //     await reauthenticate(senhaAntiga);
  //
  //     final User newUser = auth.currentUser;
  //     await newUser.updatePassword(senhaNova);
  //
  //     onSuccess();
  //   } catch (e) {
  //     onFail(getErrorString(e.code.toString()));
  //   }
  //   loading = false;
  // }
  //
