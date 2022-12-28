import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.999,
      width: Get.width*0.9999,
      color: Colors.white,
    );
  }
}
