import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/Credentials.dart';
import '../DTOs/CredentialsDTO.dart';
import '../http/HttpGraphqlService.dart';
import '../http/mutations/Mutations.dart';

class CredentialsRepository {
  static void login(LoginCredentials credentials) async {
    var credentialsDTO =
        new LoginCredentialsDTO(credentials.email, credentials.password);
    var response = await HttpGraphqlService.mutate(
        loginMutation, jsonEncode(credentialsDTO));
    if (response.statusCode != 200) {
      throw new Exception(
          'No se puede establecer la conexión con el servidor en este momento');
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new Exception(decodedResponse['errors'][0]['message']);
    } else {
      if (decodedResponse['data']['login']['token'] == null) {
        throw new Exception('No se pudo recuperar el token.');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', decodedResponse['data']['login']['token']);
      await prefs.setString('currentUser',
          decodedResponse['data']['login']['user']["name"] ?? "");
    }
  }

  static void register(RegisterCredentials credentials) async {
    var credentialsDTO = new RegisterCredentialsDTO(
        credentials.email, credentials.password, credentials.name);
    var response = await HttpGraphqlService.mutate(
        registerMutation, jsonEncode(credentialsDTO));
    if (response.statusCode != 200) {
      throw new Exception(
          'No se puede establecer la conexión con el servidor en este momento');
    }
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['errors'] != null) {
      throw new Exception(decodedResponse['errors'][0]['message']);
    }
  }
}
