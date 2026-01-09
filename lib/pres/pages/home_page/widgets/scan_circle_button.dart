import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_color/app_colors.dart';

class ScanCircleButton extends StatefulWidget {
  final VoidCallback onTap;
  const ScanCircleButton({super.key, required this.onTap});

  @override
  State<ScanCircleButton> createState() => _ScanCircleButtonState();
}

class _ScanCircleButtonState extends State<ScanCircleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
            color: AppColors.primary,
            border: Border.all(
              color: Color.fromRGBO(26, 13, 137, 1),
              width: 5.r,
            ),
            shape: BoxShape.circle,
          ),
          height: 99.h,
          width: 99.h,
          child: Icon(
            Icons.qr_code_scanner,
            size: 63.41.r,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
