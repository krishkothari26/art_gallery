import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CurvedNavigationBar(height: 58,
        backgroundColor: Color.fromARGB(0, 255, 82, 82),
        buttonBackgroundColor: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 400),
        onTap: navigationTapped,
        items: [
          // BottomNavigationBarItem(
          //   icon:
      Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : mobileBackgroundColor,
            ),
          //   label: '',
          //   backgroundColor: mobileBackgroundColor,
          // ),
          // BottomNavigationBarItem(
          //   icon:
            Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : mobileBackgroundColor,
            ),
          //   label: '',
          //   backgroundColor: mobileBackgroundColor,
          // ),
          // BottomNavigationBarItem(
          //   icon:
            Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : mobileBackgroundColor,
            ),
            // label: '',
            // backgroundColor: mobileBackgroundColor,
          // ),
          // BottomNavigationBarItem(
          //   icon:
            Icon(
              Icons.person,
              color: _page == 3 ? primaryColor : mobileBackgroundColor,
            ),
          //   label: '',
          //   backgroundColor: mobileBackgroundColor,
          // ),
          // BottomNavigationBarItem(
            // icon:
            // Icon(
            //   Icons.person,
            //   color: _page == 4 ? primaryColor : mobileBackgroundColor,
            // ),
          //   label: '',
          //   backgroundColor: mobileBackgroundColor,
          // ),
        ],
      ),
    );
  }
}
