import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uiD;
  final AnimationController animationController;

  const ChatMessage(
      {super.key,
      required this.texto,
      required this.uiD,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: this.uiD == "123" ? _myNessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myNessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 5, left: 50),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xff4D9EF6), borderRadius: BorderRadius.circular(10)),
        child: Text(
          texto,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, right: 50, left: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Color(0xffE4E5E8), borderRadius: BorderRadius.circular(10)),
        child: Text(
          texto,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
