import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/toprated_movie_res_model.dart';


class TopRatedMovieController extends GetxController {
  Rx<TopRatedMovieResponse> topratedData = TopRatedMovieResponse().obs;

  Future<void> onInit() async {
    super.onInit();
    await gettopratedmovie(refresh: true);
  }

  Future gettopratedmovie({required refresh}) async {
    final response = await http.get(
      Uri.parse("https://api.themoviedb.org/3/movie/top_rated"),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmZiZjkwOWMzYmFhYmEzN2Q3N2NmZWFlYjc0ODJmMCIsInN1YiI6IjYzNGMzZGM2YzE3NWIyMDA4MmRkNzUzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aFanxRKoxHAzJWL2uNfqXJr8FrcoR9xct4ydvi6qXHg',
        "Content-Type":"application/json;charset=utf-8"
      },

    );
    topratedData.value = TopRatedMovieResponse.fromJson(jsonDecode(response.body));

  }
}