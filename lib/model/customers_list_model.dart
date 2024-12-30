class CustomerListDataModel {
  int id;
  String name;
  String address;
  String? phone;
  String driverName;
  String state;
  int reservedBags;
  List<int> bags;

  CustomerListDataModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.driverName,
    required this.state,
    required this.reservedBags,
    required this.bags,
  });

  factory CustomerListDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerListDataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String?,
      driverName: json['driver_name'] as String,
      state: json['state'] as String,
      reservedBags: json['reserved_bags'] as int,
      bags: List<int>.from(json['bags'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'driver_name': driverName,
      'state': state,
      'reserved_bags': reservedBags,
      'bags': bags,
    };
  }
}
