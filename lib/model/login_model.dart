// class LoginModel {
//   int code;
//   String message;
//   LoginDataModel data;

//   LoginModel({
//     required this.code,
//     required this.message,
//     required this.data,
//   });

//   // Factory constructor for creating a LoginModel from JSON
//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       code: json['code'],
//       message: json['message'],
//       data: LoginDataModel.fromJson(json['data']),
//     );
//   }

//   // Method to convert LoginModel to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'code': code,
//       'message': message,
//       'data': data.toJson(), 
//     };
//   }
// }

// class LoginDataModel {
//   String token;
//   String role;

//   LoginDataModel({
//     required this.token,
//     required this.role,
//   });

//   // Factory constructor for creating a LoginData from JSON
//   factory LoginDataModel.fromJson(Map<String, dynamic> json) {
//     return LoginDataModel(
//       token: json['token'],
//       role: json['role'],
//     );
//   }

//   // Method to convert LoginData to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'token': token,
//       'role': role,
//     };
//   }
// }
