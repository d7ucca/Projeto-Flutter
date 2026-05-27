import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_response_dto.dart';

abstract class IAuthService {
  Future<AuthResponseDto> login(String username, String password);
}

class AuthService implements IAuthService {
  final String baseUrl =
      "https://mobile-ios-login.zani0x03.eti.br/api/auth/login";

  final String sistemaId = "95a33e96-3357-4d83-b2ec-4d1da3e2fc07";

  @override
  Future<AuthResponseDto> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "password": password,
        "sistemaId": sistemaId,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Usuário ou senha inválidos");
    }
  }
}
