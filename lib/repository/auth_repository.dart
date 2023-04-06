import 'package:mvvm_tech_brothers/data/network/BaseApiServices.dart';
import 'package:mvvm_tech_brothers/data/network/NetworkApiService.dart';
import 'package:mvvm_tech_brothers/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  //For Login //If user have an account
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
      // print("response");
      // print(response);
      return response;
    } catch(e) {
      throw e;
    }
  }

  //For Registering User // Signing Up user // If user don't have an account
  Future<dynamic> signUpApi(dynamic data) async {
    try {
      // dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);
      return response;
    } catch(e) {
      throw e;
    }
  }

}