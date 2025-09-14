import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneplus_app/core/core.dart';
import 'package:oneplus_app/feat/home/presentation/pages/payment_page.dart';
import 'package:oneplus_app/feat/home/presentation/widgets/important_notes.dart';
import '../controller/passenger_details_controller.dart';
import '../widgets/passenger_form.dart';

class PassengerDetailsPage extends ConsumerStatefulWidget {
  final List<String> selectedSeats;

  const PassengerDetailsPage({super.key, required this.selectedSeats});

  @override
  ConsumerState<PassengerDetailsPage> createState() =>
      _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends ConsumerState<PassengerDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(passengerDetailsProvider.notifier);
      controller.initControllers(widget.selectedSeats.length);
    });
  }

  @override
  void dispose() {
    final controller = ref.read(passengerDetailsProvider.notifier);
    controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(passengerDetailsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              "Passenger Details",
              type: TextType.headlineSmall,
              textAlign: TextAlign.left,
            ),
            CText(
              "${widget.selectedSeats.length} Passengers",
              type: TextType.bodyMedium,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBackNavigation(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTripDetailsSection(),

          AppSpacing.verticalSpaceMedium,
          Divider(color: AppColors.gray300),

          ...List.generate(widget.selectedSeats.length, (index) {
            return PassengerForm(
              passengerIndex: index + 1,
              seatNumber: widget.selectedSeats[index],
            );
          }),

          AppSpacing.verticalSpaceLarge,
          ImportantNotes(),
          AppSpacing.verticalSpaceLarge,
        ],
      ),
      bottomNavigationBar:
          widget.selectedSeats.isNotEmpty
              ? _buildBottomNavigationBar(controller)
              : const SizedBox(),
    );
  }

  Widget _buildTripDetailsSection() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_outlined, color: AppColors.gray700),
            AppSpacing.horizontalSpaceTiny,
            Expanded(
              child: CText(
                "Kathmandu to Biratnagar ",
                type: TextType.titleMedium,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CText(
                  "KTM 4:00 PM",
                  type: TextType.bodyLarge,
                  color: AppColors.gray700,
                ),
                AppSpacing.horizontalSpaceTiny,
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: AppColors.gray700,
                  size: 16,
                ),
                AppSpacing.horizontalSpaceTiny,
                CText(
                  "BIR 5:00 AM",
                  type: TextType.bodyLarge,
                  color: AppColors.gray700,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            CText(
              "Selected Seats:",
              type: TextType.bodyLarge,
              color: AppColors.gray700,
            ),
            AppSpacing.horizontalSpaceSmall,
            ...widget.selectedSeats.map(
              (seat) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Chip(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  label: CText(
                    seat,
                    type: TextType.bodyMedium,
                    color: AppColors.gray700,
                  ),
                  backgroundColor: AppColors.cardColor,
                  side: const BorderSide(color: AppColors.gray300),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(PassengerDetailsController controller) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  "Total Amount",
                  type: TextType.titleMedium,
                  fontWeight: FontWeight.w600,
                ),
                CText(
                  "NPR ${controller.calculateTotalAmount(widget.selectedSeats).toInt()}",
                  type: TextType.titleLarge,
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
                    controller.getPassengerSummary(widget.selectedSeats),
                    type: TextType.bodyMedium,
                    color: AppColors.gray700,
                  ),
                ),
                const CText(
                  "Including all taxes",
                  type: TextType.bodyMedium,
                  color: AppColors.gray700,
                ),
              ],
            ),
            AppSpacing.verticalSpaceMedium,
            ReusableButton(
              text: "Continue to Payment",
              width: double.infinity,
              onPressed: () => _handleContinueToPayment(controller),
            ),
          ],
        ),
      ),
    );
  }

  void _handleContinueToPayment(PassengerDetailsController controller) {
    final validationResult = controller.validatePassengerDetails(
      widget.selectedSeats,
      ref,
    );

    if (!validationResult.isValid) {
      AppMethods.showCustomSnackBar(
        context: context,
        message: validationResult.errorMessage!,
      );
      return;
    }

    final passengerDetails = controller.collectPassengerDetails(
      widget.selectedSeats,
      ref,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PaymentPage(
              selectedSeats: widget.selectedSeats,
              passengerDetails: passengerDetails,
              route: "Kathmandu to Biratnagar",
              departureTime: "KTM 5:00 PM",
              arrivalTime: "BIR 6:00 AM",
              date: "20th June",
            ),
      ),
    );
  }

  void _handleBackNavigation() {
    final controller = ref.read(passengerDetailsProvider.notifier);

    if (controller.hasUnsavedChanges(widget.selectedSeats, ref)) {
      _showUnsavedChangesDialog();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showUnsavedChangesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CText(
            "Unsaved Changes",
            type: TextType.titleLarge,
            fontWeight: FontWeight.w600,
          ),
          content: CText(
            "You have unsaved passenger details. Are you sure you want to go back?",
            type: TextType.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CText(
                "Cancel",
                type: TextType.bodyMedium,
                color: AppColors.gray700,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: CText(
                "Go Back",
                type: TextType.bodyMedium,
                color: AppColors.failure,
              ),
            ),
          ],
        );
      },
    );
  }
}

///ToDO price flow mileko chiana
