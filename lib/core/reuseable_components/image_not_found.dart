import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utiles/app_colors.dart';

Widget imageNotFound(double width, double height) {
  return Container(
    color: AppColors.blackColor,
    height: height == 0 ? null : height.h,
    width: width == 0 ? null : width.w,
    child: const Icon(
      Icons.error,
      color: AppColors.whiteColor,
    ),
  );
}
