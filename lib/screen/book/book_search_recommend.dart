// 도서 검색/추천 페이지
import 'dart:async';
import 'dart:math';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/screen/book/book_search_result.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:book_project/screen/book/test.dart';
import 'package:dio/dio.dart';
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

  // 추천 도서
  List<BookModel> recommendationBooks = [];

  // 베스트셀러 도서
  List<BookModel> bestSellerBooks = [];

  // 신간 도서
  List<BookModel> newBooks = [];

  // 서버 통신
  var dio = Dio();

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

  // 추천 도서, 베스트 셀러 도서, 신간 도서를 받아오는 함수
  Future<void> getBookDatas() async {
    // 접속하려는 서버 url를 설정한다.
    String url = "http://192.168.0.43:8080/";

    print(url);


    // 서버와 통신 - 서버에 접속해서 인터파크 추천 도서 API 데이터를 받는다.
    // final response = await dio.get(
    //   url,
    //   options: Options(
    //     validateStatus: (_) => true,
    //     contentType: Headers.jsonContentType,
    //     responseType: ResponseType.json,
    //   ),
    // );

    // response.data를 객체로 변환

    // 서버와 통신 - 서버에 접속해서 인터파크 베스트셀러 도서 API 데이터를 받는다.
    // final response = await dio.get(
    //   url,
    //   options: Options(
    //     validateStatus: (_) => true,
    //     contentType: Headers.jsonContentType,
    //     responseType: ResponseType.json,
    //   ),
    // );

    // response.data를 객체로 변환

    // 서버와 통신 - 서버에 접속해서 인터파크 신간 도서 API 데이터를 받는다.
    // final response = await dio.get(
    //   url,
    //   options: Options(
    //     validateStatus: (_) => true,
    //     contentType: Headers.jsonContentType,
    //     responseType: ResponseType.json,
    //   ),
    // );

    // response.data를 객체로 변환
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBookDatas(),
      builder: (context, snapshot) {
        // getBookDatas()를 실행하는 동안만 실행
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: MediaQuery.of(context).size.width,
            // 배경 이미지
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/background_book1.jpg"),
                fit: BoxFit.fill,
                opacity: 0.3,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // 프로그래스바
                CircularProgressIndicator(),

                // 중간 공백
                SizedBox(height: 40),

                // 도서 데이터들을 가져오고 있습니다.
                Text(
                  "도서 데이터를 가져오고 있습니다",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }
        // getBookDatas()를 다 실행했으면....
        else {
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              "assets/imgs/icon.png"),
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

                    // 추천 도서를 보여주는 공간
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 30),

                    // 베스트셀러 도서를 보여주는 공간
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
                                  const Text("베스트셀러 도서입니다."),
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

                    // 신간 도서를 보여주는 공간
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
                                  const Text("신간 도서입니다."),
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
      },
    );
  }
}
