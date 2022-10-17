import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/popular_movie_res_model.dart';


class PopularMovieController extends GetxController {
  Rx<PopularMovieResponse> popularovieData = PopularMovieResponse().obs;

  Future<void> onInit() async {
    super.onInit();
    await getPopularmovie(refresh: true);
  }

  Future getPopularmovie({required refresh}) async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/popular"),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmZiZjkwOWMzYmFhYmEzN2Q3N2NmZWFlYjc0ODJmMCIsInN1YiI6IjYzNGMzZGM2YzE3NWIyMDA4MmRkNzUzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aFanxRKoxHAzJWL2uNfqXJr8FrcoR9xct4ydvi6qXHg',
        "Content-Type":"application/json;charset=utf-8"
      },
    );
    var populardata = jsonDecode(response.body);
    print(populardata);
    popularovieData.value = PopularMovieResponse.fromJson(jsonDecode(response.body));

  }
}