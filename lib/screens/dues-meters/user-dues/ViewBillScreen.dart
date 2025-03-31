import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/dues/userDue_model.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/others/Admin_prepaidMeter.dart';

class ViewBillScreen extends StatefulWidget {
  final String? dueDate, status;
  final double? fixedCost,totalCost;
  final List<MaintenanceDetail>? maintenanceDetails;

  const ViewBillScreen(
      {super.key,
      this.maintenanceDetails,
      this.fixedCost,
      this.dueDate,
      this.status,
      this.totalCost});

  @override
  State<ViewBillScreen> createState() => _ViewBillScreenState();
}

class _ViewBillScreenState extends State<ViewBillScreen> {
  late List<MaintenanceDetail> parsedMaintenanceDetails;

  @override
  void initState() {
    super.initState();
    parsedMaintenanceDetails = widget.maintenanceDetails ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Bill'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Cost:',
                          style: txt_12_500.copyWith(color: AppColor.black1)),
                      Text(
                          'RS ${widget.totalCost?.toStringAsFixed(2) ?? "0.00"}',
                          style: txt_15_500.copyWith(color: AppColor.black1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Due Date:',
                          style: txt_12_500.copyWith(color: AppColor.black1)),
                      Text(formatDate(widget.dueDate ?? 'NA'),
                          style: txt_15_500.copyWith(color: AppColor.black1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status:',
                          style: txt_12_500.copyWith(color: AppColor.black1)),
                      Text(widget.status ?? 'NA',
                          style: txt_15_500.copyWith(
                              color: widget.status?.toLowerCase() == 'paid'
                                  ? AppColor.green
                                  : AppColor.red)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Detailed Bill',
                style: txt_14_600.copyWith(color: AppColor.black1)),
            const SizedBox(height: 10),
            Container(
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Monthly Maintenance',
                        style: txt_14_400.copyWith(color: AppColor.black2),
                      ),
                      Text(
                        'Rs ${widget.fixedCost} /-',
                        style: txt_14_400.copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ),
            Expanded(
              child: parsedMaintenanceDetails.isNotEmpty
                  ? ListView.builder(
                      itemCount: parsedMaintenanceDetails.length,
                      itemBuilder: (context, index) {
                        final maintenanceDetail =
                            parsedMaintenanceDetails[index];
                        return Admin_prepaidMeter(
                          meterName: maintenanceDetail.name ?? '',
                          costPerUnit: maintenanceDetail.costPerUnit.toString(),
                          unitsConsumed:
                              maintenanceDetail.unitsConsumed.toString(),
                          previousReading:
                              maintenanceDetail.previousReading?.toString() ??
                                  '0.0',
                          meterCost: (maintenanceDetail.costPerUnit ?? 0.0) *
                              (maintenanceDetail.unitsConsumed ?? 0.0),
                          dueDate: widget.dueDate ?? 'NA',
                          configRangeList: maintenanceDetail.configRangeList
                                  ?.map<Map<String, dynamic>>((config) => {
                                        'startRange': config.startRange,
                                        'endRange': config.endRange,
                                        'costPerUnit': config.costPerUnit,
                                      })
                                  .toList() ??
                              [],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Prepaid meters not configured to this bill",
                        style: txt_14_400.copyWith(color: AppColor.black2),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
