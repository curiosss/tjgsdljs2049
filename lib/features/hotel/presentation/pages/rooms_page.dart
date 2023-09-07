import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/common/pages/action/loading_page.dart';
import 'package:hotel/common/routes/routes.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';
import 'package:hotel/core/utils/utils.dart';
import 'package:hotel/features/hotel/domain/entities/room.dart';
import 'package:hotel/features/hotel/presentation/controller/hotel_controller.dart';
import 'package:hotel/features/hotel/presentation/widgets/banner_widget.dart';
import 'package:hotel/features/hotel/presentation/widgets/price_widget.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HotelController hotelController = Get.find<HotelController>();
    hotelController.getRooms();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments ?? '',
        ),
      ),
      body: Obx(() {
        if (hotelController.isRoomsLoading.value) {
          return const LoadingPage();
        }
        if (hotelController.rooms.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
            itemCount: hotelController.rooms.length,
            itemBuilder: (context, index) {
              Room room = hotelController.rooms[index];
              return Container(
                margin: const EdgeInsets.only(bottom: Dimens.smallMargin),
                padding: const EdgeInsets.all(Dimens.midMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.midRadius),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerWidget(
                      imageUrls: room.image_urls,
                      autoPlay: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimens.smallMargin,
                      ),
                      child: Text(
                        room.name,
                        style: TextStyles.big,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: room.peculiarities.map((e) {
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Dimens.smallMargin,
                        bottom: Dimens.midMargin,
                      ),
                      child: Material(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(Dimens.smallRadius),
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(Dimens.smallRadius),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 2,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'Подробнее о номере',
                                    style: TextStyles.regularBolder.copyWith(
                                      color: AppColors.blue,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 24,
                                  color: AppColors.blue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    PriceWidget(
                      price: seperateThousands(room.price),
                      priceFor: room.price_per,
                    ),
                    const SizedBox(height: Dimens.midMargin),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.booking);
                        },
                        child: const Text('Выбрать номер'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Container();
      }),
    );
  }
}
