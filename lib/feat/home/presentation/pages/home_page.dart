import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/pages/notification_page.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/ads_widget.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/date_place_select_widget.dart';
import '../../data/model/bus_list_model.dart';
import '../provider/nav_provider.dart';
import '../widgets/bus_card_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.white,
          backgroundImage: AssetImage(AppAssets.appLogo),
        ),
        title: CText(
          "OnePlus Yatayat App",
          type: TextType.headlineSmall,
          textAlign: TextAlign.left,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              ref.read(navigationProvider.notifier).navigate(3);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const NotificationPage();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppAssets.notifyIcon,
                height: 32,
                width: 32,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.pagePadding),
        child: ListView(
          children: [
            /// Promo Card
            AdsWidget(),
            AppSpacing.verticalSpaceLarge,

            /// From - To Section
            Row(
              children: [
                Expanded(
                  child: ReusableButton(
                    borderRadiusCust: BorderRadius.circular(12),
                    borderColor: AppColors.gray400,
                    backgroundColor: AppColors.cardColor,
                    textColor: AppColors.gray900,
                    btnIcon: SvgPicture.asset(AppAssets.busIcon),
                    text: 'Going from?',
                    onPressed: () {},
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                SvgPicture.asset(AppAssets.backForthIcon),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: ReusableButton(
                    borderRadiusCust: BorderRadius.circular(12),
                    borderColor: AppColors.gray400,
                    backgroundColor: AppColors.cardColor,
                    textColor: AppColors.gray900,
                    btnIcon: SvgPicture.asset(AppAssets.busIcon),
                    text: 'Going to?',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpaceLarge,

            /// Date Place Picker & Search
            DatePlaceSelectWidget(),

            /// Bus Cards
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // so it scrolls with parent ListView
              itemCount: busList.length,
              itemBuilder: (context, index) {
                final bus = busList[index];
                return BusCard(
                  busName: bus.busName,
                  busType: bus.busType,
                  price: bus.price,
                  seatsLeft: bus.seatsLeft,
                  departure: bus.departure,
                  arrival: bus.arrival,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
