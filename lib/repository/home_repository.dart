import 'package:flutter/material.dart';
import 'package:mvvm_tech_brothers/data/network/BaseApiServices.dart';
import 'package:mvvm_tech_brothers/data/network/NetworkApiService.dart';
import 'package:mvvm_tech_brothers/model/movies_model.dart';
import 'package:mvvm_tech_brothers/res/app_url.dart';


class HomeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMoviesList() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      // print("response");
      // print(response);
      return response = MovieListModel.fromJson(response);
    } catch(e) {
      throw e;
    }
  }
}