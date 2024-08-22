import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  final Color colorBtn;
  final String labelBtn;
  final Color labelColor;
  final double labelSize;
  final VoidCallback? onPressed;

  const BtnAzul({
    super.key,
    required this.colorBtn,
    required this.labelBtn,
    this.labelSize = 18,
    required this.labelColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: colorBtn,
          shape: const StadiumBorder(),

          // Elevación normal del botón
        ),
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              labelBtn,
              style: TextStyle(color: labelColor, fontSize: labelSize),
            ),
          ),
        ));
  }
}
