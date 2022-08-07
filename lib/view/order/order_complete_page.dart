import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/generated/assets.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteSettings prevRoute = ModalRoute.of(context)!.settings;
    final int totalPrice = prevRoute.arguments as int;

    return CustomScaffold(
      appBar: HomeAppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '결제 완료',
              style: GoogleFonts.notoSans(
                fontSize: 30,
                color: const Color(0xFF333333),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 50.0),
            Image.asset(
              Assets.imagesHandclap,
              height: 100,
            ),
            Text(
              '성공적으로\n결제되었어요!',
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: const Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('결제 금액',
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    )),
                Text(
                  '''${NumberFormat.simpleCurrency(
                    name: '',
                    decimalDigits: 0,
                  ).format(totalPrice)}원''',
                  style: GoogleFonts.notoSans(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('결제 일시',
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    )),
                Text(
                  DateFormat('yyyy.MM.dd.HH:mm').format(DateTime.now()),
                  style: GoogleFonts.notoSans(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _onTapConfirm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFDDDDDD),
                  ),
                ),
                child: Text(
                  '확인',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapConfirm() {
    locator<GlobalKey<NavigatorState>>().currentState!.pushNamedAndRemoveUntil(
          AppRoutes.home,
          (route) => false,
        );
  }
}
