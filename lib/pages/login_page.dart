import 'package:agentebcp/widget/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(titulo: 'Agente BCP'),
                  _FormState(),
                  Labels(
                    ruta: 'register',
                    titulo: 'No tienes cuenta?',
                    subtitulo: 'Crea una ahora!',
                  ),
                  Text(
                    "Terminos y condiciones de uso",
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
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
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 200),
      child: Column(children: [
        CustomIpunt(
          icon: Icons.supervised_user_circle_outlined,
          placeholder: "Terminal",
          textController: terminalCtrl,
        ),
        CustomIpunt(
          icon: Icons.lock_clock_outlined,
          placeholder: "Contrasena",
          textController: passCtrl,
          isPassword: true,
        ),
        BtnAzul(
            colorBtn: Colors.blue,
            labelBtn: 'Loggin',
            labelColor: Colors.white,
            onPressed: () {})
      ]),
    );
  }
}
