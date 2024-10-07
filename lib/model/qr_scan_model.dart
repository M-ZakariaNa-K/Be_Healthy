class QrScanModel {
  int code;
  String message;
  QrScanDataModel data;

  QrScanModel({
    required this.code,
    required this.message,
    required this.data,
  });

  // Factory constructor for creating a QrScanModel from JSON
  factory QrScanModel.fromJson(Map<String, dynamic> json) {
    return QrScanModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: QrScanDataModel.fromJson(json['data']),
    );
  }

  // Method to convert QrScanModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class QrScanDataModel {
  String customerName;
  int bagId;
  String newState;

  QrScanDataModel({
    required this.customerName,
    required this.bagId,
    required this.newState,
  });

  // Factory constructor for creating a Data object from JSON
  factory QrScanDataModel.fromJson(Map<String, dynamic> json) {
    return QrScanDataModel(
      customerName: json['customer_name'] as String,
      bagId: json['bag_id'] as int,
      newState: json['new_state'] as String,
    );
  }

  // Method to convert Data object to JSON
  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'bag_id': bagId,
      'new_state': newState,
    };
  }
}
