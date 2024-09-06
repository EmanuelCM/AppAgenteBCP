// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String terminal;
  int ruc;
  String email;
  String nombre;
  bool online;
  String password;
  String uid;

  Usuario({
    required this.terminal,
    required this.ruc,
    required this.email,
    required this.nombre,
    required this.online,
    required this.password,
    required this.uid,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        terminal: json["terminal"] ?? '', // Valor por defecto si es null
        ruc: json["ruc"] ?? 0, // Valor por defecto si es null
        email: json["email"] ?? '', // Valor por defecto si es null
        nombre: json["nombre"] ?? '', // Valor por defecto si es null
        online: json["online"] ?? false, // Valor por defecto si es null
        password: json["password"] ?? '', // Valor por defecto si es null
        uid: json["uid"] ?? '', // Valor por defecto si es null
      );

  Map<String, dynamic> toJson() => {
        "terminal": terminal,
        "ruc": ruc,
        "email": email,
        "nombre": nombre,
        "online": online,
        "password": password,
        "uid": uid,
      };
}
