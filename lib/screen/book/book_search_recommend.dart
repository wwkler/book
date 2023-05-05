// 도서 검색/추천 페이지
import 'dart:async';
import 'dart:math';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/screen/book/book_search_result.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:book_project/screen/book/test.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BookSearchRecommend extends StatefulWidget {
  BookSearchRecommend({Key? key, int? randomNum}) : super(key: key);

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

    // 서버로부터 추천과 관련된 분석 내용을 가져온다.

    // 서버로부터 추천 도서를 가져온다.
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 중간 공백
              const SizedBox(height: 30),

              // 도서 검색, 추천 Text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Card(
                    elevation: 10.0,
                    color: const Color.fromARGB(255, 228, 201, 232),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const SizedBox(
                      width: 250,
                      height: 40,
                      child: Center(
                        child: Text(
                          "도서 검색, 추천",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 중간 공백
              const SizedBox(height: 10),

              // // StatefulWidget - didUpdageWidget()를 실험하기 위해 임시적으로 쓴 것
              // ElevatedButton(
              //   onPressed: () {
              //     Get.to(() => Test());
              //   },
              //   child: Text("이동"),
              // ),

              // 검색어
              AnimSearchBar(
                width: 300,
                textController: searchTextController,
                helpText: "책 또는 저자를 입력",
                suffixIcon: const Icon(Icons.arrow_back),
                onSuffixTap: () {
                  searchTextController.clear();
                },
                onSubmitted: (String value) {
                  // BookSearchResult로 라우팅하면서 검색어 데이터도 함께 보낸다
                  if (searchTextController.text.isNotEmpty) {
                    Get.off(
                      () => const BookSearchResult(),
                      arguments: searchTextController.text,
                    );
                  } else {
                    Get.snackbar(
                      "이상 메시지",
                      "책 또는 저자를 입력해주세요",
                      duration: const Duration(seconds: 5),
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
              ),

              // 추천과 관련된 분석한 내용이 들어가는 Card
              SizedBox(
                width: 400,
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => SizedBox(
                    width: 400,
                    height: 230,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(-10.0, 10.0),
                                    blurRadius: 20.0,
                                    spreadRadius: 4.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/imgs/icon.png"),
                                  )),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 45,
                          left: 180,
                          child: SizedBox(
                            width: 180,
                            height: 150,
                            child: Column(
                              children: [
                                Text(
                                  "추천과 관련된 분석 내용",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF363f93),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // 중간 공백
              const SizedBox(height: 30),

              // 추천 책을 보여주는 공간 1
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  color: Colors.purple,
                  width: 400,
                  height: 300,
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // 도서 상세 페이지로 라우팅
                        Get.off(() => BookShowPreview());
                      },
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            // 도서 이미지
                            Image.asset("assets/imgs/icon.png"),

                            // 중간 공백
                            const SizedBox(height: 30),

                            // 도서 제목
                            const Text("추천 도서입니다."),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
              ),

              // 중간 공백
              const SizedBox(height: 30),

              // 추천 책을 보여주는 공간 2
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  color: Colors.purple,
                  width: 400,
                  height: 300,
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // 도서 페이지로 라우팅
                        Get.off(() => BookShowPreview());
                      },
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            // 도서 이미지
                            Image.asset("assets/imgs/icon.png"),

                            // 중간 공백
                            const SizedBox(height: 30),

                            // 도서 제목
                            const Text("추천 도서입니다."),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
              ),

              // 중간 공백
              const SizedBox(height: 30),

              // 추천 책을 보여주는 공간 3
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  color: Colors.purple,
                  width: 400,
                  height: 300,
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        // 도서 상세 페이지로 라우팅
                        Get.off(() => BookShowPreview());
                      },
                      child: Card(
                        elevation: 10.0,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            // 도서 이미지
                            Image.asset("assets/imgs/icon.png"),

                            // 중간 공백
                            const SizedBox(height: 30),

                            // 도서 제목
                            const Text("추천 도서입니다."),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                  ),
                ),
              ),

              // 중간 공백
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
