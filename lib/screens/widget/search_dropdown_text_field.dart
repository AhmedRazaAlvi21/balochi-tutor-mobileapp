import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/colors/app_color.dart';

class SearchDropDownTextField extends StatelessWidget {
  final DropdownSearchOnFind<String?>? items;
  final String? labelText;
  final String? hintText;
  final Function(dynamic value)? onChange;
  final String? Function(String?)? validator;
  final String? selectedItem;
  final Widget? dropDownButton;
  final TextStyle? hintStyle, labelStyle;
  final Color? labelColor;
  final Color? enableBorderColor, borderColor, fillColor;
  final double? borderRadius, borderWidth;
  final EdgeInsetsGeometry? contentPadding;

  SearchDropDownTextField({
    this.validator,
    this.labelText,
    this.hintText,
    this.fillColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 1.0,
    this.labelStyle,
    required this.items,
    this.hintStyle,
    this.dropDownButton,
    this.onChange,
    this.selectedItem,
    this.labelColor,
    this.enableBorderColor,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String?>(
      dropdownBuilder: (context, value) {
        return Text(
          value ?? hintText!,
          style: value != null
              ? TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )
              : hintStyle ??
                  TextStyle(
                      // fontFamily: engRegular,
                      color: AppColor.blackColor.withOpacity(0.5),
                      fontSize: 12.sp,
                      height: 1.5),
        );
      },
      decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        hoverColor: Colors.transparent,
        labelStyle: labelStyle ??
            TextStyle(
              color: labelColor,
              fontWeight: FontWeight.w400,
            ),
        hintStyle: hintStyle ??
            TextStyle(
                // fontFamily: engRegular,
                color: AppColor.blackColor.withOpacity(0.5),
                fontSize: 12.sp,
                height: 1.5),
        contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? AppColor.greyColor, width: borderWidth!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 30.sp))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? AppColor.greyColor, width: borderWidth!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 30.sp))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor ?? AppColor.greyColor, width: borderWidth!),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 30.sp))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 30.sp))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 30.sp))),
        errorStyle: TextStyle(color: AppColor.redColor, height: 1.1, fontSize: 13.sp),
        // hintText: hintText,
        labelText: labelText,
      )),
      validator: validator,
      // showAsSuffixIcons: true,
      // dropDownButton: dropDownButton ?? SizedBox(),
      // popupBackgroundColor: ColorConstants.white,
      suffixProps: DropdownSuffixProps(
          dropdownButtonProps: DropdownButtonProps(color: AppColor.primaryColor, iconOpened: dropDownButton!)),

      items: items,
      onChanged: onChange,
      compareFn: (i, s) => i == s,
      selectedItem: selectedItem,
      popupProps: PopupProps.dialog(
          dialogProps: DialogProps(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )),
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            cursorColor: AppColor.blackColor,
            style: TextStyle(color: AppColor.blackColor, fontSize: 12.sp),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: 'Search',
              helperStyle: TextStyle(color: AppColor.redColor, fontSize: 11.sp),
            ),
          )),
    );
  }
}
