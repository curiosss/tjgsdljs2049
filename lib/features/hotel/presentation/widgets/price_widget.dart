import 'package:flutter/material.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

class PriceWidget extends StatelessWidget {
  final String price;
  final String priceFor;
  const PriceWidget({
    super.key,
    required this.price,
    required this.priceFor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$price ₽',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimens.smallMargin,
              bottom: 3,
            ),
            child: Text(
              priceFor,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
