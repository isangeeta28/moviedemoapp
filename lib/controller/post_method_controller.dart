import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class  PostMethodController extends GetxController{

  Future<void> onInit() async {
    super.onInit();
    await getmovieData(refresh: true);
  }

  Future getmovieData({required refresh}) async {
    final response = await http.post(
      Uri.parse("https://api.themoviedb.org/3/movie/popular"),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmZiZjkwOWMzYmFhYmEzN2Q3N2NmZWFlYjc0ODJmMCIsInN1YiI6IjYzNGMzZGM2YzE3NWIyMDA4MmRkNzUzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aFanxRKoxHAzJWL2uNfqXJr8FrcoR9xct4ydvi6qXHg',
        "Content-Type":"application/json;charset=utf-8"
      },
      body: jsonEncode({
        "movie": "title"
      }),
    );

    var moviedata = jsonDecode(response.body);

  }
}