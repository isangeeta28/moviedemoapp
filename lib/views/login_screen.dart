import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apptext_field.dart';
import 'home_tabb_bar_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding:  EdgeInsets.only(left: Get.width*0.06, right: Get.width*0.04, top: Get.height*0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.01),
                  Text('Log in',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black,
                    ),),
                  SizedBox(height: Get.height*0.02),
                  Text('Welcome back, enter your details to access your account.',
                    maxLines: 2,
                    strutStyle: StrutStyle(
                        height: 1.8
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),),
                  SizedBox(height: Get.height*0.03,),
                  AppTextField(
                      hintText: "Email",
                  ),
                  SizedBox(height: Get.height*0.045,),
                  AppTextField(
                    hintText: "Password",
                  ),
                  SizedBox(height: Get.height*0.06,),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=> HomeTabbarScreen());
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        height: Get.width * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height*0.01,),
                  Center(
                    child: TextButton(
                        onPressed: (){

                        },
                        child:  Text("Forgot Password",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black))
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
