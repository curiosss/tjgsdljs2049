import 'package:flutter/material.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

class NameAddressWidget extends StatelessWidget {
  final String name;
  final String address;
  final num rating;
  final String ratingName;
  const NameAddressWidget({
    super.key,
    required this.name,
    required this.address,
    required this.rating,
    required this.ratingName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.midMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.midRadius),
              color: AppColors.yellowish,
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.orange,
                  size: 20,
                ),
                const SizedBox(width: 2),
                Text(
                  '$rating $ratingName',
                  style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.smallMargin),
          Text(
            name,
            style: TextStyles.big,
          ),
          const SizedBox(height: Dimens.smallMargin),
          Text(
            address,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
