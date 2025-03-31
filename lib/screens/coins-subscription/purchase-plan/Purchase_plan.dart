import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/coins-subscription/purchase-plan/bloc/purchase_plan_bloc.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class PurchasePlan extends StatefulWidget {
  const PurchasePlan({
    super.key,
    required this.apartmentID,
    required this.months,
    required this.coins,
    required this.balance,
  });

  final int apartmentID;
  final int months;
  final double coins;
  final double balance;

  @override
  State<PurchasePlan> createState() => _PurchasePlanState();
}

class _PurchasePlanState extends State<PurchasePlan> {
  bool isProcessing = false;

  // Method to call API when button is pressed
  Future<void> submitPurchaseDetails() async {
    setState(() {
      isProcessing = true;
    });

    try {
      context.read<PurchasePlanBloc>().add(
            PurchasePlanRequestedEvent(
              apartmentId: widget.apartmentID.toString(),
              months: widget.months,
            ),
          );
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Payment'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan Details
            Text(
              "Plan Details",
              style: txt_14_600.copyWith(color: AppColor.black2),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                width: getWidth(context) * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.blueShade,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Selected Plan : ",
                          style: txt_12_600.copyWith(color: AppColor.black2),
                        ),
                        Text(
                          "Premium",
                          style: txt_14_600.copyWith(color: AppColor.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Duration : ",
                          style: txt_12_600.copyWith(color: AppColor.black2),
                        ),
                        Text(
                          "${widget.months} Months",
                          style: txt_14_600.copyWith(color: AppColor.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Price Details
            Text(
              "Price Details",
              style: txt_14_600.copyWith(color: AppColor.black2),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Required Coins :",
                        style: txt_12_600.copyWith(color: AppColor.black2),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Current Coins Balance :",
                        style: txt_12_600.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.coins}",
                        style: txt_14_600.copyWith(color: AppColor.primaryColor2),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.balance}",
                        style: txt_14_600.copyWith(color: AppColor.primaryColor2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            BlocConsumer<PurchasePlanBloc, PurchasePlanState>(
              listener: (context, state) {
                if (state is PurchasePlanSuccess) {
                  CustomSnackbarWidget(
                    context: context,
                    title: state.result,
                    backgroundColor: AppColor.blue,
                  );
                  Navigator.pop(context);
                } else if (state is PurchasePlanFailure) {
                  CustomSnackbarWidget(
                    context: context,
                    title: state.error,
                    backgroundColor: AppColor.red,
                  );
                }
              },
              builder: (context, state) {
                final isProcessing = state is PurchasePlanLoading;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 20),
                  child: CustomizedButton(
                    label:
                        isProcessing ? 'Processing...' : 'Proceed To Purchase',
                    style: txt_11_500.copyWith(color: AppColor.white),
                    onPressed:
                        isProcessing ? () {} : () => submitPurchaseDetails(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
