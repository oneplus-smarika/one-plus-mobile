import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/ads_widget.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/date_place_select_widget.dart';
import '../../data/model/bus_list_model.dart';
import '../widgets/bus_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(AppAssets.appLogo)),
            AppSpacing.horizontalSpaceMedium,
            CText("Bus App Yatayat", type: TextType.titleMedium),
          ],
        ),
        actions: [
          Icon(Icons.person_outline, color: AppColors.mainColor, size: 32),
          AppSpacing.horizontalSpaceAverage,
        ],
      ),
      body: ListView(
        children: [
          /// Promo Card
          AdsWidget(),
          AppSpacing.verticalSpaceLarge,

          /// From - To Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ReusableButton(
                    borderRadiusCust: BorderRadius.circular(12),
                    borderColor: AppColors.gray300,
                    backgroundColor: AppColors.cardColor,
                    textColor: AppColors.gray900,
                    btnIcon: const Icon(Icons.location_on),
                    text: 'Kathmandu',
                    onPressed: () {},
                  ),
                ),
                AppSpacing.horizontalSpaceSmall,
                const Icon(Icons.swap_horiz, color: AppColors.gray700),
                AppSpacing.horizontalSpaceSmall,
                Expanded(
                  child: ReusableButton(
                    borderRadiusCust: BorderRadius.circular(12),
                    borderColor: AppColors.gray300,
                    backgroundColor: AppColors.cardColor,
                    textColor: AppColors.gray900,
                    btnIcon: const Icon(Icons.location_on),
                    text: 'Biratnagar',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.verticalSpaceMedium,

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
    );
  }
}
