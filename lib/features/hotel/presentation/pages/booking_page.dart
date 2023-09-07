import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/common/pages/action/loading_page.dart';
import 'package:hotel/common/valitors/k_form_validator.dart';
import 'package:hotel/common/valitors/validators.dart';
import 'package:hotel/common/widgets/k_textfield.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';
import 'package:hotel/core/utils/utils.dart';
import 'package:hotel/features/hotel/domain/entities/booking.dart';
import 'package:hotel/features/hotel/presentation/controller/hotel_controller.dart';
import 'package:hotel/features/hotel/presentation/ui_models/tourist_form_model.dart';
import 'package:hotel/features/hotel/presentation/widgets/name_addres_widget.dart';
import 'package:hotel/features/hotel/presentation/widgets/tourist_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  HotelController hotelController = Get.find<HotelController>();

  KFormValidator kFormValidator = KFormValidator();
  var phoneMask = MaskTextInputFormatter(mask: '(###) ###-##-##');
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();

  @override
  void initState() {
    hotelController.getBookings();
    super.initState();
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  List<TouristFormModel> tourists = [
    TouristFormModel(
      title: 'Первый турист',
    ),
  ];

  addTourist() {
    setState(() {
      tourists.add(
        TouristFormModel(
          title: hotelController.getTitle(tourists.length + 1),
        ),
      );
    });
  }

  bool validate() {
    bool isValid = true;
    if (!kFormValidator.validate()) {
      isValid = false;
    }
    for (var tourist in tourists) {
      if (!(tourist.validate != null && tourist.validate!())) {
        isValid = false;
      }
    }
    return isValid;
  }

  bool isProcessing = false;
  pay() async {
    if (validate()) {
      setState(() {
        isProcessing = true;
      });
      Map<String, dynamic> data = {
        'user_phone': phoneCtrl.text,
        'user_email': emailCtrl.text,
        'tourists': [],
      };
      for (var tourist in tourists) {
        data['tourists'].add(tourist.toMap());
      }
      await hotelController.proceedToPayment(data);

      setState(() {
        isProcessing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заполните данные полностью'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронирование'),
      ),
      body: Obx(() {
        if (hotelController.isBookingsLoading.value) {
          return const LoadingPage();
        }
        if (hotelController.booking != null) {
          Booking booking = hotelController.booking!;
          String totalCharge = '${seperateThousands(booking.total_charge)} ₽';
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
                  padding:
                      const EdgeInsets.symmetric(vertical: Dimens.midMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midMargin),
                    color: Colors.white,
                  ),
                  child: NameAddressWidget(
                    name: booking.hotel_name,
                    address: booking.hotel_adress,
                    rating: booking.horating,
                    ratingName: booking.rating_name,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midMargin),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(
                    left: Dimens.midMargin,
                    right: Dimens.midMargin,
                    top: Dimens.midMargin,
                  ),
                  child: Column(
                    children: [
                      buildItem(
                        title: 'Вылет из',
                        value: booking.departure,
                      ),
                      buildItem(
                        title: 'Страна, город',
                        value: booking.arrival_country,
                      ),
                      buildItem(
                        title: 'Даты',
                        value:
                            '${booking.tour_date_start}-${booking.tour_date_stop}',
                      ),
                      buildItem(
                        title: 'Кол-во ночей',
                        value: '${booking.number_of_nights}',
                      ),
                      buildItem(
                        title: 'Отель',
                        value: booking.hotel_name,
                      ),
                      buildItem(
                        title: 'Номер',
                        value: booking.room,
                      ),
                      buildItem(
                        title: 'Питание',
                        value: booking.nutrition,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midMargin),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(Dimens.midMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Информация о покупателе',
                        style: TextStyles.big,
                      ),
                      const SizedBox(height: 20),
                      KTextField(
                        label: 'Номер телефона',
                        textEditingController: phoneCtrl,
                        textInputType: TextInputType.number,
                        inputFormatters: [phoneMask],
                        prefixText: '+7 ',
                        hintText: '(***) ***-**-**',
                        validator: fieldIsPhone,
                        kFormValidator: kFormValidator,
                      ),
                      const SizedBox(height: Dimens.smallMargin),
                      // Container(
                      //   height: 52,
                      //   color: Colors.green,
                      // ),
                      // const SizedBox(height: Dimens.smallMargin),
                      KTextField(
                        label: 'Почта',
                        textEditingController: emailCtrl,
                        validator: fieldIsEmail,
                        kFormValidator: kFormValidator,
                      ),
                      const SizedBox(height: Dimens.smallMargin),
                      const Text(
                        'Эти данные никому не передаются. После оплаты мы вышлим чек на указанный вами номер и почту',
                        style: TextStyles.subtitleGrey,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: tourists.map((e) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: Dimens.smallMargin),
                      child: TouristWidget(
                        touristFormModel: e,
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  height: 58,
                  margin: const EdgeInsets.only(bottom: Dimens.smallMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midMargin),
                    color: Colors.white,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Dimens.midMargin),
                      onTap: addTourist,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.midMargin),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Добавить туриста',
                                style: TextStyles.big,
                              ),
                            ),
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.blue,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                    top: Dimens.midMargin,
                    left: Dimens.midMargin,
                    right: Dimens.midMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.midMargin),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      buildItemSpaceBetween(
                        title: 'Тур',
                        value: '${seperateThousands(booking.tour_price)} ₽',
                      ),
                      buildItemSpaceBetween(
                        title: 'Топливный сбор',
                        value: '${seperateThousands(booking.fuel_charge)} ₽',
                      ),
                      buildItemSpaceBetween(
                        title: 'Сервисный сбор',
                        value: '${seperateThousands(booking.service_charge)} ₽',
                      ),
                      buildItemSpaceBetween(
                        title: 'К оплате',
                        value: totalCharge,
                        isHighligted: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.midMargin,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isProcessing ? null : pay,
                      child: isProcessing
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.grey,
                              ),
                            )
                          : Text(
                              'Оплатить $totalCharge',
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

  buildItem({String title = '', String value = ''}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.midMargin),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyles.regularGrey,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyles.regular,
            ),
          ),
        ],
      ),
    );
  }

  buildItemSpaceBetween({
    String title = '',
    String value = '',
    bool isHighligted = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.midMargin),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyles.regularGrey,
            ),
          ),
          Text(
            value,
            style: isHighligted
                ? TextStyles.regularHighlighted
                : TextStyles.regular,
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hotel/common/pages/action/loading_page.dart';
// import 'package:hotel/common/valitors/validators.dart';
// import 'package:hotel/common/widgets/k_textfield.dart';
// import 'package:hotel/config/styles/dimens/dimens.dart';
// import 'package:hotel/config/styles/text/text_styles.dart';
// import 'package:hotel/config/styles/theme/app_colors.dart';
// import 'package:hotel/features/hotel/domain/entities/booking.dart';
// import 'package:hotel/features/hotel/presentation/controller/hotel_controller.dart';
// import 'package:hotel/features/hotel/presentation/ui_models/tourist_form_model.dart';
// import 'package:hotel/features/hotel/presentation/widgets/name_addres_widget.dart';
// import 'package:hotel/features/hotel/presentation/widgets/tourist_widget.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// class BookingPage extends StatefulWidget {
//   const BookingPage({super.key});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   HotelController hotelController = Get.find<HotelController>();

//   GlobalKey<FormState> formKey = GlobalKey();
//   var phoneMask = MaskTextInputFormatter(mask: '(###) ###-##-##');
//   TextEditingController phoneCtrl = TextEditingController();
//   TextEditingController emailCtrl = TextEditingController();

//   @override
//   void initState() {
//     hotelController.getBookings();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     phoneCtrl.dispose();
//     emailCtrl.dispose();
//     super.dispose();
//   }

//   List<TouristFormModel> tourists = [
//     TouristFormModel(
//       title: 'Первый турист',
//     ),
//   ];

//   addTourist() {
//     setState(() {
//       tourists.add(
//         TouristFormModel(
//           title: hotelController.getTitle(tourists.length + 1),
//         ),
//       );
//     });
//   }

//   bool validate() {
//     bool isValid = true;
//     if (!(formKey.currentState?.validate() ?? false)) {
//       isValid = false;
//     }
//     for (var tourist in tourists) {
//       if (!(tourist.validate != null && tourist.validate!())) {
//         isValid = false;
//       }
//     }
//     return isValid;
//   }

//   pay() {
//     if (validate()) {
//       Map<String, dynamic> data = {
//         'user_phone': phoneCtrl.text,
//         'user_email': emailCtrl.text,
//         'tourists': [],
//       };
//       for (var tourist in tourists) {
//         data['tourists'].add(tourist.toMap());
//       }
//       hotelController.proceedToPayment(data);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Бронирование'),
//       ),
//       body: Obx(() {
//         if (hotelController.isBookingsLoading.value) {
//           return const LoadingPage();
//         }
//         if (hotelController.booking != null) {
//           Booking booking = booking;
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: Dimens.smallMargin),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: Dimens.midMargin),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimens.midMargin),
//                     color: Colors.white,
//                   ),
//                   child: NameAddressWidget(
//                     name: booking.hotel_name,
//                     address: booking.hotel_adress,
//                     rating: booking.horating,
//                     ratingName: booking.rating_name,
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimens.midMargin),
//                     color: Colors.white,
//                   ),
//                   padding: const EdgeInsets.only(
//                     left: Dimens.midMargin,
//                     right: Dimens.midMargin,
//                     top: Dimens.midMargin,
//                   ),
//                   child: Column(
//                     children: [
//                       buildItem(
//                         title: 'Вылет из',
//                         value: booking.departure,
//                       ),
//                       buildItem(
//                         title: 'Страна, город',
//                         value: booking.arrival_country,
//                       ),
//                       buildItem(
//                         title: 'Даты',
//                         value:
//                             '${booking.tour_date_start}-${booking.tour_date_stop}',
//                       ),
//                       buildItem(
//                         title: 'Кол-во ночей',
//                         value: '${booking.number_of_nights}',
//                       ),
//                       buildItem(
//                         title: 'Отель',
//                         value: booking.hotel_name,
//                       ),
//                       buildItem(
//                         title: 'Номер',
//                         value: booking.room,
//                       ),
//                       buildItem(
//                         title: 'Питание',
//                         value: booking.nutrition,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Form(
//                   key: formKey,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         vertical: Dimens.smallMargin),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimens.midMargin),
//                       color: Colors.white,
//                     ),
//                     padding: const EdgeInsets.all(Dimens.midMargin),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const Text(
//                           'Информация о покупателе',
//                           style: TextStyles.big,
//                         ),
//                         const SizedBox(height: 20),
//                         KTextField(
//                           label: 'Номер телефона',
//                           textEditingController: phoneCtrl,
//                           textInputType: TextInputType.number,
//                           inputFormatters: [phoneMask],
//                           prefixText: '+7 ',
//                           hintText: '(***) ***-**-**',
//                           validator: fieldIsPhone,
//                           // kFormValidator: kFormValidator,
//                         ),
//                         const SizedBox(height: Dimens.smallMargin),
//                         // Container(
//                         //   height: 52,
//                         //   color: Colors.green,
//                         // ),
//                         // const SizedBox(height: Dimens.smallMargin),
//                         KTextField(
//                           label: 'Почта',
//                           textEditingController: emailCtrl,
//                           validator: fieldIsEmail,
//                           // kFormValidator: kFormValidator,
//                         ),
//                         const SizedBox(height: Dimens.smallMargin),
//                         const Text(
//                           'Эти данные никому не передаются. После оплаты мы вышлим чек на указанный вами номер и почту',
//                           style: TextStyles.subtitleGrey,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: tourists.map((e) {
//                     return Padding(
//                       padding:
//                           const EdgeInsets.only(bottom: Dimens.smallMargin),
//                       child: TouristWidget(
//                         touristFormModel: e,
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 Container(
//                   height: 58,
//                   margin: const EdgeInsets.only(bottom: Dimens.smallMargin),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimens.midMargin),
//                     color: Colors.white,
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(Dimens.midMargin),
//                       onTap: addTourist,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: Dimens.midMargin),
//                         child: Row(
//                           children: [
//                             const Expanded(
//                               child: Text(
//                                 'Добавить туриста',
//                                 style: TextStyles.big,
//                               ),
//                             ),
//                             Container(
//                               height: 32,
//                               width: 32,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: AppColors.blue,
//                               ),
//                               child: const Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                                 size: 24,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: Dimens.midMargin,
//                     vertical: 12,
//                   ),
//                   child: SizedBox(
//                     height: 48,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: pay,
//                       child: const Text(
//                         'Оплатить 198 036 ₽',
//                         style: TextStyles.regularBolder,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         return Container();
//       }),
//     );
//   }

//   buildItem({String title = '', String value = ''}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: Dimens.midMargin),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               title,
//               style: TextStyles.regularGrey,
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: TextStyles.regular,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
