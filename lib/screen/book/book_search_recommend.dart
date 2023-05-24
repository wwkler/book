// 도서 검색/추천 페이지
import 'dart:async';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ban_check.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/book_search_result.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';

class BookSearchRecommend extends StatefulWidget {
  BookSearchRecommend({Key? key}) : super(key: key);

  @override
  State<BookSearchRecommend> createState() => _BookSearchRecommendState();
}

class _BookSearchRecommendState extends State<BookSearchRecommend> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

  // 북마카세가 제시하는 추천 도서
  List<BookModel> bookMakaseRecommendBooks = [];

  // 추천 도서
  List<BookModel> recommendationBooks = [];

  // 베스트셀러 도서
  List<BookModel> bestSellerBooks = [];

  // 신간 도서
  List<BookModel> newBooks = [];

  // 서버 통신하는 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book Search Recommend InitState 시작");
    super.initState();

    // 소속이 사용자 이면서 monitorBanFlag가 false일 떄만 실시간으로 사용자가 Ban 됐는지 실시간으로 모니터링 한다
    if (UserInfo.identity == UserManagerCheck.user &&
        BanCheck.monitorBanFlag == false) {
      print("실시간으로 사용자가 Ban됐는지 실시간으로 모니터링 합니다");
      // 사용자가 ban됐는지 실시간으로 모니터링 한다
      BanCheck.monitor();
      BanCheck.monitorBanFlag = true;
    }
  }

  @override
  void dispose() {
    print("Book Search Recommend state 종료");
    super.dispose();
  }

  // 추천 도서, 베스트 셀러 도서, 신간 도서를 받아오는 함수
  Future<void> getBookDatas() async {
    // 데이터 clear
    bookMakaseRecommendBooks.clear();
    recommendationBooks.clear();
    bestSellerBooks.clear();
    newBooks.clear();

    // delay
    await Future.delayed(const Duration(seconds: 2));

    // 서버와 통신 - 서버에 접속해서 북마카세가 추천하는 데이터를 받는다
    try {
      final response0 = await dio.get(
        "http://${IpAddress.hyunukIP}/book/recommend?memberId=${UserInfo.userValue}",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response0.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 북마카세가 제시하는 추천 도서 받은 데이터 : ${response0.data}");

        bookMakaseRecommendBooks = (response0.data as List<dynamic>).map(
          (dynamic e) {
            return BookModel.fromJson(e as Map<String, dynamic>);
          },
        ).toList();

        print("bookMakaseRecommendBooks: $bookMakaseRecommendBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 북마카세 실패");
        print("서버 통신 에러 코드 : ${response0.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }

    try {
      // 서버와 통신 - 서버에 접속해서 인터파크 추천 도서 API 데이터를 받는다.
      // 주의사항) 인터파크 추천 도서 API 데이터를 상황에 따라 줄 떄도 있고, 주지 않을 떄 도 있다.
      //         그 점을 이용해서 데이터 핸들링을 해야 할 것 같다.
      final response1 = await dio.get(
        "http://${IpAddress.hyunukIP}/api/recommended?categoryId=${UserInfo.selectedCode}",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response1.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 추천 도서 받은 데이터 : ${response1.data}");

        recommendationBooks = (response1.data["item"] as List<dynamic>).map(
          (dynamic e) {
            return BookModel.fromJson(e as Map<String, dynamic>);
          },
        ).toList();

        print("recommendationBooks : $recommendationBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response1.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }

    try {
      // 서버와 통신 - 서버에 접속해서 인터파크 베스트셀러 도서 API 데이터를 받는다.
      final response2 = await dio.get(
        "http://${IpAddress.hyunukIP}/api/popular?categoryId=${UserInfo.selectedCode}",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
      if (response2.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 베스트셀러 받은 데이터 : ${response2.data}");

        bestSellerBooks = (response2.data["item"] as List<dynamic>).map(
          (dynamic e) {
            return BookModel.fromJson(e as Map<String, dynamic>);
          },
        ).toList();

        print("bestSellerBooks : $bestSellerBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response2.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }

    try {
      // 서버와 통신 - 서버에 접속해서 인터파크 신간 도서 API 데이터를 받는다.
      final response3 = await dio.get(
        "http://${IpAddress.hyunukIP}/api/newbooks?categoryId=${UserInfo.selectedCode}",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response3.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 신간 도서 받은 데이터 : ${response3.data}");

        newBooks = (response3.data["item"] as List<dynamic>).map(
          (dynamic e) {
            return BookModel.fromJson(e as Map<String, dynamic>);
          },
        ).toList();

        print("newBooks : $newBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response3.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBookDatas(),
      builder: (context, snapshot) {
        // getBookDatas()를 실행하는 동안만 실행
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 불가능하다는 다이어로그를 띄운다.
              Get.snackbar(
                "처음 화면 입니다",
                "처음 화면 이므로 뒤로 가기를 할 수 없습니다",
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              );

              return false;
            },
            child: Container(
              width: MediaQuery.of(context).size.width.w,
              // 배경 이미지
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: UserInfo.identity == UserManagerCheck.user
                      ? const AssetImage("assets/imgs/background_book1.jpg")
                      : const AssetImage("assets/imgs/background_book2.jpg"),
                  fit: BoxFit.fill,
                  opacity: 0.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 프로그래스바
                  const CircularProgressIndicator(),

                  // 중간 공백
                  SizedBox(height: 40.h),

                  // 도서 데이터들을 가져오고 있습니다.
                  Text(
                    "도서 데이터를 가져오고 있습니다",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // getBookDatas()를 다 실행했으면....
        else {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 불가능하다는 다이어로그를 띄운다.
              Get.snackbar(
                "처음 화면 입니다",
                "처음 화면 이므로 뒤로 가기를 할 수 없습니다",
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
              );

              return false;
            },
            child: Container(
              // 배경 이미지
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: UserInfo.identity == UserManagerCheck.user
                      ? const AssetImage("assets/imgs/background_book1.jpg")
                      : const AssetImage("assets/imgs/background_book2.jpg"),
                  fit: BoxFit.fill,
                  opacity: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 중간 공백
                      SizedBox(height: 30.h),

                      // 도서 검색, 추천 Text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Card(
                            elevation: 10.0,
                            color: const Color.fromARGB(255, 228, 201, 232),
                            shadowColor: Colors.grey.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                            child: SizedBox(
                              width: 250.w,
                              height: 40.h,
                              child: Center(
                                child: Text(
                                  "도서 검색, 추천",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(height: 10.h),

                      // 검색어
                      AnimSearchBar(
                        width: 300.w,
                        textController: searchTextController,
                        helpText: "도서 또는 저자를 입력",
                        suffixIcon: const Icon(Icons.arrow_back),
                        onSuffixTap: () {
                          searchTextController.clear();
                        },
                        onSubmitted: (String value) {
                          // BookSearchResult로 라우팅하면서 검색어 데이터도 함께 보낸다
                          if (searchTextController.text.isNotEmpty) {
                            Get.to(
                              () => const BookSearchResult(),
                              arguments: searchTextController.text,
                            );
                          } else {
                            Get.snackbar(
                              "이상 메시지",
                              "도서 또는 저자를 입력해주세요",
                              duration: const Duration(seconds: 3),
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        },
                      ),

                      // 추천과 관련된 분석한 내용이 들어가는 Card
                      // SizedBox(
                      //   width: 400,
                      //   height: 230,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 5,
                      //     itemBuilder: (context, index) => SizedBox(
                      //       width: 400,
                      //       height: 230,
                      //       child: Stack(
                      //         children: [
                      //           Positioned(
                      //             top: 35,
                      //             left: 20,
                      //             child: Material(
                      //               child: Container(
                      //                 width:
                      //                     MediaQuery.of(context).size.width * 0.9,
                      //                 height: 180,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(10.0),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.3),
                      //                       offset: const Offset(-10.0, 10.0),
                      //                       blurRadius: 20.0,
                      //                       spreadRadius: 4.0,
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: 0,
                      //             left: 30,
                      //             child: Card(
                      //               elevation: 10.0,
                      //               shadowColor: Colors.grey.withOpacity(0.5),
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(15.0),
                      //               ),
                      //               child: Container(
                      //                 width: 150,
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(10.0),
                      //                     image: const DecorationImage(
                      //                       fit: BoxFit.fill,
                      //                       image: AssetImage(
                      //                         "assets/imgs/icon.png",
                      //                       ),
                      //                     )),
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             top: 45,
                      //             left: 180,
                      //             child: SizedBox(
                      //               width: 180,
                      //               height: 150,
                      //               child: Column(
                      //                 children: [
                      //                   Text(
                      //                     "추천과 관련된 분석 내용",
                      //                     style: TextStyle(
                      //                       fontSize: 15,
                      //                       fontWeight: FontWeight.bold,
                      //                       color: Color(0xFF363f93),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // 중간 공백
                      // const SizedBox(height: 20),

                      // 북마카세가 추천하는 도서 text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            "북마카세가 추천하는 도서",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // 북마카세가 추천하는 도서를 보여주는 공간
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          color: Colors.purple,
                          width: 400.w,
                          height: 350.h,
                          padding: const EdgeInsets.all(16.0),
                          child: bookMakaseRecommendBooks.isNotEmpty
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bookMakaseRecommendBooks.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      // 도서 상세 페이지로 라우팅
                                      // Get.off(
                                      //   () => BookShowPreview(),
                                      //   arguments:
                                      //       bookMakaseRecommendBooks[index],
                                      // );

                                      Get.to(
                                        () => BookShowPreview(),
                                        arguments:
                                            bookMakaseRecommendBooks[index],
                                      );
                                    },
                                    child: SizedBox(
                                      width: 200.w,
                                      height: 350.h,
                                      child: Card(
                                        elevation: 10.0,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0.r),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // 도서 이미지
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Image.network(
                                                  bookMakaseRecommendBooks[
                                                          index]
                                                      .coverSmallUrl,
                                                  width: 150.w,
                                                  height: 150.h,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                              ),

                                              // 도서 제목
                                              Text(
                                                bookMakaseRecommendBooks[index]
                                                    .title,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 20.w),
                                )
                              : Center(
                                  child: Text(
                                    "북마카세가 추천하는 추천 도서를 제공하지 않습니다.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // 추천 도서 text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            "추천 도서",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // 추천 도서를 보여주는 공간
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          color: Colors.purple,
                          width: 400.w,
                          height: 350.h,
                          padding: const EdgeInsets.all(16.0),
                          child: recommendationBooks.isNotEmpty
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recommendationBooks.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      // 도서 상세 페이지로 라우팅
                                      // Get.off(
                                      //   () => BookShowPreview(),
                                      //   arguments: recommendationBooks[index],
                                      // );

                                      Get.to(
                                        () => BookShowPreview(),
                                        arguments: recommendationBooks[index],
                                      );
                                    },
                                    child: SizedBox(
                                      width: 200.w,
                                      height: 350.h,
                                      child: Card(
                                        elevation: 10.0,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0.r),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // 도서 이미지
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Image.network(
                                                  recommendationBooks[index]
                                                      .coverSmallUrl,
                                                  width: 150.w,
                                                  height: 150.h,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                              ),

                                              // 도서 제목
                                              Text(
                                                recommendationBooks[index]
                                                    .title,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 20.w),
                                )
                              : Center(
                                  child: Text(
                                    "추천 도서를 제공하지 않습니다.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(height: 20.h),

                      // 베스트셀러 도서 text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            "베스트셀러 도서",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // 베스트셀러 도서를 보여주는 공간
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          color: Colors.purple,
                          width: 400.w,
                          height: 350.h,
                          padding: const EdgeInsets.all(16.0),
                          child: bestSellerBooks.isNotEmpty
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bestSellerBooks.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      // 도서 페이지로 라우팅
                                      // Get.off(
                                      //   () => BookShowPreview(),
                                      //   arguments: bestSellerBooks[index],
                                      // );

                                      // 도서 페이지로 라우팅
                                      Get.to(
                                        () => BookShowPreview(),
                                        arguments: bestSellerBooks[index],
                                      );
                                    },
                                    child: SizedBox(
                                      width: 200.w,
                                      height: 350.h,
                                      child: Card(
                                        elevation: 10.0,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // 도서 이미지
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Image.network(
                                                bestSellerBooks[index]
                                                    .coverSmallUrl,
                                                width: 150.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                              ),
                                            ),

                                            // 중간 공백
                                            SizedBox(height: 10.h),

                                            // 도서 제목
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                bestSellerBooks[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 20.w,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "서버 오류로 베스트셀러 도서를 가져오지 못했습니다",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(height: 20.h),

                      // 신간 도서 text
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            "신간 도서",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // 신간 도서를 보여주는 공간
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          color: Colors.purple,
                          width: 400.w,
                          height: 350.h,
                          padding: const EdgeInsets.all(16.0),
                          child: newBooks.isNotEmpty
                              ? ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: newBooks.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      // 도서 상세 페이지로 라우팅
                                      // Get.off(
                                      //   () => BookShowPreview(),
                                      //   arguments: newBooks[index],
                                      // );

                                      Get.to(
                                        () => BookShowPreview(),
                                        arguments: newBooks[index],
                                      );
                                    },
                                    child: SizedBox(
                                      width: 200.w,
                                      height: 350.h,
                                      child: Card(
                                        elevation: 10.0,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // 도서 이미지
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Image.network(
                                                newBooks[index].coverSmallUrl,
                                                width: 150.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                              ),
                                            ),

                                            // 중간 공백
                                            SizedBox(height: 10.h),

                                            // 도서 제목
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                newBooks[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: 20.w,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "서버 오류로 인해 신간 도서를 가져오지 못했습니다",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
