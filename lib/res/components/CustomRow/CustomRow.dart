import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_chip.dart';

class CustomRow extends StatelessWidget {
  final String text1;
  final String text2;
  final bool isSelected1;
  final bool isSelected2;
  final VoidCallback ontap1;
  final VoidCallback ontap2;

  const CustomRow(
      {super.key,
      required this.text1,
      required this.text2,
      required this.ontap1,
      required this.ontap2,
      required this.isSelected1,
      required this.isSelected2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomChip(
            text: text1,
            isSelected: isSelected1,
            onpress: ontap1,
          ),
        ),
        Expanded(
          child: CustomChip(
            text: text2,
            isSelected: isSelected2,
            onpress: ontap2,
          ),
        ),
      ],
    );
  }
}
