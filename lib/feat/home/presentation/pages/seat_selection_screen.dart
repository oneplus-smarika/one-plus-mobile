import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/pages/passenger_details_screen.dart';
import 'package:shitead/shitead.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<Seat> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.pagePadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.black,
                            ),
                          ),
                          AppSpacing.horizontalSpaceSmall,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                "Select Seats",
                                type: TextType.headlineSmall,
                                textAlign: TextAlign.left,
                              ),
                              const CText(
                                "One Plus Yatayat",
                                type: TextType.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5),
                      AppSpacing.verticalSpaceAverage,

                      /// Route + Date
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.gray700,
                          ),
                          AppSpacing.horizontalSpaceTiny,
                          CText(
                            "Kathmandu to Biratnagar",
                            type: TextType.titleLarge,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          const Spacer(),
                          Chip(
                            label: CText(
                              "20th Sep",
                              type: TextType.bodyMedium,
                              color: AppColors.gray700,
                            ),
                            backgroundColor: AppColors.cardColor,
                            side: const BorderSide(color: AppColors.gray300),
                          ),
                        ],
                      ),
                      AppSpacing.verticalSpaceTiny,

                      Row(
                        children: [
                          const CText(
                            "KTM 5:00 PM",
                            type: TextType.bodyLarge,
                            color: AppColors.black,
                          ),
                          AppSpacing.horizontalSpaceTiny,
                          const Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.gray700,
                            size: 16,
                          ),
                          AppSpacing.horizontalSpaceTiny,
                          const CText(
                            "BRT 5:00 PM",
                            type: TextType.bodyLarge,
                            color: AppColors.black,
                          ),
                        ],
                      ),

                      const Divider(thickness: 0.5),
                      AppSpacing.verticalSpaceMedium,

                      /// Seat Layout
                      SeatLayout(
                        legendCardColor: AppColors.cardColor,
                        busLayoutCardColor: AppColors.cardColor,
                        numberOfSeats: 32,
                        // 8 rows * 4 seats
                        seatsPerRow: 4,
                        showDriverSeat: true,
                        allowMultipleSelection: true,
                        seatSize: 36,
                        seatSpacing: 4,
                        // booked seats
                        bookedSeats: ["seat_1", "seat_7", "seat_14"],
                        // reserved seats
                        unavailableSeats: ["seat_20"],
                        // already selected by user
                        initialSelectedSeats: [],
                        onSeatSelectionChanged: (seats) {
                          setState(() {
                            selectedSeats = seats;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      ///  Bottom Section
      bottomNavigationBar:
          selectedSeats.isNotEmpty
              ? SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Header row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            "Selected Seats",
                            type: TextType.bodyLarge,
                            fontWeight: FontWeight.bold,
                          ),
                          CText(
                            "NPR ${selectedSeats.length * 2800}",
                            type: TextType.bodyLarge,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      AppSpacing.verticalSpaceTiny,

                      /// Seats summary
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CText(
                              "${selectedSeats.map((s) => s.seatNumber).join(", ")} "
                              "(${selectedSeats.length} seats)",
                              type: TextType.bodyMedium,
                              color: AppColors.gray700,
                            ),
                          ),
                          const CText(
                            "Total Amount",
                            type: TextType.bodyMedium,
                            color: AppColors.gray700,
                          ),
                        ],
                      ),

                      AppSpacing.verticalSpaceMedium,

                      /// Continue Button
                      ReusableButton(
                        text: "Continue to Passenger Details",
                        width: double.infinity,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PassengerDetailsPage(
                                selectedSeats: selectedSeats.map((s) => s.seatNumber).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
              : const SizedBox(),
    );
  }
}
