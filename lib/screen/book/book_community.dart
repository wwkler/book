// 도서 커뮤니티 페이지
import 'dart:ffi';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_review_write.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookCommunity extends StatefulWidget {
  const BookCommunity({super.key});

  @override
  State<BookCommunity> createState() => _BookCommunityState();
}

class _BookCommunityState extends State<BookCommunity> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();
  // 검색어
  String keyword = "";

  // 리뷰를 작성한 사용자 관련 데이터
  List<Map<String, dynamic>> reviewWriterInfos = [];
  // 리뷰와 관련된 도서 데이터(배열)
  List<BookModel> reviewBooks = [];
  // 좋아요 한 리뷰 데이터
  List<int> likeReviews = [];

  // 서버를 사용하기 위한 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book Community initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book Community state 종료");
    super.dispose();
  }

  Future<void> getReviewDatas() async {
    // 데이터 clear
    reviewWriterInfos.clear();
    reviewBooks.clear();
    likeReviews.clear();

    // keyword == "" 일 떄 전체 리뷰 데이터를 가져온다
    if (keyword == "") {
      print("전체 리뷰 데이터를 가져오고 있습니다");

      // 전체 데이터를 가져온다
      try {
        final response = await dio.get(
          "http://${IpAddress.hyunukIP}/reviews/findAll",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 받아온 데이터 : ${response.data}");

          // reviewBooks 데이터 추가
          reviewBooks = (response.data as List<dynamic>).map(
            (dynamic e) {
              return BookModel.fromJson(e["book"] as Map<String, dynamic>);
            },
          ).toList();

          print("reviewBooks : $reviewBooks");

          // reviewWriteInfos 데이터 추가
          reviewWriterInfos = (response.data as List<dynamic>).map(
            (dynamic e) {
              return {
                "id": e["id"],
                "title": e["title"],
                "content": e["content"],
                "createdAt": (e["createdAt"] as String).substring(0, 10),
                "updatedAt": (e["updatedAt"] as String).substring(0, 10),
                "rating": e["rating"],
                "likes": e["likes"],
                "member_id": e["member"]["id"],
                "account": e["member"]["account"],
                "name": e["member"]["name"],
              };
            },
          ).toList();

          print("reviewWriterInfos : $reviewWriterInfos");
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response.statusCode}");
        }
      }
      // DioError[unknown]: null이 메시지로 나타났을 떄
      // 즉 서버가 열리지 않았다는 뜻이다
      catch (e) {
        print("서버가 열리지 않음");
      }
    }
    // keyword != ""일 떄 검색어에 해당하는 리뷰 데이터를 가져온다
    else {
      // 검색어에 해당하는 데이터를 가져온다
      try {
        final response = await dio.get(
          "http://${IpAddress.hyunukIP}/reviews/search?param=$keyword",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 받아온 데이터 : ${response.data}");

          // reviewBooks 데이터 추가
          reviewBooks = (response.data as List<dynamic>).map(
            (dynamic e) {
              return BookModel.fromJson(e["book"] as Map<String, dynamic>);
            },
          ).toList();

          print("reviewBooks : $reviewBooks");

          // reviewWriteInfos 데이터 추가
          reviewWriterInfos = (response.data as List<dynamic>).map(
            (dynamic e) {
              return {
                "id": e["id"],
                "title": e["title"],
                "content": e["content"],
                "createdAt": (e["createdAt"] as String).substring(0, 10),
                "updatedAt": (e["updatedAt"] as String).substring(0, 10),
                "rating": e["rating"],
                "likes": e["likes"],
                "member_id": e["member"]["id"],
                "account": e["member"]["account"],
                "name": e["member"]["name"],
              };
            },
          ).toList();

          print("reviewWriterInfos : $reviewWriterInfos");
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response.statusCode}");
        }
      }
      // DioError[unknown]: null이 메시지로 나타났을 떄
      // 즉 서버가 열리지 않았다는 뜻이다
      catch (e) {
        print("서버가 열리지 않음");
      }
    }

    // 사용자가 좋아요 등록한 리뷰 글 모음을 서버에서 가져온다
    try {
      final response = await dio.get(
        "http://${IpAddress.hyunukIP}/reviews/getMemberLike?memberId=${UserInfo.userValue}",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받아온 데이터 : ${response.data}");

        // reviewBooks 데이터 추가
        likeReviews = (response.data as List<dynamic>)
            .map((dynamic e) => e["review"]["id"] as int)
            .toList();

        print("likeReviews : $likeReviews");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response.statusCode}");
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
    print("Book Community build 실행");

    return FutureBuilder(
      future: getReviewDatas(),
      builder: (context, snapshot) {
        // getReviewatas를 실행하고 있는 중....
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 불가능하다는 다이어로그를 띄운다.
              Get.snackbar(
                "뒤로 가기 불가능",
                "사용자 임의로 뒤로 가기를 할 수 없습니다.",
                duration: const Duration(seconds: 5),
                snackPosition: SnackPosition.TOP,
              );

              return false;
            },
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
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

                    // 리뷰 데이터를 가져오고 있습니다 text
                    Text(
                      "리뷰 데이터를 가져오고 있습니다",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        //
        else {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 불가능하다는 다이어로그를 띄운다.
              Get.snackbar(
                "뒤로 가기 불가능",
                "사용자 임의로 뒤로 가기를 할 수 없습니다.",
                duration: const Duration(seconds: 5),
                snackPosition: SnackPosition.TOP,
              );

              return false;
            },
            child: Scaffold(
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: MediaQuery.of(context).size.width.w,
                  height: MediaQuery.of(context).size.height.h,
                  // 배경 이미지
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: UserInfo.identity == UserManagerCheck.user
                          ? const AssetImage("assets/imgs/background_book1.jpg")
                          : const AssetImage(
                              "assets/imgs/background_book2.jpg"),
                      fit: BoxFit.fill,
                      opacity: 0.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 중간 공백
                        SizedBox(height: 10.h),

                        // 도서 커뮤니티 Text
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
                              child: SizedBox(
                                width: 250.w,
                                height: 40.h,
                                child: Center(
                                  child: Text(
                                    "도서 커뮤니티",
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

                        // search bar, 리뷰 작성하기
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // search bar
                              AnimSearchBar(
                                width: 200.w,
                                textController: searchTextController,
                                helpText: "리뷰 제목을 입력하세요",
                                suffixIcon: const Icon(Icons.arrow_back),
                                onSuffixTap: () {
                                  setState(() {
                                    searchTextController.clear();
                                  });
                                },
                                onSubmitted: (String value) {
                                  keyword = value;
                                  // 화면 재랜더링
                                  setState(() {});
                                },
                              ),

                              // 리뷰 작성하기 버튼
                              ElevatedButton(
                                onPressed: () {
                                  // 도서 리뷰 작성 페이지로 라우팅
                                  Get.to(() => const BookReviewWrite());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ),
                                  backgroundColor: Colors.purple,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width.w /
                                            40.0,
                                    vertical: 15.h,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.add),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "리뷰 작성",
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 중간 공백
                        reviewBooks.isNotEmpty
                            ? SizedBox(height: 10.h)
                            : SizedBox(height: 50.h),

                        // 리뷰 결과물 -> 없으면 결과가 없다는 text를 화면에 보여주고, 있으면 리뷰들을 보여준다.
                        reviewBooks.isNotEmpty
                            ? Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: reviewBooks.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      height: 300.h,
                                      child: SingleChildScrollView(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            //모서리를 둥글게 하기 위해 사용
                                            borderRadius:
                                                BorderRadius.circular(16.0.r),
                                          ),
                                          elevation: 4.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 이름
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.h),
                                                  child: Text(
                                                    "${reviewWriterInfos[index]["name"]}",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 아이디
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.h),
                                                  child: Text(
                                                    "@${reviewWriterInfos[index]["account"]}",
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 리뷰 제목
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.h),
                                                  child: Text(
                                                    "리뷰 제목 : ${reviewWriterInfos[index]["title"]}",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),

                                                // 리뷰 별점, 좋아요, 신고하기
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    // 리뷰 별점
                                                    RatingBarIndicator(
                                                      rating: reviewWriterInfos[
                                                              index]["rating"]
                                                          as double,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 30.0.sp,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),

                                                    // 좋아요, 좋아요 수 버튼
                                                    Row(
                                                      children: [
                                                        // 좋아요 버튼
                                                        IconButton(
                                                          onPressed: () async {
                                                            try {
                                                              final response =
                                                                  await dio
                                                                      .post(
                                                                'http://${IpAddress.hyunukIP}/reviews/addLike?reviewId=${reviewWriterInfos[index]["id"]}&memberId=${UserInfo.userValue}',
                                                                data: {},
                                                                options:
                                                                    Options(
                                                                  validateStatus:
                                                                      (_) =>
                                                                          true,
                                                                  contentType:
                                                                      Headers
                                                                          .jsonContentType,
                                                                  responseType:
                                                                      ResponseType
                                                                          .json,
                                                                ),
                                                              );

                                                              // 서버와 통신에 성공
                                                              if (response
                                                                      .statusCode ==
                                                                  200) {
                                                                print(
                                                                    "서버와 통신 성공");
                                                                print(
                                                                    "서버에서 제공해주는 사용자 정보 데이터 : ${response.data}");

                                                                // 좋아요를 등록했는지 해제했는지 서버 호출한다.
                                                                try {
                                                                  final response =
                                                                      await dio
                                                                          .get(
                                                                    'http://${IpAddress.hyunukIP}/reviews/isLiked?reviewId=${reviewWriterInfos[index]["id"]}&memberId=${UserInfo.userValue}',
                                                                    data: {},
                                                                    options:
                                                                        Options(
                                                                      validateStatus:
                                                                          (_) =>
                                                                              true,
                                                                      contentType:
                                                                          Headers
                                                                              .jsonContentType,
                                                                      responseType:
                                                                          ResponseType
                                                                              .json,
                                                                    ),
                                                                  );

                                                                  // 서버와 통신에 성공
                                                                  if (response
                                                                          .statusCode ==
                                                                      200) {
                                                                    print(
                                                                        "서버와 통신 성공");
                                                                    print(
                                                                        "서버에서 제공해주는 사용자 정보 데이터 : ${response.data}");

                                                                    // response.data가 true일 떄
                                                                    if (response
                                                                            .data ==
                                                                        true) {
                                                                      // 좋아요 등록에 성공하였다는 snackBar를 띄운다
                                                                      Get.snackbar(
                                                                        "좋아요 등록 성공 ",
                                                                        "해당 리뷰 게시물에 좋아요를 등록했습니다",
                                                                        duration:
                                                                            const Duration(seconds: 5),
                                                                        snackPosition:
                                                                            SnackPosition.TOP,
                                                                      );
                                                                    }

                                                                    // response.data가 false일 떄
                                                                    else {
                                                                      // 좋아요 해제에 성공하였다는 snackBar를 띄운다
                                                                      Get.snackbar(
                                                                        "좋아요 해제 성공 ",
                                                                        "해당 리뷰 게시물에 좋아요를 해제했습니다",
                                                                        duration:
                                                                            const Duration(seconds: 5),
                                                                        snackPosition:
                                                                            SnackPosition.TOP,
                                                                      );
                                                                    }

                                                                    // 화면 재랜더링
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                  // 서버와 통신 실패
                                                                  else {
                                                                    print(
                                                                        "서버와 통신 실패");
                                                                    print(
                                                                        "서버 통신 에러 코드 : ${response.statusCode}");
                                                                    print(
                                                                        "메시지 : ${response.data}");

                                                                    // 좋아요 등록/해제 반영에 실패하였다는 snackBar를 띄운다
                                                                    Get.snackbar(
                                                                      "좋아요 등록/해제 반영 실패",
                                                                      "좋아요 등록/해제 반영이 실패하였습니다",
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              5),
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .TOP,
                                                                    );
                                                                  }
                                                                }
                                                                // DioError[unknown]: null이 메시지로 나타났을 떄
                                                                // 즉 서버가 열리지 않았다는 뜻이다
                                                                catch (e) {
                                                                  // 서버가 열리지 않았다는 snackBar를 띄운다
                                                                  Get.snackbar(
                                                                    "서버 열리지 않음",
                                                                    "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            5),
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .TOP,
                                                                  );
                                                                }
                                                              }
                                                              // 서버와 통신 실패
                                                              else {
                                                                print(
                                                                    "서버와 통신 실패");
                                                                print(
                                                                    "서버 통신 에러 코드 : ${response.statusCode}");
                                                                print(
                                                                    "메시지 : ${response.data}");

                                                                // 좋아요 반영에 실패하였다는 snackBar를 띄운다
                                                                Get.snackbar(
                                                                  "좋아요 반영 실패",
                                                                  "해당 리뷰 게시물에 좋아요가 반영되지 않았습니다",
                                                                  duration:
                                                                      const Duration(
                                                                          seconds:
                                                                              5),
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .TOP,
                                                                );
                                                              }
                                                            }
                                                            // DioError[unknown]: null이 메시지로 나타났을 떄
                                                            // 즉 서버가 열리지 않았다는 뜻이다
                                                            catch (e) {
                                                              // 서버가 열리지 않았다는 snackBar를 띄운다
                                                              Get.snackbar(
                                                                "서버 열리지 않음",
                                                                "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            5),
                                                                snackPosition:
                                                                    SnackPosition
                                                                        .TOP,
                                                              );
                                                            }
                                                          },
                                                          icon: likeReviews.contains(
                                                                  reviewWriterInfos[
                                                                          index]
                                                                      ["id"])
                                                              ? const Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                )
                                                              : const Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 20,
                                                                ),
                                                        ),

                                                        // 좋아요 수
                                                        Text(
                                                          reviewWriterInfos[
                                                                      index]
                                                                  ["likes"]
                                                              .toString(),
                                                          style: likeReviews.contains(
                                                                  reviewWriterInfos[
                                                                          index]
                                                                      ["id"])
                                                              ? TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )
                                                              : TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                        ),
                                                      ],
                                                    ),

                                                    // 신고하기 버튼
                                                    IconButton(
                                                      onPressed: () {
                                                        Map<String, bool>
                                                            reasons = {
                                                          "영리목적/홍보성": false,
                                                          "욕설/인신공격": false,
                                                          "불법정보": false,
                                                          "개인정보노출": false,
                                                          "음란성/선전성": false,
                                                          "같은 내용 도배": false,
                                                        };

                                                        // 신고 내용을 적는 textControleller
                                                        final reportContentController =
                                                            TextEditingController();

                                                        // 신고하기 다이어로그를 띄운다.
                                                        Get.dialog(
                                                          StatefulBuilder(
                                                            builder: (
                                                              context,
                                                              setState,
                                                            ) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  '신고하기',
                                                                ),
                                                                content:
                                                                    SizedBox(
                                                                  width: 100.w,
                                                                  height: 200.h,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        // Text
                                                                        const Text(
                                                                          "위 리뷰글을 신고하는 사유를\n체크하시오",
                                                                        ),

                                                                        // 중간 공백
                                                                        SizedBox(
                                                                          height:
                                                                              10.h,
                                                                        ),

                                                                        // 영리목적/홍보성
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["영리목적/홍보성"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["영리목적/홍보성"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "영리목적/홍보성",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 욕설/인신공격
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["욕설/인신공격"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["욕설/인신공격"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "욕설/인신공격",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 불법정보
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["불법정보"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["불법정보"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "불법정보",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 개인정보 노출
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["개인정보노출"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["개인정보노출"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "개인정보노출",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 음란성/선전성
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["음란성/선전성"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["음란성/선전성"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "음란성/선전성",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 같은 내용 도배
                                                                        Row(
                                                                          children: [
                                                                            // 체크박스
                                                                            Checkbox(
                                                                              value: reasons["같은 내용 도배"],
                                                                              onChanged: (bool? newValue) {
                                                                                setState(() {
                                                                                  reasons["같은 내용 도배"] = newValue!;
                                                                                });
                                                                              },
                                                                            ),

                                                                            Text(
                                                                              "같은 내용 도배",
                                                                              style: TextStyle(
                                                                                fontSize: 12.5.sp,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // 내용 적기
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            8.0,
                                                                          ),
                                                                          child:
                                                                              TextField(
                                                                            controller:
                                                                                reportContentController,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            minLines:
                                                                                2,
                                                                            maxLines:
                                                                                10,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(width: 3.w, color: Colors.purple),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(width: 3.w, color: Colors.purple),
                                                                              ),
                                                                              labelText: '신고내용',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                      "신고 제출",
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      // 검증
                                                                      if (reasons.values.contains(
                                                                              true) &&
                                                                          reportContentController.text !=
                                                                              "") {
                                                                        // true인 것만 찾아서 리스트로 저장한다
                                                                        List<String> selectReasons = reasons
                                                                            .keys
                                                                            .where(
                                                                              (String key) => reasons[key] == true,
                                                                            )
                                                                            .toList();

                                                                        String
                                                                            result =
                                                                            selectReasons.join(" ");

                                                                        try {
                                                                          final response =
                                                                              await dio.post(
                                                                            'http://${IpAddress.hyunukIP}/reviews/reportReview',
                                                                            data: {
                                                                              // 신고하는 사용자의 고유값
                                                                              "memberId": UserInfo.userValue,
                                                                              // 신고 사유
                                                                              "reason": result.substring(0, result.length),
                                                                              // 신고 내용
                                                                              "content": reportContentController.text,

                                                                              // 리뷰 아이디
                                                                              "reviewId": reviewWriterInfos[index]["id"],
                                                                            },
                                                                            options: Options(
                                                                                validateStatus: (_) => true,
                                                                                contentType: Headers.jsonContentType,
                                                                                responseType: ResponseType.json),
                                                                          );

                                                                          if (response.statusCode ==
                                                                              200) {
                                                                            print("서버와 통신 성공");

                                                                            // 신고하기 다이어로그를 지운다
                                                                            Get.back();

                                                                            // 신고 완료 snackBar를 띄운다
                                                                            Get.snackbar(
                                                                              "신고 완료",
                                                                              "신고 완료되었습니다 소중한 의견 감사합니다",
                                                                              duration: const Duration(seconds: 5),
                                                                              snackPosition: SnackPosition.TOP,
                                                                            );

                                                                            // 재런더링 한다.
                                                                            setState(() {});
                                                                          }
                                                                          //
                                                                          else {
                                                                            print("서버와 통신 실패");
                                                                            print("서버 에러 코드 : ${response.statusCode}");
                                                                            print("서버 에러 메시지 : ${response.data}");

                                                                            // 신고하기 다이어로그를 지운다
                                                                            Get.back();

                                                                            // 신고 실패를 띄운다
                                                                            Get.snackbar("신고 실패",
                                                                                "신고 실패되었습니다 다시 시도해주세요",
                                                                                duration: const Duration(seconds: 5),
                                                                                snackPosition: SnackPosition.TOP);
                                                                          }
                                                                        }
                                                                        // DioError[unknown]: null이 메시지로 나타났을 떄
                                                                        // 즉 서버가 열리지 않았다는 뜻이다
                                                                        catch (e) {
                                                                          // 신고하기 다이어로그를 지운다
                                                                          Get.back();

                                                                          Get.snackbar(
                                                                            "서버가 열리지 않았습니다",
                                                                            "서버가 열리지 않았습니다 관리자에게 문의해주세요",
                                                                            duration:
                                                                                const Duration(seconds: 5),
                                                                            snackPosition:
                                                                                SnackPosition.TOP,
                                                                          );
                                                                        }
                                                                      }
                                                                      //
                                                                      else {
                                                                        // 신고하기 다이어로그를 없앤다.
                                                                        Get.back();

                                                                        // 이상 메시지 snackBar를 띄운다.
                                                                        Get.snackbar(
                                                                          "이상 메시지",
                                                                          "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                                                          duration:
                                                                              const Duration(seconds: 5),
                                                                          snackPosition:
                                                                              SnackPosition.TOP,
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.error_outline,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 도서 정보
                                                GestureDetector(
                                                  onTap: () {
                                                    // 도서 상세 정보 페이지로 이동
                                                    Get.to(
                                                      () => BookShowPreview(),
                                                      arguments:
                                                          reviewBooks[index],
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                      16.0,
                                                    ),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width
                                                              .w,
                                                      height: 200.h,
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          //모서리를 둥글게 하기 위해 사용
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            16.0.r,
                                                          ),
                                                        ),
                                                        elevation: 4.0, //그림자 깊이
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              // 도서 이미지
                                                              Image.network(
                                                                reviewBooks[
                                                                        index]
                                                                    .coverSmallUrl,
                                                                width: 150.w,
                                                                height: 150.h,
                                                                fit: BoxFit
                                                                    .cover,
                                                                filterQuality:
                                                                    FilterQuality
                                                                        .high,
                                                              ),

                                                              // 중간 공백
                                                              const SizedBox(
                                                                  width: 10),

                                                              // 도서 제목
                                                              Text(
                                                                reviewBooks[
                                                                        index]
                                                                    .title,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),

                                                              // 중간 공백
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 리뷰 내용
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    16.0,
                                                  ),
                                                  child: Text(
                                                    "리뷰 내용 : ${reviewWriterInfos[index]["content"]}",
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),

                                                // 리뷰글 삭제하기 (관리자 권한)
                                                UserInfo.identity ==
                                                        UserManagerCheck.manager
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(64.0),
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            // 리뷰글을 삭제하는 다이어로그를 띄운다
                                                            Get.dialog(
                                                              AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  "리뷰글 삭제",
                                                                ),
                                                                content:
                                                                    SizedBox(
                                                                  width: 100.w,
                                                                  height: 150.h,
                                                                  child: Column(
                                                                    children: [
                                                                      // text
                                                                      const Text(
                                                                        "리뷰글을 삭제하시겠습니까?",
                                                                      ),

                                                                      // 중간 공백
                                                                      const SizedBox(
                                                                        height:
                                                                            25,
                                                                      ),

                                                                      // 리뷰글 삭제하기 버튼
                                                                      TextButton(
                                                                        child:
                                                                            const Text(
                                                                          "삭제하기",
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          // 서버와 통신
                                                                          // 전체 데이터를 가져온다
                                                                          try {
                                                                            final response =
                                                                                await dio.delete(
                                                                              "http://${IpAddress.hyunukIP}/reviews/delete?reviewId=${reviewWriterInfos[index]["id"]}",
                                                                              options: Options(
                                                                                validateStatus: (_) => true,
                                                                                contentType: Headers.jsonContentType,
                                                                                responseType: ResponseType.json,
                                                                              ),
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              print("서버와 통신 성공");
                                                                              print("서버에서 받아온 데이터 : ${response.data}");

                                                                              // 삭제하기 다이어로그를 없앤다
                                                                              Get.back();

                                                                              // 리뷰글을 삭제했다는 snackBar를 띄운다
                                                                              Get.snackbar(
                                                                                "리뷰글 삭제 성공",
                                                                                "리뷰글을 삭제하였습니다",
                                                                                duration: const Duration(seconds: 5),
                                                                                snackPosition: SnackPosition.TOP,
                                                                              );

                                                                              // 화면 재랜더링
                                                                              setState(() {});
                                                                            }
                                                                            //
                                                                            else {
                                                                              print("서버와 통신 실패");
                                                                              print("서버 통신 에러 코드 : ${response.statusCode}");

                                                                              // 삭제하기 다이어로그를 없앤다
                                                                              Get.back();

                                                                              // 리뷰글을 삭제 snackBar를 띄운다
                                                                              Get.snackbar(
                                                                                "리뷰글 삭제 반영 실패",
                                                                                "리뷰글이 삭제되지 않았습니다 다시 시도해주세요",
                                                                                duration: const Duration(seconds: 5),
                                                                                snackPosition: SnackPosition.TOP,
                                                                              );
                                                                            }
                                                                          }
                                                                          // DioError[unknown]: null이 메시지로 나타났을 떄
                                                                          // 즉 서버가 열리지 않았다는 뜻이다
                                                                          catch (e) {
                                                                            print("서버가 열리지 않음");

                                                                            // 삭제하기 다이어로그를 없앤다
                                                                            Get.back();

                                                                            // 서버가 닫혀있는 snackBar를 띄운다
                                                                            Get.snackbar(
                                                                              "서버가 닫혀 있음",
                                                                              "서버가 열리지 않았습니다",
                                                                              duration: const Duration(seconds: 5),
                                                                              snackPosition: SnackPosition.TOP,
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10.0.r,
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                Colors.purple,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 40.w,
                                                              vertical: 15.h,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.delete,
                                                              ),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Text(
                                                                "리뷰 삭제하기",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const Visibility(
                                                        visible: false,
                                                        child: Text(
                                                            "버튼은 보이지 않습니다."),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 중간 공백
                                  SizedBox(height: 100.h),

                                  // 데이터가 존재하지 않는 아이콘
                                  Image.asset(
                                    "assets/imgs/sad.png",
                                    width: 100.w,
                                    height: 100.h,
                                  ),

                                  // 중간 공백
                                  SizedBox(height: 40.h),

                                  // 데이터가 존재하지 않습니다 Text
                                  Text(
                                    "데이터가 존재하지 않습니다.",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),

                        // 중간 공백
                        SizedBox(height: 40.h),
                      ],
                    ),
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
