// 사용자가 리뷰를 작성하는 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_community.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookReviewWrite extends StatefulWidget {
  const BookReviewWrite({super.key});

  @override
  State<BookReviewWrite> createState() => _BookReviewWriteState();
}

class _BookReviewWriteState extends State<BookReviewWrite> {
  // 읽은 도서 (배열)
  List<BookModel> readBooks = [];
  // 읽은 도서 날짜 기록하는 (배열)
  List<String> readBooks_completed_dateTime = [];
  // 선택한 읽은 도서
  BookModel? selectedBook;
  // 서버 호출 플래그
  bool callServer = true;

  // 리뷰 별점
  double reviewPoint = 3.0;

  // 리뷰 타이틀 textController
  final reviewTitleController = TextEditingController();

  // 리뷰평 textController
  final reviewContentController = TextEditingController();

  // 서버를 사용하는 변수
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    print("Book Review Write initState 시작");
  }

  @override
  void dispose() {
    print("Book Review Write state 종료");
    super.dispose();
  }

  // 읽은 도서를 가져오는 함수
  Future<void> getReadBookDatas() async {
    if (callServer == true) {
      try {
        final response = await dio.get(
          "http://${IpAddress.hyunukIP}/bookshelves/getFinishedBooks?memberId=${UserInfo.userValue}",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 받은 읽은 도서 데이터: ${response.data}");

          readBooks = (response.data as List<dynamic>).map(
            (dynamic e) {
              // 도서 읽은 날짜를 배열에 추가한다.
              readBooks_completed_dateTime.add(
                (e["finishedDate"] as String).substring(0, 10),
              );

              return BookModel.fromJson(e["book"] as Map<String, dynamic>);
            },
          ).toList();

          // if (readBooks.isNotEmpty) {
          //   selectedBook = readBooks[0];
          // }

          print("readBooks : $readBooks");
          print(
              "readBooks_completed_dateTime : ${readBooks_completed_dateTime}");
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
        // 서버가 열리지 않았다는 snackBar를 띄운다
        Get.snackbar(
          "서버 열리지 않음",
          "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      }

      if (readBooks.isNotEmpty) {
        selectedBook = readBooks[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getReadBookDatas(),
      builder: (context, snapshot) {
        // getReadBookDatas를 실행하고 있는 중....
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 가능하다.
              return true;
            },
            child: Scaffold(
              body: Container(
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

                    // 사용자가 읽은 도서를 가져오고 있습니다 text
                    Text(
                      "사용자가 읽은 도서를 가져오고 있습니다",
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

        // getReadBookDatas를 실행했으면?
        else {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 가능하다.
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                body: Container(
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 중간 공백
                          SizedBox(height: 10.h),

                          // 이전 페이지 아이콘
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                            ),
                          ),

                          // 도서 리뷰 작성 Text
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
                                      "도서 리뷰 작성",
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
                          SizedBox(height: 50.h),

                          // 읽은 도서가 있는지 없는지에 따라 다른 로직 구현
                          readBooks.isNotEmpty
                              ? Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          const Icon(
                                            Icons.list,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '읽은 도서 검색',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      value: selectedBook!.title,
                                      items: readBooks
                                          .map(
                                            (BookModel bookModel) =>
                                                DropdownMenuItem<String>(
                                              value: bookModel.title,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    // 읽은 도서 이미지
                                                    Image.network(
                                                      bookModel.coverSmallUrl,
                                                      width: 50.w,
                                                      height: 50.h,
                                                    ),

                                                    // 중간 공백
                                                    SizedBox(width: 10.w),

                                                    // 읽은 도서 제목
                                                    Text(
                                                      bookModel.title,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),

                                                    // 중간 공백
                                                    SizedBox(width: 10.w),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (String? bookName) {
                                        // 서버를 호출하지 않겠다.
                                        callServer = false;
                                        setState(() {
                                          print("bookName : ${bookName}");
                                          selectedBook = readBooks.firstWhere(
                                            (BookModel book) =>
                                                book.title == bookName,
                                          );
                                          print(
                                              "selectedBook : ${selectedBook}");
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50.h,
                                        width: 250.w,
                                        padding: EdgeInsets.only(
                                          left: 14.w,
                                          right: 14.w,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.purple,
                                        ),
                                        elevation: 2,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: Colors.white,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200.h,
                                        width: 300.w,
                                        padding: null,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                          color: Colors.purple,
                                        ),
                                        elevation: 8,
                                        offset: const Offset(-20, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: Radius.circular(40.r),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 80.h,
                                        padding: EdgeInsets.only(
                                          left: 14.w,
                                          right: 14.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          const Icon(
                                            Icons.list,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '읽은 도서가 없습니다',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: [],
                                      buttonStyleData: ButtonStyleData(
                                        height: 50.h,
                                        width: 250.w,
                                        padding: EdgeInsets.only(
                                          left: 14.w,
                                          right: 14.w,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.purple,
                                        ),
                                        elevation: 2,
                                      ),
                                    ),
                                  ),
                                ),

                          // 중간 공백
                          SizedBox(height: 50.h),

                          // 별점 메기기
                          Center(
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0.h),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double rating) {
                                reviewPoint = rating;

                                print(reviewPoint);
                              },
                            ),
                          ),

                          // 중간 공백
                          SizedBox(height: 50.h),

                          // 리뷰 제목
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: TextField(
                              controller: reviewTitleController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 2,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.w, color: Colors.purple),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.w, color: Colors.purple),
                                ),
                                labelText: '리뷰 제목',
                              ),
                            ),
                          ),

                          // 중간 공백
                          SizedBox(height: 25.h),

                          // 리뷰평
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: reviewContentController,
                              keyboardType: TextInputType.multiline,
                              minLines: 2,
                              maxLines: 10,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.w, color: Colors.purple),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.w, color: Colors.purple),
                                ),
                                labelText: '리뷰평',
                              ),
                            ),
                          ),

                          // 작성 완료 버튼
                          Padding(
                            padding: const EdgeInsets.all(64.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // 검증
                                if (readBooks.isNotEmpty &&
                                    reviewTitleController.text != "" &&
                                    reviewContentController.text != "") {
                                  // 서버와 통신
                                  // 데이터베이스에 도서 리뷰 데이터를 추가한다.
                                  try {
                                    final response = await dio.post(
                                      "http://${IpAddress.hyunukIP}/reviews/save",
                                      data: {
                                        // 리뷰 제목
                                        "title": reviewTitleController.text,

                                        // 리뷰 내용
                                        "content": reviewContentController.text,

                                        // 리뷰 평점
                                        "rating": reviewPoint,

                                        // 사용자 고유값
                                        "memberId": UserInfo.userValue,

                                        // 도서 id
                                        "itemId": selectedBook!.itemId,
                                      },
                                      options: Options(
                                        validateStatus: (_) => true,
                                        contentType: Headers.jsonContentType,
                                        responseType: ResponseType.json,
                                      ),
                                    );

                                    if (response.statusCode == 200) {
                                      print("서버와 통신 성공");
                                      print("서버 성공데이터: ${response.data}");

                                      Get.offAll(
                                        () => BookFluidNavBar(
                                            route: const BookCommunity(),
                                            routeIndex: 3),
                                      );

                                      Get.snackbar(
                                        "리뷰 작성 성공",
                                        "리뷰 작성 완료하였습니다",
                                        duration: const Duration(seconds: 3),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                    //
                                    else {
                                      print("서버와 통신 실패");
                                      print(
                                          "서버 통신 에러 코드 : ${response.statusCode}");

                                      Get.snackbar(
                                        "리뷰 작성 반영 실패",
                                        "리뷰 작성 반영 실패 하였습니다",
                                        duration: const Duration(seconds: 3),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  }
                                  // DioError[unknown]: null이 메시지로 나타났을 떄
                                  // 즉 서버가 열리지 않았다는 뜻이다
                                  catch (e) {
                                    Get.snackbar(
                                      "서버 열리지 않음",
                                      "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                      duration: const Duration(seconds: 3),
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                }
                                // 클라언트에서 이상 입력값을 줬다는 snackBar를 띄운다
                                else {
                                  Get.snackbar(
                                    "이상 메시지",
                                    "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                backgroundColor: Colors.purple,
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width.w /
                                          20.0,
                                  vertical: 15.h,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 25.w),
                                  const Icon(Icons.create_outlined),
                                  SizedBox(width: 50.w),
                                  Text(
                                    "작성 완료",
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
