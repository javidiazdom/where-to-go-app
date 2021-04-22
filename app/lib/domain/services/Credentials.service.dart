import 'dart:developer';

import '../models/Credentials.dart';
import '../../infraestructure/repositories/Credentials.repository.dart';

class CredentialsService {
  static void login(LoginCredentials credentials) async {
    try {
      await CredentialsRepository.login(credentials);
    } catch (e) {
      throw e;
    }
  }

  static void logout() {}

  static void register(RegisterCredentials credentials) async {
    try {
      await CredentialsRepository.register(credentials);
    } catch (e) {
      throw e;
    }
  }
}
