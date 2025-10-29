import 'package:balochi_tutor/res/extensions.dart';
import 'package:flutter/cupertino.dart';

import '../../res/colors/app_color.dart';
import '../../res/components/custom_form_field.dart';
import '../../res/components/custom_text.dart';

class CustomFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController textcontroller;
  final String? defaultval;
  final Widget? suffixIcon;
  final bool? readonly;
  final TextInputType keyboardType;

  const CustomFieldWidget({
    super.key,
    required this.title,
    required this.textcontroller,
    this.defaultval,
    this.suffixIcon,
    this.keyboardType = TextInputType.name,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure default value is set only once if the controller is empty
    if (textcontroller.text.isEmpty && defaultval != null) {
      textcontroller.text = defaultval!;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomText(
                title: title,
                fontcolor: AppColor.blackColor,
                fontsize: 16,
                fontweight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomFormField(
              fontColor: AppColor.blackColor,
              title: '',
              readonly: readonly,
              keyboardtype: keyboardType,
              fieldcontroller: textcontroller,
              sIcon: suffixIcon,
            ),
          ),
          SizedBox(
            height: context.blockSizeVertical * 1,
          ),
        ],
      ),
    );
  }
}
