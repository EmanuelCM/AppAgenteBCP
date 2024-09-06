import 'dart:convert';

import 'package:agentebcp/global/envioronment.dart';
import 'package:agentebcp/models/login_response.dart';
import 'package:agentebcp/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices with ChangeNotifier {
  late Usuario usuario;
  bool _autenticado = false;
  bool get autenticado => _autenticado;

  final _storage = new FlutterSecureStorage();

  set autenticado(bool valor) {
    _autenticado = valor;
    notifyListeners();
  }

  // Getters del token de forma estatica

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token ?? '';
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
    ;
  }

  Future<bool> login(String terminal, String password) async {
    autenticado = true;

    final data = {
      'terminal': terminal,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Envioronment.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(resp.body);
    autenticado = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.user;

      //! gurdar token lugar seguro
      await _guradarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  // Future register(String terminal, String ruc, String email, String nombre,
  //     String password) async {
  //   autenticado = true;
  //   final data = {
  //     "terminal": terminal,
  //     "ruc": ruc,
  //     "email": email,
  //     "nombre": nombre,
  //     "password": password,
  //   };
  //   // print(data);

  //   final resp = await http.post(
  //     Uri.parse('${Envioronment.apiUrl}/login/new'),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   // print(resp.body);
  //   autenticado = false;

  //   if (resp.statusCode == 200) {
  //     final loginResponse = loginResponseFromJson(resp.body);
  //     usuario = loginResponse.user;

  //     //! gurdar token lugar seguro
  //     await _guradarToken(loginResponse.token);
  //     return true;
  //   } else {
  //     final resBody = jsonDecode(resp.body);
  //     print(resBody['msg']);
  //     return resBody['msg'];
  //   }
  // }

  Future<dynamic> register(String terminal, String ruc, String email,
      String nombre, String password) async {
    autenticado = true;
    final data = {
      "terminal": terminal,
      "ruc": ruc,
      "email": email,
      "nombre": nombre,
      "password": password,
    };

    try {
      final resp = await http.post(
        Uri.parse('${Envioronment.apiUrl}/login/new'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      autenticado = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        usuario = loginResponse.user;

        //! Guardar token en lugar seguro
        await _guradarToken(loginResponse.token);
        return true; // Devuelve true si todo es correcto
      } else {
        final resBody = jsonDecode(resp.body);

        // Si hay errores específicos en campos, retornarlos como mapa
        if (resBody['errors'] != null) {
          Map<String, String> errorMap = {};
          resBody['errors'].forEach((key, value) {
            errorMap[key] = value['msg'];
          });
          return errorMap; // Retornar el mapa de errores
        }

        return resBody['msg'] ??
            "Error desconocido"; // Manejo genérico de errores
      }
    } catch (e) {
      print("Error en la petición: $e");
      return {
        "error": "Error inesperado"
      }; // En caso de error inesperado, retornas un mapa con el error genérico
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final resp = await http.get(
      Uri.parse('${Envioronment.apiUrl}/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token!,
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      usuario = loginResponse.user;

      //! gurdar token lugar seguro
      await _guradarToken(loginResponse.token);
      return true;
    } else {
      logOut();
      return false;
    }
  }

  Future _guradarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    await _storage.delete(key: 'token');
  }
}
