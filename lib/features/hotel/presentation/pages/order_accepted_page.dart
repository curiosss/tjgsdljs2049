import 'package:flutter/material.dart';
import 'package:hotel/config/styles/dimens/dimens.dart';
import 'package:hotel/config/styles/text/text_styles.dart';
import 'package:hotel/config/styles/theme/app_colors.dart';

class OrderAcceptedPage extends StatelessWidget {
  const OrderAcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Заказ оплачен',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 94,
                  width: 94,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightGrey,
                  ),
                  child: Image.asset(
                    'assets/images/success_icon.jpg',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    bottom: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Text(
                    'Ваш заказ принят в работу',
                    textAlign: TextAlign.center,
                    style: TextStyles.big,
                  ),
                ),
                const Text(
                  'Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                  textAlign: TextAlign.center,
                  style: TextStyles.regularGrey,
                ),
              ],
            ),
          ),
          PhysicalModel(
            color: Colors.white,
            elevation: 14,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Dimens.midMargin,
                vertical: 12,
              ),
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'Супер!',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
