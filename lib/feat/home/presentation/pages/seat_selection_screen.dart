import 'package:flutter/material.dart';
import 'package:oneplus_app/core/core.dart';
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Bus info
                  AppSpacing.verticalSpaceVeryLarge,
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: AppColors.black),
                      ),
                      Column(
                        children: [
                          CText(
                            "Select Seats",
                            type: TextType.titleLarge,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          const CText("One Plus Yatayat", type: TextType.titleMedium),
                        ],
                      ),
                    ],
                  ),
                  Divider(thickness: 0.5),
                  AppSpacing.verticalSpaceAverage,
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      AppSpacing.horizontalSpaceTiny,
                      CText(
                        "Kathmandu to Biratnagar",
                        type: TextType.bodyLarge,
                        color: AppColors.black,
                      ),
                      Spacer(),
                      Chip(
                        backgroundColor: AppColors.gray200,
                        label: Text("20th June"),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpaceTiny,
                  Row(
                    children: [
                      const CText(
                        "KTM 5:00 PM ",
                        type: TextType.bodyLarge,
                        color: AppColors.black,
                      ),
                      AppSpacing.horizontalSpaceTiny,
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: AppColors.gray700,
                        size: 16,
                      ),
                      AppSpacing.horizontalSpaceTiny,
                      const CText(
                        "Brt 5:00 PM ",
                        type: TextType.bodyLarge,
                        color: AppColors.black,
                      ),
                    ],
                  ),

                  const Divider(thickness: 0.5),
                  AppSpacing.verticalSpaceMedium,

                  /// Seat Layout
                  SeatLayout(
                    legendCardColor: AppColors.white,
                    busLayoutCardColor: AppColors.white,
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
                    initialSelectedSeats: ["seat_5"],

                    onSeatSelectionChanged: (seats) {
                      setState(() {
                        selectedSeats = seats;
                      });
                    },
                  ),

                  AppSpacing.verticalSpaceLarge,
                ],
              ),
            ),
          ),

          /// Selected seats summary section (added based on screenshot)
          if (selectedSeats.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CText(
                          "${selectedSeats.map((s) => s.seatNumber).join(", ")} (${selectedSeats.length} seats)",
                          type: TextType.bodyMedium,
                          color: AppColors.gray700,

                        ),
                      ),
                      CText(
                        "Total Amount",
                        type: TextType.bodyMedium,
                        color: AppColors.gray700,
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpaceMedium,
                  ReusableButton(text: "Continue to Passenger Details", onPressed: (){}),
                  AppSpacing.verticalSpaceMedium,
                ],
              ),
            ),
        ],
      ),
    );
  }
}
