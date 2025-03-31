import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/TopSnackbarWidget.dart';

class CustomNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color fillColor;
  final BuildContext context;
  final bool border;
  final bool center;
  final bool popup;
  final bool clearOnTap;
  final bool decimalsOnly;

  const CustomNumberTextField({
    Key? key,
    required this.controller,
    required this.context,
    this.hintText = "Enter value",
    this.fillColor = Colors.white,
    this.border = false,
    this.center = false,
    this.popup = false,
    this.clearOnTap = true,
    this.decimalsOnly = false,
  }) : super(key: key);

  void _validateInput(String value) {
    if (value.isNotEmpty) {
      final numValue = num.tryParse(value);
      if (numValue == null || numValue < 0) {
        if (popup) {
          TopSnackbarWidget.showTopSnackbar(
            context: context,
            title: "Warning",
            message: "Please Enter a Proper value",
            backgroundColor: AppColor.orange,
          );
        } else {
          CustomSnackbarWidget(
            context: context,
            title: "Please enter a valid number (0 or greater)",
            backgroundColor: AppColor.orange,
          );
        }
        controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // keyboardType: TextInputType.number,
      textAlign: center ? TextAlign.center : TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      onTap: () {
        if (clearOnTap) {
          controller.clear();
        }
      },
      onChanged: _validateInput,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        border: border
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColor.greyBorder),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
      ),
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
        if (decimalsOnly)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
      ],
    );
  }
}
