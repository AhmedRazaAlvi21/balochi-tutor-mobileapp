import 'package:flutter/material.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool isChecked;
  final Function(bool?)? onChanged;

  const CustomCheckBoxWidget({
    super.key,
    required this.isChecked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Color(0xFF6949FF),
          width: 2.0,
        ),
      ),
      value: isChecked,
      onChanged: onChanged ?? (v) {},
      checkColor: Colors.white,
      activeColor: Color(0xFF6949FF),
      side: BorderSide(
        color: Color(0xFF6949FF),
        width: 2.5,
      ),
    );
  }
}
