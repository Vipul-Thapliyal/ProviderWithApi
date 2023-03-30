import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm_tech_brothers/data/app_exceptions.dart';
import 'package:mvvm_tech_brothers/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {

  //Get Request
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url)
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    // print("responseJson");
    // print(responseJson);
    return responseJson;


  }

  //Post Request
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(
        Uri.parse(url),
        body: data
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    // print("responseJson");
    // print(responseJson);
    return responseJson;
  }

  //Return respone of Api and saves in responseJson var which is above declared
  dynamic returnResponse(http.Response response) {
    switch(response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 500:

      case 404:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException("Error occured while communicating with server" +
        "with staus code" + response.statusCode.toString());
    }
  }
  
}