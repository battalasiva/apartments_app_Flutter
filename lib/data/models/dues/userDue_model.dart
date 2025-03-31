import 'dart:convert';

class UserDuesModal {
  final int id;
  final String dueDate;
  final int apartmentId;
  final int flatId;
  final double cost;
  final double fixedCost;
  final String status;
  final List<MaintenanceDetail> maintenanceDetails;

  UserDuesModal({
    required this.id,
    required this.dueDate,
    required this.apartmentId,
    required this.flatId,
    required this.cost,
    required this.fixedCost,
    required this.status,
    required this.maintenanceDetails,
  });

  factory UserDuesModal.fromJson(Map<String, dynamic> json) {
    return UserDuesModal(
      id: json['id'],
      dueDate: json['dueDate'],
      apartmentId: json['apartmentId'],
      flatId: json['flatId'],
      cost: json['cost'],
      fixedCost: json['fixedCost'],
      status: json['status'],
      maintenanceDetails: (jsonDecode(json['maintenanceDetails']) as List)
          .map((item) => MaintenanceDetail.fromJson(item))
          .toList(),
    );
  }

  static List<UserDuesModal> fromJsonList(dynamic jsonDecode) {
    final parsed = jsonDecode as List<dynamic>;
    return parsed.map((json) => UserDuesModal.fromJson(json)).toList();
  }
}

class ConfigRange {
  final int id;
  final double costPerUnit, startRange;
  final double? endRange; 

  ConfigRange({
    required this.id,
    required this.costPerUnit,
    required this.startRange,
    this.endRange,
  });

  factory ConfigRange.fromJson(Map<String, dynamic> json) {
    return ConfigRange(
      id: json['id'],
      costPerUnit: json['costPerUnit'],
      startRange: json['startRange'],
      endRange: json['endRange'],
    );
  }
}

class MaintenanceDetail {
  final int? prepaidMeterId;
  final double? costPerUnit,previousReading,unitsConsumed,currentReading;
  final String? name;
  final List<ConfigRange>? configRangeList;
  

  MaintenanceDetail({
    this.prepaidMeterId,
    this.costPerUnit,
    this.unitsConsumed,
    this.name,
    this.previousReading,
    this.currentReading,
    this.configRangeList,
  });

  factory MaintenanceDetail.fromJson(Map<String, dynamic> json) {
    return MaintenanceDetail(
      prepaidMeterId: json['prepaidMeterId'],
      costPerUnit: json['costPerUnit'],
      unitsConsumed: json['unitsConsumed'],
      name: json['name'],
      previousReading:json['previousReading'],
      currentReading:json['currentReading'],
      configRangeList: json['configRangeList'] != null
          ? (json['configRangeList'] as List)
              .map((e) => ConfigRange.fromJson(e))
              .toList()
          : null,
    );
  }
}

List<UserDuesModal> parseUserDuesResponse(String responseBody) {
  final parsed = json.decode(responseBody) as List<dynamic>;
  return parsed.map((json) => UserDuesModal.fromJson(json)).toList();
}
