// 도서 모든 페이지의 Bottom NavigationBar
import 'package:book_project/screen/book/book_community.dart';
import 'package:book_project/screen/book/book_my_diary.dart';
import 'package:book_project/screen/book/book_my_goal.dart';
import 'package:book_project/screen/book/book_search_recommend.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:book_project/screen/book/configuration.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class BookFluidNavBar extends StatefulWidget {
  Widget route;
  int routeIndex;

  BookFluidNavBar({
    Key? key,
    required this.route,
    required this.routeIndex,
  }) : super(key: key);

  @override
  State<BookFluidNavBar> createState() => _BookFluidNavBarState();
}

class _BookFluidNavBarState extends State<BookFluidNavBar> {
  // Widget? _child = null;

  @override
  void initState() {
    // _child = BookSearchRecommend();
    print("book fluid nav bar initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("book fluid nav bar state 종료");
    super.dispose();
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: widget.route,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
              icon: Icons.search,
              backgroundColor: Colors.purple[400],
              extras: {"label": "BookSearchRecommend"},
            ),
            FluidNavBarIcon(
              icon: Icons.golf_course_sharp,
              backgroundColor: Colors.purple[400],
              extras: {"label": "BookMyGoal"},
            ),
            FluidNavBarIcon(
              icon: Icons.create_rounded,
              backgroundColor: Colors.purple[400],
              extras: {"label": "BookMyDiary"},
            ),
            FluidNavBarIcon(
              icon: Icons.chat_rounded,
              backgroundColor: Colors.purple[400],
              extras: {"label": "BookCommunity"},
            ),
            FluidNavBarIcon(
              icon: Icons.settings,
              backgroundColor: Colors.purple[400],
              extras: {"label": "Configuration"},
            ),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white60,
          ),
          scaleFactor: 1.5,
          defaultIndex: widget.routeIndex,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          widget.route = BookSearchRecommend();
          widget.routeIndex = 0;
          break;
        case 1:
          widget.route = BookMyGoal();
          widget.routeIndex = 1;
          break;
        case 2:
          widget.route = BookMyDiary();
          widget.routeIndex = 2;
          break;
        case 3:
          widget.route = const BookCommunity();
          widget.routeIndex = 3;
          break;
        case 4:
          widget.route = Configuration();
          widget.routeIndex = 4;
          break;
      }
      widget.route = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: widget.route,
      );
    });
  }
}
