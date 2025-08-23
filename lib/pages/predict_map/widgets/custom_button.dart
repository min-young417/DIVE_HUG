import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.text,
    this.color,
  });

  final Function() onPress;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blue, 
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), 
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}