import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  String? title;
  String? description;
  String? image;
  String? date;
  DetailsScreen({Key? key, this.description, this.title, this.image, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Icon(Icons.share, color: Colors.white,size: 19,),
            SizedBox(width: Get.width*0.04,),
            Icon(Icons.bookmark, color: Colors.white,size: 22,),
            SizedBox(width: Get.width*0.06,),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width*0.999,
                height: Get.height*0.49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(image??""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: Get.width*0.08, top: Get.height*0.03),
                child: Container(
                    width: Get.width*0.8,
                    padding: EdgeInsets.only(left: Get.width*0.03),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Colors.orangeAccent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(title??"",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19
                      ),)),
              ),
              Padding(
                padding:  EdgeInsets.only(left: Get.width*0.06, top: Get.height*0.03),
                child: Card(
                  child: SizedBox(
                    height: Get.height*0.07,
                    child: Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.04),
                      child: Row(
                        children: [
                          Text("Release Date : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15
                            ),),
                          Text(date??"",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15
                            ),),
                        ],
                      ),
                    ),
                  )
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: Get.width*0.08, top: Get.height*0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15
                      ),),
                    SizedBox(height: Get.height*0.01,),
                    SizedBox(
                        width: Get.width*0.83,
                        child: Text(description??"",
                          maxLines: 30,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15
                          ),)),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}