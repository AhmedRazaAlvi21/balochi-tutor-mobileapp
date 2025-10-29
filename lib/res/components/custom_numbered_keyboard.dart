import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/material.dart';

class NumberKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const NumberKeyboard({Key? key, required this.onKeyPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.transparent, width: 0),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _numberButton('1', onKeyPressed, context),
              _numberButton('2', onKeyPressed, context),
              _numberButton('3', onKeyPressed, context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _numberButton('4', onKeyPressed, context),
              _numberButton('5', onKeyPressed, context),
              _numberButton('6', onKeyPressed, context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _numberButton('7', onKeyPressed, context),
              _numberButton('8', onKeyPressed, context),
              _numberButton('9', onKeyPressed, context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _numberButton('.', onKeyPressed, context),
              _numberButton('0', onKeyPressed, context),
              IconButton(
                onPressed: () => onKeyPressed('back'),
                icon: Icon(Icons.backspace, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberButton(String value, Function(String) onKeyPressed, BuildContext context) {
    return ElevatedButton(
      onPressed: () => onKeyPressed(value),
      child: Text(
        value,
        style: TextStyle(
          // textBaseline: TextBaseline.ideographic,
          fontWeight: FontWeight.w500,
          fontFamily: 'Nunito',
          color: Colors.black,
          fontSize: 24 * context.textScaleFactorResponsive, // Use responsive font size
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
        padding: EdgeInsets.all(18),
        elevation: 0,
        side: BorderSide(color: Colors.transparent, width: 0),
      ),
    );
  }
}
