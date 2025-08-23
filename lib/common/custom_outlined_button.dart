import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPress,
    required this.text,
    this.color,
    this.height,
  });

  final Function() onPress;
  final String text;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 36,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, 
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), 
            side: BorderSide(color: color ?? Colors.blue)
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color ?? Colors.blue, 
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}