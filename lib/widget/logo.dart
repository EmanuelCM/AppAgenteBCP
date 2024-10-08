import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;
  const Logo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 70),
                width: 170,
                child: const Image(image: AssetImage('assets/tag-logo.png'))),
            const SizedBox(height: 20),
            Text(
              titulo,
              style: TextStyle(fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
