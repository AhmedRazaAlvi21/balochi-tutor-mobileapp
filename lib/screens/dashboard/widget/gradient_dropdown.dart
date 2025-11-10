import 'package:balochi_tutor/res/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientDropdown extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const GradientDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    this.onChanged,
  });

  @override
  State<GradientDropdown> createState() => _GradientDropdownState();
}

class _GradientDropdownState extends State<GradientDropdown> {
  late String selectedValue;
  bool isExpanded = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(GradientDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      selectedValue = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? Size.zero;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Backdrop to close dropdown when tapping outside
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (mounted) {
                  setState(() => isExpanded = false);
                }
                _removeOverlay();
              },
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          // Dropdown menu - must be above backdrop
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(size.width - 140.w, size.height + 4),
            child: Material(
              elevation: 8,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: widget.options
                    .where((option) => option != selectedValue)
                    .map(
                      (option) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _selectOption(option),
                          borderRadius: BorderRadius.circular(40.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              gradient: LinearGradient(
                                colors: AppColor.appPrimaryGradient1,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectOption(String value) {
    setState(() {
      selectedValue = value;
      isExpanded = false;
    });
    _removeOverlay();
    widget.onChanged?.call(value);
  }

  void _toggleDropdown() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            gradient: LinearGradient(
              colors: AppColor.appPrimaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedValue,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
