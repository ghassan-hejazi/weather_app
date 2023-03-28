// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_colors.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/sized_box.dart';
import 'package:flutter_application_1/core/widgets/text_widget.dart';

class RowWidgetTwo extends StatelessWidget {
  String text;
  String textWeather;
  IconData icon;
  RowWidgetTwo({
    required this.text,
    required this.textWeather,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.grey700,
          ),
          AppSizes.r8.pw,
          TextWidget(
            text: text,
            fontSize: FontSizes.sp14,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlueAccent,
          ),
          TextWidget(
            text: textWeather,
            fontSize: FontSizes.sp14,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlueAccent,
          ),
        ],
      ),
    );
  }
}
