import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/common/pages/action/loading_page.dart';
import 'package:hotel/common/routes/routes.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';
import 'package:hotel/core/utils/utils.dart';
import 'package:hotel/features/hotel/domain/entities/hotel.dart';
import 'package:hotel/features/hotel/presentation/controller/hotel_controller.dart';
import 'package:hotel/features/hotel/presentation/widgets/banner_widget.dart';
import 'package:hotel/features/hotel/presentation/widgets/hotel_detail_item.dart';
import 'package:hotel/features/hotel/presentation/widgets/name_addres_widget.dart';
import 'package:hotel/features/hotel/presentation/widgets/price_widget.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  HotelController hotelController = HotelController();
  @override
  void initState() {
    Get.put(hotelController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    hotelController.getHotel();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Get.delete<HotelController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Отель',
        ),
      ),
      body: Obx(() {
        if (hotelController.isloading.value) {
          return const LoadingPage();
        }
        if (hotelController.hotel != null) {
          Hotel hotel = hotelController.hotel!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(Dimens.midRadius)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimens.midMargin),
                        child: BannerWidget(
                          imageUrls: hotel.image_urls,
                        ),
                      ),
                      NameAddressWidget(
                        name: hotel.name,
                        address: hotel.address,
                        rating: hotel.rating,
                        ratingName: hotel.rating_name,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimens.midMargin),
                        child: PriceWidget(
                          price: 'от ${seperateThousands(hotel.minimal_price)}',
                          priceFor: hotel.price_for_it,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midRadius),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(Dimens.midMargin),
                        child: Text(
                          'Об отеле',
                          style: TextStyles.big,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.midMargin),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: hotel.peculiarities.map((e) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.lightGrey,
                              ),
                              child: Text(
                                e,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(Dimens.midMargin),
                        child: Text(
                          hotel.description,
                          style: TextStyles.regular,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(
                            Dimens.midRadius,
                          ),
                        ),
                        padding: const EdgeInsets.all(Dimens.midMargin),
                        child: const Column(
                          children: [
                            HotelDetailItem(
                              iconPath: 'assets/icons/emoji-happy.svg',
                              title: 'Удобства',
                              subtitle: 'Самое необходимое',
                            ),
                            HotelDetailItem(
                              iconPath: 'assets/icons/tick-square.svg',
                              title: 'Что включено',
                              subtitle: 'Самое необходимое',
                            ),
                            HotelDetailItem(
                              iconPath: 'assets/icons/close-square.svg',
                              title: 'Что не включено',
                              subtitle: 'Самое необходимое',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.midMargin,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          Routes.room,
                          arguments: hotelController.hotel?.name,
                        );
                      },
                      child: const Text(
                        'К выбору номера',
                        style: TextStyles.regularBolder,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }
}
