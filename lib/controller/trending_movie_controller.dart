import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/trending_movie_res_model.dart';


class TrendingMovieController extends GetxController {
  Rx<TrendingMovieResponse> trendingmovieData = TrendingMovieResponse().obs;

  Future<void> onInit() async {
    super.onInit();
    await getTrendingmovie(refresh: true);
  }

  Future getTrendingmovie({required refresh}) async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/trending/movie/week"),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmZiZjkwOWMzYmFhYmEzN2Q3N2NmZWFlYjc0ODJmMCIsInN1YiI6IjYzNGMzZGM2YzE3NWIyMDA4MmRkNzUzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aFanxRKoxHAzJWL2uNfqXJr8FrcoR9xct4ydvi6qXHg',
        "Content-Type":"application/json;charset=utf-8"
      },

    );
    var trendingdata = jsonDecode(response.body);
    print(trendingdata);
    trendingmovieData.value = TrendingMovieResponse.fromJson(jsonDecode(response.body));

  }
}