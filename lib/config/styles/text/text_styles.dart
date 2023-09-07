import 'package:flutter/material.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

final class TextStyles {
  static const TextStyle big = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle regular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle regularGrey = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static const TextStyle regularHighlighted = TextStyle(
    color: AppColors.blue,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle subtitleGrey = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const TextStyle regularBolder = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}
