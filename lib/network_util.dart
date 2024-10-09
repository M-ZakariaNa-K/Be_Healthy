import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_system_app/alert.dart';
import 'package:tracking_system_app/helpers/helpers.dart';
import 'package:tracking_system_app/modules/home/controller/home_controller.dart';
import 'package:tracking_system_app/routes/app_pages.dart';
import 'package:tracking_system_app/shared/shared.dart';
import 'package:tracking_system_app/style/app_var.dart';

class $ {
  static String? token1;
  // static String? role;
  // static const int _RESPONSE_STATUS_AUTHORIZATION_ERROR = 401;
  //change th the endpoint ZAK============================

  static String _URL = "https://api.behealthy-dxb.com/api";
  static String BASE_URL = "https://api.behealthy-dxb.com";

  static Future<dynamic> getQrScan(String url,
      {bool redirectIfAuthFail = true}) async {
    try {
      var response = await Dio().get(url,
          options: Options(
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Accept': 'application/json',
                'language': AppVar
                    .LANG_CODE, // It's too important to pass empty string if null so server returns ip lang,
                'Authorization': 'Bearer $token1',
                'mobile-agent': '1',
                // 'version-number': AppVar.VERSION_NUMBER.toString(),
              },
              validateStatus: (v) {
                return v != null && v >= 200 && v <= 420;
              }));
      print('responsess: ${response}');
      print('token1: ${token1}');
      print('logint: ${sharedLoginToken}');
      // if (response.statusCode == _RESPONSE_STATUS_AUTHORIZATION_ERROR)
      // return resetUser(redirect: redirectIfAuthFail);
      return responseHandler(response);
    } catch (e) {
      Alert.hideProgress();
      //Alert.toast("Error connecting server! try again later.");
      return null;
    }
  }

  static Future<dynamic> get(String url,
      {bool redirectIfAuthFail = true}) async {
    try {
      var response = await Dio().get(resolveUrl(url),
          options: Options(
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Accept': 'application/json',
                'language': AppVar
                    .LANG_CODE, // It's too important to pass empty string if null so server returns ip lang,
                'Authorization': 'Bearer $token1',
                'mobile-agent': '1',
                // 'version-number': AppVar.VERSION_NUMBER.toString(),
              },
              validateStatus: (v) {
                return v != null && v >= 200 && v <= 430;
              }));
      // if (response.statusCode == _RESPONSE_STATUS_AUTHORIZATION_ERROR) {
      //   return resetUser(redirect: redirectIfAuthFail);
      // }
      return responseHandler(response);
    } catch (e) {
      Alert.hideProgress();
      //Alert.toast("Error connecting server! try again later.");
      return null;
    }
  }

  static Future<dynamic> post(String url, {Map<String, dynamic>? body}) async {
    try {
      var form = FormData.fromMap(body ?? {}, ListFormat.multiCompatible);
      var response = await Dio().post(resolveUrl(url),
          data: form,
          options: Options(
              headers: {
                // 'Content-Type': 'application/json; charset=utf-8',
                'Accept': 'application/json',
                'language': AppVar
                    .LANG_CODE, // It's too important to pass empty string if null so server returns ip lang,
                'Authorization': 'Bearer $token1',
                'mobile-agent': '1',
                'version-number': AppVar.VERSION_NUMBER.toString(),
              },
              validateStatus: (v) {
                return v != null && v >= 200 && v <= 430;
              }));
      // print(response);
      //================Zak edition =================

      // if (response.statusCode == _RESPONSE_STATUS_AUTHORIZATION_ERROR)
      // return resetUser();
      return responseHandler(response);
    } catch (e) {
      Alert.hideProgress();
      //if i have a network(internet) error while i login
      if (token1 == "" || token1 == null) {
        Get.back();
      }

      log("Error ${e.toString()}");
      Alert.toast("Error connecting server! try again later.");
      return null;
    }
  }

  static Future<dynamic> postFile(String url, String filePath,
      {String? fileName, Map<String, dynamic>? body}) async {
    try {
      var form = FormData.fromMap(body ?? {}, ListFormat.multiCompatible);
      form.files.add(MapEntry(
          fileName ?? 'image', await MultipartFile.fromFile(filePath)));
      var response = await Dio().post(resolveUrl(url),
          data: form,
          options: Options(
              headers: {
                'Accept': 'application/json',
                'language': AppVar
                    .LANG_CODE, // It's too important to pass empty string if null so server returns ip lang,
                'Authorization': 'Bearer $token1',
                'mobile-agent': '1',
                // 'version-number': AppVar.VERSION_NUMBER.toString(),
              },
              validateStatus: (v) {
                return v != null && v >= 200 && v <= 420;
              }));
      log("${response.statusCode}");
      //================Zak edition =================

      // if (response.statusCode == _RESPONSE_STATUS_AUTHORIZATION_ERROR)
      //   return resetUser();

      return responseHandler(response);
    } catch (e) {
      Alert.hideProgress();
      log("Error ${e.toString()}");
      Alert.toast("Error connecting server! try again later.");
      return null;
    }
  }

  static Future<dynamic> delete(String url) async {
    try {
      var response = await Dio().delete(resolveUrl(url),
          options: Options(
              headers: {
                'Content-Type': 'application/json; charset=utf-8',
                'Accept': 'application/json',
                'language':
                    'en', // It's too important to pass empty string if null so server returns ip lang,
                'Authorization': 'Bearer $token1',
                'mobile-agent': '1',
                // 'version-number': AppVar.VERSION_NUMBER.toString(),
              },
              validateStatus: (v) {
                return v != null && v >= 200 && v <= 420;
              }));
      //================Zak edition =================
      // if (response.statusCode == _RESPONSE_STATUS_AUTHORIZATION_ERROR)
      //   return resetUser();

      return responseHandler(response);
    } catch (e) {
      Alert.hideProgress();
      //Alert.toast("Error connecting server! try again later.");
      return null;
    }
  }

  static dynamic responseHandler(Response<dynamic> response) {
    final int? statusCode = response.statusCode;
    Alert.hideProgress();
    if (statusCode == 400) {
      dynamic body = response.data;
      Alert.infoDialog(message: body['message']);
    }
    //========zak edit
    else if (statusCode == 401 && (token1 == "" || token1 == null)) {
      Get.back();
      dynamic body = response.data;
      Alert.infoDialog(
          message: "${body['message']}. Check your phone number or password");
    } else if (statusCode == 401 && (token1 != "" || token1 != null)) {
      print(token1);
      dynamic body = response.data;
      Alert.infoDialog(message: "${body['message']}.");
//TO LOG OUT IF I HAVE THIS MESSAGE DURING USE THE APP
      if (body['message'] == "Unauthenticated") {
        resetUser();
      }
    } else if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return response.data;
    } else if (statusCode == 408) {
      Alert.infoDialog(
          message: tr(
              'Update required! please to update this application to the latest version'));
    } else if (statusCode == 411) {
      alertAndExit(tr('Your account is not yet linked or not activiated!'));
      //ZAKARIA EDITION
    } else if (statusCode == 422) {
      dynamic body = response.data;

      if (body['message'] != null && body['message'].isNotEmpty) {
        // Case when the response has a 'message' field
        Alert.infoDialog(message: "${body['message']}");
      } else {
        Alert.toast("Error connecting server! try again later.");
      }
    } else {
      log(response.data.toString());
      Alert.infoDialog(
          message: tr('Unknown error occurred! please try again later.'));
    }
    return null;
  }

  static resetUser({bool redirect = true}) async {
    dynamic response = await post('users/logout');
    //IF THERE IS NO INTERNET
    if (response == null) {
      return;
    }
    SharedPreferences.getInstance().then((_pref) {
      _pref.remove('token');
      sharedLoginToken = null;
    });
    token1 = "";
    // role = "";
    if (redirect) {
      Get.delete<HomeController>();
      Get.offAllNamed(Routes.LOGIN);
      // if (response["code"] == 200) {
      Alert.toast('Logged out successfully');
      // }
    }

    return null;
  }

  static Future setConnectionParams(
      {required String token, required String userRole}) async {
    _URL = "https://api.behealthy-dxb.com/api";
    BASE_URL = "https://api.behealthy-dxb.com";

    token1 = token;
    // role = userRole;

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('token', token1!);
    return;
  }

  // static Future<bool> loadConnectionParams() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   if (_pref.containsKey('token')) {
  //     _token = _pref.getString('token');
  //     var test = await get('notifications',
  //         redirectIfAuthFail: false); //JUST FOR TEST TOKEN
  //     if (test != null) return true;
  //   }
  //   return false;
  // }

  static void alertAndExit(String message) async {
    await Alert.confirmDialog(message: message, onOk: () async {});
  }

  // static Future flipIfDemo({String? email}) async {
  //   // bool enabled = false;
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // if (email != null) {
  //   //   enabled = email.contains('solutions-time.com');
  //   // } else if (prefs.containsKey('demo')) {
  //   //   enabled = prefs.getBool('demo')!;
  //   // }

  //   // if (!enabled) {
  //     //change th the endpoint ZAK============================
  //     _URL = "https://behealthy.test/api";
  //     BASE_URL = "https://behealthy.test";
  //   // } else {
  //     // _URL = "https://behealthy.test/api";
  //     // BASE_URL = "https://behealthy.test";
  //     // Alert.toast('Demo mode enabled');
  //   // }

  //   // prefs.setBool('demo', enabled);
  // }

  static String resolveUrl(String url) {
    url = url[0] == '/' ? url.substring(1) : url;
    return url.contains('https') ? url : (_URL + '/' + url);
  }
}
