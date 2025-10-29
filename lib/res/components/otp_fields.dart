import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';

class CustomOTPField extends StatefulWidget {
  final int fieldCount;
  final double fieldWidth;
  final double fieldHeight;
  final double borderWidth;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final Function(String)? onChanged;

  CustomOTPField({
    required this.fieldCount,
    required this.fieldWidth,
    required this.fieldHeight,
    this.borderWidth = 1.0,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 16.0,
    this.onChanged,
  });

  @override
  _CustomOTPFieldState createState() => _CustomOTPFieldState();
}

class _CustomOTPFieldState extends State<CustomOTPField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.fieldCount, (index) => TextEditingController());
    _focusNodes = List.generate(widget.fieldCount, (index) => FocusNode());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    super.dispose();
  }

  void _notifyParent() {
    final otp = _controllers.map((controller) => controller.text).join();
    if (widget.onChanged != null) {
      widget.onChanged!(otp);
    }
  }

  Widget _buildField(int index) {
    return Container(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      margin: EdgeInsets.only(left: index == 0 ? 0.0 : 8.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: _focusNodes[index].hasFocus ? widget.focusedBorderColor : widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24 * context.textScaleFactorResponsive,
          fontWeight: FontWeight.w700,
          fontFamily: 'Nunito',
          color: widget.textColor,
        ),
        maxLength: 1,
        // Ensure one character per field
        decoration: InputDecoration(
          counterText: "", // Removes the character counter below the TextField
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < widget.fieldCount - 1) {
              _focusNodes[index].unfocus();
              _focusNodes[index + 1].requestFocus();
            }
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index].unfocus();
            _focusNodes[index - 1].requestFocus();
          }
          _notifyParent();
        },
        onSubmitted: (value) {
          if (index == widget.fieldCount - 1 && value.isNotEmpty) {
            _notifyParent();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.fieldCount, (index) => _buildField(index)),
    );
  }
}
