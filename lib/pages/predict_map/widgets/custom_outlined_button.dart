import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPress,
    required this.text,
    this.borderColor,
  });

  final Function() onPress;
  final String text;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, 
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), 
            side: BorderSide(color: Colors.blue)
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue, 
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}