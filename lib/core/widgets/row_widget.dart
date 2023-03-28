// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_colors.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/sized_box.dart';
import 'package:flutter_application_1/core/widgets/text_widget.dart';

class RowWidget extends StatelessWidget {
  String text;
  IconData icon;
  RowWidget({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.black,
        ),
        AppSizes.r8.pw,
        TextWidget(
          text: text,
          color: AppColors.black,
          fontSize: FontSizes.sp16,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
