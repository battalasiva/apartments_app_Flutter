import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class PurchasePlanDataSource {
  final ApiClient apiClient;

  PurchasePlanDataSource({required this.apiClient});

  Future<String> purchasePlan(String apartmentId, int months) async {
    final endpoint = "${ApiUrls.purchasePlan}/$apartmentId?months=$months";
    final response = await apiClient.post(endpoint, {});
    debugPrint("RESPONCE : ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      final errorData = jsonDecode(response.body);
      final errorCode = errorData['errorCode'] ?? 'Unknown error code';
      final errorMessage = errorData['errorMessage'] ?? 'Unknown error message';
      String userMessage;
      switch (errorCode) {
        case 1042:
          userMessage = "Not enough coins for this transaction.";
          break;
        default:
          userMessage = errorMessage;
      }
      return userMessage;
    }
  }
}
