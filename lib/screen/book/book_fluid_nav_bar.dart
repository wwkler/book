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
  BookFluidNavBar({Key? key}) : super(key: key);

  @override
  State<BookFluidNavBar> createState() => _BookFluidNavBarState();
}

class _BookFluidNavBarState extends State<BookFluidNavBar> {
  Widget? _child = null;

  @override
  void initState() {
    _child = BookSearchRecommend();
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
        body: _child,
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
            FluidNavBarIcon(
              icon: Icons.settings,
              backgroundColor: Colors.purple[400],
              extras: {"label": "BookShowPreview"},
            ),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.white60,
          ),
          scaleFactor: 1.5,
          defaultIndex: 0,
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
          _child = BookSearchRecommend();
          break;
        case 1:
          _child = BookMyGoal();
          break;
        case 2:
          _child = BookMyDiary();
          break;
        case 3:
          _child = BookCommunity();
          break;
        case 4:
          _child = Configuration();
          break;
        case 5:
          _child = BookShowPreview();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
