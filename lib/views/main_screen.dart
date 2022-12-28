import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../controller/playing_in_thearter_movie_controller.dart';
import '../controller/popular_movie_controller.dart';
import 'package:intl/intl.dart';

import '../controller/top_rated_movie_controller.dart';
import '../controller/trending_movie_controller.dart';
import '../controller/upcoming_movie_controller.dart';
import 'detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //TrendingMovieController trendingMovieController = Get.put(TrendingMovieController());
  PopularMovieController popularmovieCon = Get.put(PopularMovieController());

  LocationData? currentLocation;
  // String address = "";

  @override
  void initState() {
    //context.loaderOverlay.show();
    Future<String> _getAddress(double? lat, double? lang) async {
      if (lat == null || lang == null) return "";
      Address? addresses;
      await GeoCode().reverseGeocoding(latitude: lat, longitude: lang).
      then((val) {
        print(val.city);
        addresses = val;
        setState(() {});
        return val.city??"";

      }).catchError((onError){
        _getAddress(lat,lang);
      });
      setState(() {

      });
      return "${addresses?.city}";
    }

    _getLocation().then((value) {
      LocationData? location = value;
      _getAddress(location?.latitude, location?.longitude)
          .then((value) {
        setState(() {
          currentLocation = location;

        });
        setState(() {

        });
      });
    }
    );
    super.initState();

    // saveeventcon.newcityController.value =  address;
    // print(address);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.menu,
              color: CupertinoColors.activeBlue,),
            ),
            title: Text('Hello SunShine',
            style: TextStyle(color: CupertinoColors.activeBlue),),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.search,
                    color: CupertinoColors.activeBlue,
                  )
              )
            ],
          ),
          body:GetX<PopularMovieController>(
            init: Get.put(PopularMovieController()),
            builder: (popularmovieCon){
              return popularmovieCon.popularovieData.value.results == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                    children: [
                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("What's Popular",
                            style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 19, fontWeight: FontWeight.w600),),
                          Row(
                            children: [
                              Text('View All',
                                  style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 13,fontWeight: FontWeight.w600)),
                              SizedBox(width: Get.width*0.02,),
                              Icon(Icons.arrow_forward_ios_outlined,size: 14,color: CupertinoColors.activeBlue,)
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: Get.height*0.015,),
                    Padding(
                      padding:  EdgeInsets.only(left: Get.width*0.05),
                      child: SizedBox(
                        width: Get.width*0.999,
                        height: Get.height*0.37,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                          itemCount: popularmovieCon.popularovieData.value.results!.length,
                          itemBuilder: (context, i) {
                            final apidate = popularmovieCon.popularovieData.value.results?[i].releaseDate.toString();
                            var date =  apidate;
                            var dateTime =  DateTime.parse("$date");
                            var stdTime =  DateFormat('MMM-dd-yyyy').format(dateTime).toString();
                            var image = "http://image.tmdb.org/t/p/w500${popularmovieCon.popularovieData.value.results?[i].posterPath??""}";
                            return GestureDetector(
                              onTap: (){
                                Get.to(()=>DetailsScreen(
                                    title: popularmovieCon.popularovieData.value.results?[i].title??"",
                                    description: popularmovieCon.popularovieData.value.results?[i].originalTitle??"",
                                  image: image,
                                  date: stdTime
                                ));
                              },
                              child: SizedBox(
                                  height: Get.height*0.33,
                                  width: Get.width*0.35,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Container(
                                       height: Get.height*0.25,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(20),
                                           image: DecorationImage(
                                             image: NetworkImage(image)
                                           )
                                         ),
                                         //child: Image.network(image)
                                     ),
                                      SizedBox(height: Get.height*0.01,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: Get.width*0.02),
                                        child: Text(popularmovieCon.popularovieData.value.results?[i].title??"",
                                          style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(height: Get.height*0.01,),
                                      Padding(
                                        padding:  EdgeInsets.only(left: Get.width*0.02),
                                        child: Text(stdTime,
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            );
                          }
                        ),),
                    ),
                      PlayInTheatre(),
                      TrendingMovie(),

                      TopRated(),
                      UpComingMovie(),
                ],

              ),
                  );
            }
          ),
        ));
  }
}

class TopRated extends StatelessWidget {
  TopRated({Key? key}) : super(key: key);
 // TopRatedMovieController topRatedMovieController = Get.put(TopRatedMovieController());

  @override
  Widget build(BuildContext context) {
    return GetX<TopRatedMovieController>(
        init: Get.put(TopRatedMovieController()),
        builder: (topRatedMovieController){
          return topRatedMovieController.topratedData.value.results == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [

                //top rated movie
                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Top Rated",
                        style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 19, fontWeight: FontWeight.w600),),
                      Row(
                        children: [
                          Text('View All',
                              style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 13,fontWeight: FontWeight.w600)),
                          SizedBox(width: Get.width*0.02,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 14,color: CupertinoColors.activeBlue,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.015,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05),
                  child: SizedBox(
                    width: Get.width*0.999,
                    height: Get.height*0.37,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.04,),
                        itemCount: topRatedMovieController.topratedData.value.results!.length,
                        itemBuilder: (context, i) {
                          final apidate = topRatedMovieController.topratedData.value.results?[i].releaseDate.toString();
                          var date =  apidate;
                          var dateTime =  DateTime.parse("$date");
                          var stdTime =  DateFormat('MMM-dd-yyyy').format(dateTime).toString();
                          var images = "http://image.tmdb.org/t/p/w500${topRatedMovieController.topratedData.value.results?[i].posterPath??""}";
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=>DetailsScreen(
                                  title: topRatedMovieController.topratedData.value.results?[i].title??"",
                                  description: topRatedMovieController.topratedData.value.results?[i].originalTitle??"",
                                  image: images,
                                  date: stdTime
                              ));
                            },
                            child: Container(
                                height: Get.height*0.33,
                                width: Get.width*0.74,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height*0.25,
                                      width: Get.width*0.74,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.0),
                                            topLeft: Radius.circular(20.0),),
                                          image: DecorationImage(
                                              image: NetworkImage(images),fit: BoxFit.fill
                                          )
                                      ),
                                      //child: Image.network(image)
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                        padding:  EdgeInsets.only(left: Get.width*0.02),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Get.width*0.32,
                                              child: Text(topRatedMovieController.topratedData.value.results?[i].title??"",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width*0.33,
                                              child: RatingBar.builder(
                                                initialRating: topRatedMovieController.topratedData.value.results?[i].voteAverage??3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22.0,
                                                itemPadding: EdgeInsets.all(1),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.amber,size: 4,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.02),
                                      child: Text("Genre",
                                        style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          );
                        }
                    ),),
                ),
              ],
            ),
          );
        }
    );
  }
}

class UpComingMovie extends StatelessWidget {
  const UpComingMovie({Key? key}) : super(key: key);
  // UpComingMovieController upComingMovieController = Get.put(UpComingMovieController());


  @override
  Widget build(BuildContext context) {
    return GetX<UpComingMovieController>(
        init: Get.put(UpComingMovieController()),
        builder: (upComingMovieController){
          return upComingMovieController.upomingmovieData.value.results == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcommig",
                        style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 19, fontWeight: FontWeight.w600),),
                      Row(
                        children: [
                          Text('View All',
                              style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 13,fontWeight: FontWeight.w600)),
                          SizedBox(width: Get.width*0.02,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 14,color: CupertinoColors.activeBlue,)
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.015,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05),
                  child: SizedBox(
                    width: Get.width*0.999,
                    height: Get.height*0.37,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                        itemCount: upComingMovieController.upomingmovieData.value.results!.length,
                        itemBuilder: (context, i) {
                          final apidate = upComingMovieController.upomingmovieData.value.results?[i].releaseDate.toString();
                          var date =  apidate;
                          var dateTime =  DateTime.parse("$date");
                          var stdTime =  DateFormat('MMM-dd-yyyy').format(dateTime).toString();
                          var images = "http://image.tmdb.org/t/p/w500${upComingMovieController.upomingmovieData.value.results?[i].posterPath??""}";
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=>DetailsScreen(
                                  title: upComingMovieController.upomingmovieData.value.results?[i].title??"",
                                  description: upComingMovieController.upomingmovieData.value.results?[i].originalTitle??"",
                                  image: images,
                                  date: stdTime
                              ));
                            },
                            child: SizedBox(
                                height: Get.height*0.33,
                                width: Get.width*0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height*0.25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(images)
                                          )
                                      ),
                                      //child: Image.network(image)
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.02),
                                      child: SizedBox(
                                        width: Get.width*0.25,
                                        child: Text(upComingMovieController.upomingmovieData.value.results?[i].title??"",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.02),
                                      child: Text(stdTime,
                                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          );
                        }
                    ),),
                ),
              ],
            ),
          );
        }
    );
  }
}

class TrendingMovie extends StatelessWidget {
  const TrendingMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TrendingMovieController>(
        init: Get.put(TrendingMovieController()),
        builder: (trendingmovieCon){
          return trendingmovieCon.trendingmovieData.value.results == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trending",
                        style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 19, fontWeight: FontWeight.w600),),
                      Row(
                        children: [
                          Text('View All',
                              style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 13,fontWeight: FontWeight.w600)),
                          SizedBox(width: Get.width*0.02,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 14,color: CupertinoColors.activeBlue,)
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.015,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05),
                  child: SizedBox(
                    width: Get.width*0.999,
                    height: Get.height*0.37,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: Get.width*0.02,),
                        itemCount: trendingmovieCon.trendingmovieData.value.results!.length,
                        itemBuilder: (context, i) {
                          final apidate = trendingmovieCon.trendingmovieData.value.results?[i].releaseDate.toString();
                          var date =  apidate;
                          var dateTime =  DateTime.parse("$date");
                          var stdTime =  DateFormat('MMM-dd-yyyy').format(dateTime).toString();
                          var images = "http://image.tmdb.org/t/p/w500${trendingmovieCon.trendingmovieData.value.results?[i].posterPath??""}";
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=>DetailsScreen(
                                  title: trendingmovieCon.trendingmovieData.value.results?[i].title??"",
                                  description: trendingmovieCon.trendingmovieData.value.results?[i].originalTitle??"",
                                  image: images,
                                  date: stdTime
                              ));
                            },
                            child: SizedBox(
                                height: Get.height*0.33,
                                width: Get.width*0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Get.height*0.25,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(images)
                                          )
                                      ),
                                      //child: Image.network(image)
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.02),
                                      child: SizedBox(
                                        width: Get.width*0.25,
                                        child: Text(trendingmovieCon.trendingmovieData.value.results?[i].title??"",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(color: CupertinoColors.activeBlue,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height*0.01,),
                                    Padding(
                                      padding:  EdgeInsets.only(left: Get.width*0.02),
                                      child: Text(stdTime,
                                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          );
                        }
                    ),),
                ),
              ],
            ),
          );
        }
    );
  }
}

class PlayInTheatre extends StatefulWidget {
  const PlayInTheatre({Key? key}) : super(key: key);

  @override
  State<PlayInTheatre> createState() => _PlayInTheatreState();
}

class _PlayInTheatreState extends State<PlayInTheatre> {
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return GetX<PlayinTheartreMovieController>(
        init: Get.put(PlayinTheartreMovieController()),
        builder: (playintheatremovieCon){
          return playintheatremovieCon.playintheartreData.value.results == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: Get.height*0.01,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05, right: Get.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Playing In Theatres",
                        style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 19, fontWeight: FontWeight.w600),),
                      Row(
                        children: [
                          Text('View All',
                              style: TextStyle(color: CupertinoColors.activeBlue,fontSize: 13,fontWeight: FontWeight.w600)),
                          SizedBox(width: Get.width*0.02,),
                          Icon(Icons.arrow_forward_ios_outlined,size: 14,color: CupertinoColors.activeBlue,)
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.015,),
                Padding(
                  padding:  EdgeInsets.only(left: Get.width*0.05),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: playintheatremovieCon.playintheartreData.value.results!.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                          var images = "http://image.tmdb.org/t/p/w500${playintheatremovieCon.playintheartreData.value.results?[itemIndex].posterPath??""}";
                          return Container(
                              width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                          image: NetworkImage(images),fit: BoxFit.fill
                          )));
                        },
                        options: CarouselOptions(
                            autoPlay: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentPos = index;
                              });
                            }
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: playintheatremovieCon.playintheartreData.value.results!.map((url) {
                          int index = playintheatremovieCon.playintheartreData.value.results!.indexOf(url);
                          return Container(
                            width: currentPos == index?18.0:8.0,
                            height: 6.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              //shape: currentPos == index?BoxShape.rectangle:BoxShape.circle,
                              color: currentPos == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
          ),
              ],
            ),
          );
        }
    );
  }
}

class MyImageView extends StatelessWidget{

  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(imgPath),
        )
    );
  }

}

Future<LocationData?> _getLocation() async {
  Location location = new Location();
  LocationData _locationData;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }


  _locationData = await location.getLocation();

  return _locationData;
}




