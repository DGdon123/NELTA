import 'package:flutter/material.dart';
import 'package:nelta/common/app_const/app_dimension.dart';
import 'package:nelta/utils/responsive_helper/responsive_helper.dart';

void showCustomSnackBar(String message, BuildContext context,
    {bool isError = true}) {
  final width = MediaQuery.of(context).size.width;
  ResponsiveHelper.isDesktop(context)
      ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            message,
          ),
          margin: ResponsiveHelper.isDesktop(context)
              ? EdgeInsets.only(
                  right: width * 0.75,
                  bottom: AppDimensions.paddingEXTRALARGE,
                  left: AppDimensions.paddingEXTRALARGE)
              : const EdgeInsets.only(bottom: AppDimensions.paddingEXTRALARGE),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.down,
          duration: Duration(
              milliseconds: ResponsiveHelper.isDesktop(context) ? 1000 : 600),
          backgroundColor: isError ? Colors.red : Colors.green))
      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 4),
        ));
}
