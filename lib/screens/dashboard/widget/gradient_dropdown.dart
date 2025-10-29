import 'package:flutter/material.dart';

import '../../../res/colors/app_color.dart';

class GradientDropdown extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const GradientDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<GradientDropdown> createState() => _GradientDropdownState();
}

class _GradientDropdownState extends State<GradientDropdown> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColor.appPrimaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(2, 3),
          )
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          value: selected,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          items: widget.options
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColor.appPrimaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      e,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() => selected = value!);
            widget.onChanged(value!);
          },
        ),
      ),
    );
  }
}
