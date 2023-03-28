// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_colors.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/sized_box.dart';
import 'package:flutter_application_1/core/widgets/text_widget.dart';

class InternetWidget extends StatelessWidget {
  InternetWidget({
    required this.onPressed,
    super.key,
  });

  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: TextWidget(
              text: 'Not connected to internet',
              fontSize: FontSizes.sp18,
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
            onPressed: () {},
          ),
          AppSizes.r16.ph,
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.r8),
              ),
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: AppSizes.r16,
                vertical: AppSizes.r8,
              ),
            ),
            child: TextWidget(
              text: 'Try Again',
              fontSize: FontSizes.sp18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
