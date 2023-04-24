// 도서 검색/추천 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/screen/book/book_search_result.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BookSearchRecommend extends StatefulWidget {
  BookSearchRecommend({Key? key}) : super(key: key);

  @override
  State<BookSearchRecommend> createState() => _BookSearchRecommendState();
}

class _BookSearchRecommendState extends State<BookSearchRecommend> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    print("Book Search Recommend InitState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book Search Recommend state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경 이미지
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/background_book1.jpg"),
          fit: BoxFit.fill,
          opacity: 0.3,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AnimSearchBar(
              width: 300,
              textController: searchTextController,
              helpText: "책 또는 저자를 입력",
              suffixIcon: const Icon(Icons.arrow_back),
              onSuffixTap: () {
                setState(() {
                  searchTextController.clear();
                });
              },
              onSubmitted: (String value) {
                Get.off(() => BookSearchResult());
              },
            ),
          ],
        ),
      ),
    );
  }
}
