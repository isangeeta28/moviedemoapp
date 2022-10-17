import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedemoapp/views/setting_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main_screen.dart';
import 'profile_screen.dart';


class HomeTabbarScreen extends StatefulWidget {
  const HomeTabbarScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabbarScreen> createState() => _HomeTabbarScreenState();
}

class _HomeTabbarScreenState extends State<HomeTabbarScreen> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);


  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      SettingsScreen(),
      ProfileScreen()
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.local_movies_rounded),
        title: ("Movies"),
        textStyle: TextStyle(fontWeight: FontWeight.w800),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.movie_creation_outlined),
        title: ("Settings"),
        textStyle: TextStyle(fontWeight: FontWeight.w800),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        textStyle: TextStyle(fontWeight: FontWeight.w800),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
