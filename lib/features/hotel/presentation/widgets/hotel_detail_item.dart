import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

class HotelDetailItem extends StatelessWidget {
  final Function()? onTap;
  final String iconPath;
  final String title;
  final String subtitle;
  const HotelDetailItem({
    super.key,
    this.onTap,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // child: ListTile(
      //   leading: SvgPicture.asset(iconPath),
      //   title: Text(title),
      //   subtitle: Text(subtitle),
      //   trailing: const Icon(Icons.keyboard_arrow_right),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.midMargin),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(iconPath),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.regularBolder,
                  ),
                  Text(
                    subtitle,
                    style: TextStyles.regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            )),
            const Icon(
              Icons.keyboard_arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}
