import 'package:agentebcp/helpers/mostrar_alerta.dart';
import 'package:agentebcp/services/auth_services.dart';
import 'package:agentebcp/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
                const BouncingScrollPhysics(), //! hacer el efecto de rebote
            child: Container(
              //! para que no se comprima los widgets y poder hacer scroll a todos al levantar el teclado
              height: MediaQuery.of(context).size.height * 0.9,
              child: ListView(
                children: const [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Logo(
                        titulo: 'Registro',
                      ),
                      _FormState(),
                      Labels(
                        ruta: 'login',
                        titulo: 'Ya tienes una cuenta?',
                        subtitulo: 'Inicia Sesion!',
                      ),
                      Text(
                        "Terminos y condiciones de uso",
                        style: TextStyle(fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _FormState extends StatefulWidget {
  const _FormState({super.key});

  @override
  State<_FormState> createState() => __FormStateState();
}

class __FormStateState extends State<_FormState> {
  final terminalCtrl = TextEditingController();
  final rucCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final telfonoCtrl = TextEditingController();

  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Column(children: [
        CustomIpunt(
          icon: Icons.supervised_user_circle_outlined,
          placeholder: "Terminal",
          textController: terminalCtrl,
        ),
        CustomIpunt(
          icon: Icons.email_outlined,
          placeholder: "Correo",
          textController: correoCtrl,
        ),
        CustomIpunt(
            icon: Icons.edit_document,
            placeholder: "RUC",
            textController: rucCtrl,
            keyboardType: TextInputType.number),
        CustomIpunt(
          icon: Icons.person_2_outlined,
          placeholder: "Nombre Completo",
          textController: nombreCtrl,
        ),
        CustomIpunt(
          icon: Icons.lock_clock_outlined,
          placeholder: "Contrasena",
          textController: passCtrl,
          isPassword: true,
        ),
        BtnAzul(
            colorBtn: Colors.blue,
            labelBtn: 'Registro',
            labelColor: Colors.white,
            onPressed: authServices.autenticado
                ? null
                : () async {
                    final respRegister = await authServices.register(
                        terminalCtrl.text.trim(),
                        rucCtrl.text.trim(),
                        correoCtrl.text.trim(),
                        nombreCtrl.text.trim(),
                        passCtrl.text.trim());

                    if (respRegister == true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro Incorrecto',
                          respRegister['password'].toString());
                    }
                  })
      ]),
    );
  }
}
