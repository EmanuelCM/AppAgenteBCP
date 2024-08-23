import 'dart:io';

import 'package:agentebcp/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];

  bool _scribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange[300],
              maxRadius: 14,
              child: const Text('Te',
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            const SizedBox(height: 3),
            const Text(
              'Sebastian Chaupis',
              style: TextStyle(color: Colors.black54, fontSize: 15),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //aqui estara toda la lista de mensajes
            Flexible(
                //envolveremos todos los chats en list viewbuilder
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            Divider(
              height: 1,
            ),
            Container(
              height: 50,
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        // usamos esto para dar un espacion ante el boto de cambiar de pantalla en algunos celulares
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String texto) {
                setState(() {
                  if (texto.trim().length > 0) {
                    _scribiendo = true;
                  } else {
                    _scribiendo = false;
                  }
                });

                // TODO:cuando hay un valor para poder postear
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
              focusNode: _focusNode,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _scribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.orange[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: _scribiendo
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ),
                    ))
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto,
      uiD: '123',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward(); //! para cargar la animacion
    setState(() {
      _scribiendo = false;
    });
  }

  @override
  void dispose() {
    // off del socket
    //Limpiar instancias de arreglo
    for (ChatMessage message in _messages) {
      message.animationController
          .dispose(); // para al cerrar la venta finalizar todos los efectos
    }
    super.dispose();
  }
}
