// 도서 나만의 목표 페이지
import 'dart:math';

import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_my_goal_edit1.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class BookMyGoal extends StatefulWidget {
  BookMyGoal({Key? key}) : super(key: key);

  @override
  State<BookMyGoal> createState() => _BookMyGoalState();
}

class _BookMyGoalState extends State<BookMyGoal> {
  // 읽고 있는 도서의 총 페이지를 설정하기 위한 변수
  final setPageController = TextEditingController();
  // 읽고 있는 도서의 진행도를 설정하기 위한 변수
  final editPageController = TextEditingController();

  // category
  Map<int, String> category = {
    0: "분야가 정해지지 않음",
    101: "국내도서>소설",
    102: "국내도서>시/에세이",
    103: "국내도서>예술/대중문화",
    104: "국내도서>사회과학",
    105: "국내도서>역사와 문화",
    107: "국내도서>잡지",
    108: "국내도서>만화",
    109: "국내도서>유아",
    110: "국내도서>아동",
    111: "국내도서>가정과 생활",
    112: "국내도서>청소년",
    113: "국내도서>초등학습서",
    114: "국내도서>고등학습서",
    115: "국내도서>국어/외국어/사전",
    116: "국내도서>자연과 과학",
    117: "국내도서>경제경영",
    118: "국내도서>자기계발",
    119: "국내도서>인문",
    120: "국내도서>종교/역학",
    122: "국내도서>컴퓨터/인터넷",
    123: "국내도서>자격서/수험서",
    124: "국내도서>취미/레저",
    125: "국내도서>전공도서/대학교재",
    126: "국내도서>건강/뷰티",
    128: "국내도서/여행",
    129: "국내도서>중등학습서",
  };

  // 목표 1, 2, 3 데이터를 담는 배열
  List<Map<String, dynamic>> objectives = [];

  // 목표 관련된 분석 내용
  List<String> objectAnaysisTitles = [
    "완료 달성 수",
    "목표 달성 성공률 ",
    "내가 선호하는 카테고리에서 다른 사용자가 목표를 얼마나 달성했는지 수",
    "내가 선호하는 카테고리에서 다른 사용자가 목표 도전 중인 사람 수",
    "카테고리 고려하지 않고 비슷한 나이대 중에서 완료한 사람들 수",
    "카테고리 고려하지 않고 비슷한 나이대 중에 도전 중인 사람들 수",
    "같은 나이대 목표 평균 성공률 수"
  ];
  List<int> objectAnalysisContents = [-1, -1, -1, -1, -1, -1, -1];

  // 목표와 관련된 분석 이미지
  List<String> objectImagePath = [
    "assets/imgs/done.png",
    "assets/imgs/objectComplete.png",
    "assets/imgs/anotherObjectComplete.png",
    "assets/imgs/anotherChallengeGoal.png",
    "assets/imgs/similiarAgeComplete.png",
    "assets/imgs/similarAgeChallenge.png",
    "assets/imgs/similarAgeAchiveGoal.png",
  ];

  // 읽고 싶은 도서 (배열)
  List<BookModel> wantToReadBooks = [];

  // 읽고 있는 도서 (배열)
  List<BookModel> nowReadBooks = [];
  // 읽고 있는 도서에 대한 currentPage와 totalPage (배열)
  List<Map<String, int>> nowReadBooks_currentPage_totalPage = [];

  // 읽은 도서 (배열)
  List<BookModel> readBooks = [];
  // 읽은 도서 날짜 기록하는 (배열)
  List<String> readBooks_completed_dateTime = [];

  // 서버를 사용하기 위한 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book My Goal InitState 시작");

    super.initState();
  }

  @override
  void dispose() {
    print("Book My Goal dispose 시작");
    super.dispose();
  }

  // 나의 목표를 가져오기 위한 함수
  Future<void> getServerDatas() async {
    // 데이터 clear
    objectives.clear();
    for (int i = 0; i < 3; i++) {
      objectives.add({"data": "none"});
    }

    wantToReadBooks.clear();
    nowReadBooks.clear();
    nowReadBooks_currentPage_totalPage.clear();
    readBooks.clear();
    readBooks_completed_dateTime.clear();

    // 본격적으로 서버와 통신한다.

    // 서버에 목표 1 데이터가 있는지 확인한다.
    try {
      final response1 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/isExist?goalname=목표_1_${UserInfo.id}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // 목표 1 데이터가 있을 떄.... -> 목표 1과 관련된 내용을 서버를 통해 가져온다.
      if (response1.data == true) {
        final response1_1 = await dio.get(
          "http://${IpAddress.hyunukIP}/goal/getByGoalname?goalname=목표_1_${UserInfo.id}",
          options: Options(
            headers: {
              "Authorization": "Bearer ${UserInfo.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response1_1.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 목표 1 받은 데이터 : ${response1_1.data}");
          objectives.removeAt(0);
          objectives.insert(0, response1_1.data as Map<String, dynamic>);

          print("objectives : $objectives");
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response1_1.statusCode}");
        }
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 1이 열리지 않음");
    }

    try {
      // 서버에 목표 2 데이터가 있는지 확인한다.
      final response2 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/isExist?goalname=목표_2_${UserInfo.id}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // 목표 2 데이터가 있을 떄.... -> 목표 2과 관련된 내용을 서버를 통해 가져온다.
      if (response2.data == true) {
        final response2_2 = await dio.get(
          "http://${IpAddress.hyunukIP}/goal/getByGoalname?goalname=목표_2_${UserInfo.id}",
          options: Options(
            headers: {
              "Authorization": "Bearer ${UserInfo.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response2_2.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 목표 2 받은 데이터 : ${response2_2.data}");
          objectives.removeAt(1);
          objectives.insert(1, response2_2.data as Map<String, dynamic>);

          print("objectives : $objectives");
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response2_2.statusCode}");
        }
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 2가 열리지 않음");
    }

    try {
      // 서버에 목표 3 데이터가 있는지 확인한다.
      final response3 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/isExist?goalname=목표_3_${UserInfo.id}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // 목표 3 데이터가 있을 떄.... -> 목표 3과 관련된 내용을 서버를 통해 가져온다.
      if (response3.data == true) {
        final response3_3 = await dio.get(
          "http://${IpAddress.hyunukIP}/goal/getByGoalname?goalname=목표_3_${UserInfo.id}",
          options: Options(
            headers: {
              "Authorization": "Bearer ${UserInfo.token}",
            },
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response3_3.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 목표 3 받은 데이터 : ${response3_3.data}");
          objectives.removeAt(2);
          objectives.insert(2, response3_3.data as Map<String, dynamic>);
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response3_3.statusCode}");
        }
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 3이 열리지 않음");
    }

    try {
      // 읽고 싶은 도서를 서버에서 가져온다.
      final response4 = await dio.get(
        "http://${IpAddress.hyunukIP}/bookshelves/getLikedBooks?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response4.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 읽고 싶은 도서 데이터: ${response4.data}");

        wantToReadBooks = (response4.data as List<dynamic>).map(
          (dynamic e) {
            return BookModel.fromJson(e["book"] as Map<String, dynamic>);
          },
        ).toList();

        print("wantToReadBooks : $wantToReadBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response4.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 4가 열리지 않음");
    }

    try {
      // 읽고 있는 도서를 서버에서 가져온다.
      final response5 = await dio.get(
        "http://${IpAddress.hyunukIP}/bookshelves/getReadingBooks?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response5.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 읽고 있는 도서 데이터: ${response5.data}");

        nowReadBooks = (response5.data as List<dynamic>).map(
          (dynamic e) {
            // 읽고 있는 도서에 대한 currentPage와 totalPage도 추가한다.
            nowReadBooks_currentPage_totalPage.add({
              "currentPage": e["currentPage"] as int,
              "totalPage": e["totalPage"] as int,
            });
            return BookModel.fromJson(e["book"] as Map<String, dynamic>);
          },
        ).toList();

        print("nowReadBooks : $nowReadBooks");
        print(
            "nowReadBooks_currentPage_totalPage : ${nowReadBooks_currentPage_totalPage}");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response5.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 5가 열리지 않음");
    }

    try {
      // 읽은 도서를 서버에서 가져온다.
      final response6 = await dio.get(
        "http://${IpAddress.hyunukIP}/bookshelves/getFinishedBooks?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response6.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 읽은 도서 데이터: ${response6.data}");

        readBooks = (response6.data as List<dynamic>).map(
          (dynamic e) {
            // 도서 읽은 날짜를 배열에 추가한다.
            readBooks_completed_dateTime.add(
              (e["finishedDate"] as String).substring(0, 10),
            );

            return BookModel.fromJson(e["book"] as Map<String, dynamic>);
          },
        ).toList();

        print("readBooks : $readBooks");
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response6.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 6이 열리지 않음");
    }

    // 목표와 관련된 분석 내용을 서버에서 가져온다.
    try {
      // // 개인의 완료 달성 수 를 서버에서 가져온다.
      final response7 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/getCompletedCount?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response7.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 완료 달성 수 데이터: ${response7.data}");

        objectAnalysisContents[0] = response7.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response7.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 7이 열리지 않음");
    }

    try {
      // // 개인의 성공률을 서버에서 가져온다.
      final response8 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/getSuccessRate?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response8.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 개인의 성공률 건수 데이터: ${response8.data}");
        objectAnalysisContents[1] = response8.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response8.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 8이 열리지 않음");
    }

    try {
      // // 내가 선호하는 카테코리 번호에서 다른 사용자가 목표 얼마나 달성했는지를 서버에서 가져온다.
      final response9 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/similarCompleteds?memberId=${UserInfo.userValue}&categoryId=${UserInfo.selectedCode}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response9.statusCode == 200) {
        print("서버와 통신 성공");
        print(
            "서버에서 받은 내가 선호하는 카테코리 번호에서 다른 사용자가 목표를 얼마나 달성했는지에 대한 데이터: ${response9.data}");
        objectAnalysisContents[2] = response9.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response9.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 9가 열리지 않음");
    }

    try {
      // // 내가 선호하는 카테코리 번호에서 다른 사용자가 목표를 도전 중인 사람 수를 서버에서 가져온다.
      final response10 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/similarChallengers?memberId=${UserInfo.userValue}&categoryId=${UserInfo.selectedCode}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response10.statusCode == 200) {
        print("서버와 통신 성공");
        print(
            "서버에서 받은 내가 선호하는 카테코리 번호에서 다른 사용자가 목표를 도전 중인 사람 수 데이터: ${response10.data}");
        objectAnalysisContents[3] = response10.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response10.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 10이 열리지 않음");
    }

    try {
      // // 카테고리 고려하지 않고 비슷한 나이 대 중에 완료한 사람들 수를 서버에서 가져온다.
      final response11 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/similarCompletedsAll?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response11.statusCode == 200) {
        print("서버와 통신 성공");
        print(
            "서버에서 받은 카테고리 고려하지 않고 비슷한 나이 대 중에 완료한 사람들 수 데이터: ${response11.data}");
        objectAnalysisContents[4] = response11.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response11.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 11이 열리지 않음");
    }

    try {
      // 카테고리 고려하지 않고 비슷한 나이 대 중에 도전 중인 사람들 수 를 서버에서 가져온다.
      final response12 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/similarChallengersAll?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response12.statusCode == 200) {
        print("서버와 통신 성공");
        print(
            "서버에서 받은 카테고리 고려하지 않고 비슷한 나이 대 중에 도전 중인 사람들 수 데이터: ${response12.data}");
        objectAnalysisContents[5] = response12.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response12.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 12가 열리지 않음");
    }

    try {
      // // 같은 나이대 목표 평균 성공률을 서버에서 가져온다.
      final response13 = await dio.get(
        "http://${IpAddress.hyunukIP}/goal/getAverageRate?memberId=${UserInfo.userValue}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response13.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 같은 나이대 목표 평균 성공률데이터: ${response13.data}");
        objectAnalysisContents[6] = response13.data;
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response13.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버 13이 열리지 않음");
    }

    print("objectives : $objectives");
  }

  // 날짜를 format 시켜주는 함수
  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    print("Book_my_goal build 시작");

    return FutureBuilder(
      future: getServerDatas(),
      builder: (context, snapshot) {
        // getMyGoals()를 실행하는 동안만 실행
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

                  // 목표 및 사용자 서재 데이터를 가져오고 있습니다
                  Text(
                    "목표 및 사용자 서재\n 데이터를 가져오고 있습니다",
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
        // GetMyGoals()를 실행하고 난 후...
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
            child: SingleChildScrollView(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 중간 공백
                      SizedBox(height: 30.h),

                      // 목표 확인, 사용사 서재 Text
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
                                  "목표 확인 및 사용자 서재",
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
                      SizedBox(height: 30.h),

                      // 목표 설정/수정하기 버튼
                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // 화면을 라우팅하면서 목표 1, 2, 3를 관리하는 배열 objectives를 같이 넘긴다.
                            Get.to(
                              () => const BookMyGoalEdit1(),
                              arguments: objectives,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.r),
                            ),
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width.w / 20.0,
                              vertical: 15.h,
                            ),
                          ),
                          child: Text(
                            "목표 설정/수정",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(height: 25.h),

                      // 1번째 목표, 2번쨰 목표, 3번쨰 목표
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 1번째 목표
                          GestureDetector(
                            onTap: () async {
                              // 현재 시간을 가져온다.
                              DateTime currentTime = await NTP.now();
                              currentTime = currentTime
                                  .toUtc()
                                  .add(const Duration(hours: 9));

                              // 목표 1과 관련되서 데이터가 없을 떄 경우
                              if (objectives[0]["data"] == "none") {
                                // 목표 1과 관련된 dialog를 요약적으로 보여준다.
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 1 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 1에 대한 데이터가 없습니다.\n목표를 설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // 목표 1과 관련해서 목표를 성공했을 경우
                              else if (objectives[0]["completed"] == true) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 1 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 1을 완료했습니다. 목표를 재설정해주세요.",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // endTime이 현재 시간보다 작은 경우
                              // 즉 목표 1에 대해서 목표를 실패했을 경우
                              else if (objectives[0]["endDate"]
                                      .toString()
                                      .compareTo(formatDate(currentTime)) <
                                  0) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 1 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 1 종료 기간이 지났습니다.\n목표를 재설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // endTime이 현재 시간과 같거나 큰 경우
                              // 목표 1 데이터에 대해서 정보를 요약적으로 보여준다.
                              else {
                                // 달성 권수 확인하기
                                // // (목표 시작 날짜 <= 도서 읽기 완료 날짜 <= 목표 완료 날짜 )&& (읽은 도서 분야 == 목표 설정 도서 분야)
                                // int accomplishCount = 0;

                                // for (int i = 0;
                                //     i < readBooks_completed_dateTime.length;
                                //     i++) {
                                //   if (readBooks_completed_dateTime[i].compareTo(
                                //               objectives[0]["startDate"]) >=
                                //           0 &&
                                //       readBooks_completed_dateTime[i].compareTo(
                                //               objectives[0]["endDate"]) <=
                                //           0 &&
                                //       readBooks[i].categoryId ==
                                //           objectives[0]["categoryId"]) {
                                //     accomplishCount += 1;
                                //   }
                                // }

                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 1 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 진행 기간
                                            Text(
                                              "진행 기간 : ${objectives[0]["startDate"]} ~ ${objectives[0]["endDate"]}",
                                            ),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 진행 도서 분야
                                            Text(
                                                "도서 분야 : ${category[objectives[0]["categoryId"]]}"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 목표 권수
                                            Text(
                                                "목표 권수 : ${objectives[0]["targetQuantity"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성 권수
                                            Text(
                                                "달성 권수 : ${objectives[0]["readed"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성률
                                            Text(
                                                "달성률 : ${((objectives[0]["readed"] / objectives[0]["targetQuantity"]) * 100).round()}%"),

                                            // 다이어로그에서 나가는 버튼
                                            Center(
                                              child: TextButton(
                                                child: const Text("나가기"),
                                                onPressed: () {
                                                  // 다이어로그를 삭제한다.
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: SizedBox(
                                  width: 80.w,
                                  height: 40.h,
                                  child: const Center(
                                    child: Text(
                                      "1번째 목표",
                                      // "목표를 설정해주세요!!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 2번쨰 목표
                          GestureDetector(
                            onTap: () async {
                              // 현재 시간을 가져온다.
                              DateTime currentTime = await NTP.now();
                              currentTime = currentTime
                                  .toUtc()
                                  .add(const Duration(hours: 9));

                              // 목표 2과 관련되서 데이터가 없을 떄 경우
                              if (objectives[1]["data"] == "none") {
                                // 목표 2과 관련된 dialog를 요약적으로 보여준다.
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 2 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 2에 대한 데이터가 없습니다.\n목표를 설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // 목표 2과 관련해서 목표를 성공했을 경우
                              else if (objectives[1]["completed"] == true) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 2 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 2을 완료했습니다. 목표를 재설정해주세요.",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // 현재 시간이 endTime보다 클 경우
                              // 목표 2와 관련해서 목표 달성을 실패 했을 경우
                              else if (objectives[1]["endDate"]
                                      .toString()
                                      .compareTo(formatDate(currentTime)) <
                                  0) {
                                print("목표 다시 설정 ");
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 2 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 2 종료 기간이 지났습니다.\n목표를 재설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // 현재 시간이 endTime보다 작을 경우
                              // 목표 2 데이터에 대해서 정보를 요약적으로 보여준다.
                              else {
                                // print("목표 진행중");
                                // // 달성 권수 확인하기
                                // // // 목표 시작 날짜 <= 도서 읽기 완료 날짜 <= 목표 완료 날짜 && 읽은 도서 분야 == 목표 설정 도서 분야
                                // int accomplishCount = 0;

                                // for (int i = 0;
                                //     i < readBooks_completed_dateTime.length;
                                //     i++) {
                                //   if (readBooks_completed_dateTime[i].compareTo(
                                //               objectives[1]["startDate"]) >=
                                //           0 &&
                                //       readBooks_completed_dateTime[i].compareTo(
                                //               objectives[1]["endDate"]) <=
                                //           0 &&
                                //       readBooks[i].categoryId ==
                                //           objectives[1]["categoryId"]) {
                                //     accomplishCount += 1;
                                //   }
                                // }

                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 2 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 진행 기간
                                            Text(
                                              "진행 기간 : ${objectives[1]["startDate"]} ~ ${objectives[1]["endDate"]}",
                                            ),
                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 진행 도서 분야
                                            Text(
                                                "도서 분야 : ${category[objectives[1]["categoryId"]]}"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 목표 권수
                                            Text(
                                                "목표 권수 : ${objectives[1]["targetQuantity"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성 권수
                                            Text(
                                                "달성 권수 :${objectives[1]["readed"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성률
                                            Text(
                                                "달성률 : ${((objectives[1]["readed"] / objectives[1]["targetQuantity"]) * 100).round()}%"),

                                            // 다이어로그에서 나가는 버튼
                                            Center(
                                              child: TextButton(
                                                child: const Text("나가기"),
                                                onPressed: () {
                                                  // 다이어로그를 삭제한다.
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: SizedBox(
                                  width: 80.w,
                                  height: 40.h,
                                  child: const Center(
                                    child: Text(
                                      "2번째 목표",
                                      // "목표를 설정해주세요!!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 3번쨰 목표
                          GestureDetector(
                            onTap: () async {
                              // 현재 시간을 가져온다.
                              DateTime currentTime = await NTP.now();
                              currentTime = currentTime
                                  .toUtc()
                                  .add(const Duration(hours: 9));

                              // 목표 3과 관련되서 데이터가 없을 떄 경우
                              if (objectives[2]["data"] == "none") {
                                // 목표 2과 관련된 dialog를 요약적으로 보여준다.
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 3 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 3에 대한 데이터가 없습니다.\n목표를 설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // 목표 3과 관련해서 목표를 성공했을 경우
                              else if (objectives[2]["completed"] == true) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 3 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 3을 완료했습니다. 목표를 재설정해주세요.",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              // 현재 시간이 endTime보다 클 경우
                              // 목표 3을 달성하지 못했을 경우
                              else if (objectives[2]["endDate"]
                                      .toString()
                                      .compareTo(formatDate(currentTime)) <
                                  0) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 3 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // 텍스트
                                          const Text(
                                            "목표 3 종료 기간이 지났습니다.\n목표를 재설정해주세요",
                                          ),

                                          // 다이어로그에서 나가는 버튼
                                          Center(
                                            child: TextButton(
                                              child: const Text("나가기"),
                                              onPressed: () {
                                                // 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // 현재 시간이 endTime보다 작을 경우
                              // 목표 3 데이터에 대해서 정보를 요약적으로 보여준다.
                              else {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("목표 3 진행 현황"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 진행 기간
                                            Text(
                                              "진행 기간 : ${objectives[2]["startDate"]} ~ ${objectives[2]["endDate"]}",
                                            ),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 진행 도서 분야
                                            Text(
                                                "도서 분야 : ${category[objectives[2]["categoryId"]]}"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 목표 권수
                                            Text(
                                                "목표 권수 : ${objectives[2]["targetQuantity"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성 권수
                                            Text(
                                                "달성 권수 : ${objectives[2]["readed"]}권"),

                                            // 중간 공백
                                            SizedBox(height: 20.h),

                                            // 달성률
                                            Text(
                                                "달성률 : ${((objectives[2]["readed"] / objectives[2]["targetQuantity"]) * 100).round()}%"),

                                            // 다이어로그에서 나가는 버튼
                                            Center(
                                              child: TextButton(
                                                child: const Text("나가기"),
                                                onPressed: () {
                                                  // 다이어로그를 삭제한다.
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                ),
                                child: SizedBox(
                                  width: 80.w,
                                  height: 40.h,
                                  child: const Center(
                                    child: Text(
                                      "3번째 목표",
                                      // "목표를 설정해주세요!!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // 중간 공백
                      SizedBox(height: 25.h),

                      // 목표와 관련된 여러 정보들을 취합해서 Card로 나타낸다.
                      SizedBox(
                        width: 400.w,
                        height: 230.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: objectAnalysisContents.length,
                          itemBuilder: (context, index) => SizedBox(
                            width: 400.w,
                            height: 230.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 35.h,
                                  left: 20.w,
                                  child: Material(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width.w *
                                              0.9,
                                      height: 180.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            offset: const Offset(-10.0, 10.0),
                                            blurRadius: 20.0.r,
                                            spreadRadius: 4.0.r,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0.h,
                                  left: 30.w,
                                  child: Card(
                                    elevation: 10.0,
                                    shadowColor: Colors.grey.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0.r),
                                    ),
                                    child: Container(
                                      width: 125.w,
                                      height: 150.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0.r),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              objectImagePath[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45.h,
                                  left: 180.w,
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    width: 180.w,
                                    height: 150.h,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${objectAnaysisTitles[index]} :  ${objectAnalysisContents[index].toString()}",
                                          //"목표를 설정해주세요",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF363f93),
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
                      SizedBox(height: 30.h),

                      // 읽고 싶은 도서
                      TapToExpand(
                        color: Colors.purple,
                        content: Center(
                          child: SizedBox(
                            width: 300.w,
                            height: 400.h,
                            child: wantToReadBooks.isNotEmpty
                                ? ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: wantToReadBooks.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        // 도서 상세 페이지로 라우팅
                                        // 해당 도서 데이터를 arguments로 전달하며 이것이 읽고 싶은 도서임을 알려야 한다.
                                        Get.to(
                                          () => BookShowPreview(),
                                          arguments: wantToReadBooks[index],
                                        );
                                      },
                                      child: SizedBox(
                                        width: 250.w,
                                        height: 400.h,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Card(
                                            elevation: 10.0,
                                            shadowColor:
                                                Colors.grey.withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0.r),
                                            ),
                                            child: Column(
                                              children: [
                                                // 삭제하기 버튼
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      // 삭제하는 다이어로그가 나온다.
                                                      Get.dialog(
                                                        AlertDialog(
                                                          title: const Text(
                                                            "읽고 싶은 도서에서 삭제하기",
                                                          ),
                                                          content: SizedBox(
                                                            width: 100.w,
                                                            height: 150.h,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                // 텍스트
                                                                const Text(
                                                                  "읽고 싶은 도서에서 삭제하시겠습니까?",
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    // 삭제하기 버튼
                                                                    Center(
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            const Text(
                                                                          "삭제하기",
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          // 서버와 통신
                                                                          // 읽고 싶은 도서를 삭제한다.
                                                                          try {
                                                                            final response =
                                                                                await dio.delete(
                                                                              "http://${IpAddress.hyunukIP}/bookshelves/removeBook?memberId=${UserInfo.userValue}&bookId=${wantToReadBooks[index].itemId}&param=0",
                                                                              options: Options(
                                                                                headers: {
                                                                                  "Authorization": "Bearer ${UserInfo.token}",
                                                                                },
                                                                                validateStatus: (_) => true,
                                                                                contentType: Headers.jsonContentType,
                                                                                responseType: ResponseType.json,
                                                                              ),
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              // 다이어로그를 삭제한다.
                                                                              Get.back();

                                                                              Get.snackbar(
                                                                                "읽고 싶은 도서에서 삭제 성공",
                                                                                "읽고 싶은 도서에서 삭제 성공하였습니다",
                                                                                duration: const Duration(seconds: 3),
                                                                                snackPosition: SnackPosition.TOP,
                                                                              );

                                                                              // 화면을 재랜더링 한다.
                                                                              setState(() {});
                                                                            }
                                                                            //
                                                                            else {
                                                                              Get.snackbar(
                                                                                "읽고 싶은 도서에서 삭제 실패",
                                                                                "읽고 싶은 도서에서 삭제 실패하였습니다\n다시 시도해주세요",
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
                                                                        },
                                                                      ),
                                                                    ),

                                                                    // 나가기 버튼
                                                                    Center(
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            const Text(
                                                                          "나가기",
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          // 다이어로그를 삭제한다.
                                                                          Get.back();
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );

                                                      // 서버와 통신
                                                    },
                                                    icon:
                                                        const Icon(Icons.clear),
                                                  ),
                                                ),

                                                // 도서 분야
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.0.w,
                                                    ),
                                                    child: Text(
                                                      category[wantToReadBooks[
                                                                  index]
                                                              .categoryId]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 20.h),
                                                // 도서 이미지
                                                Image.network(
                                                  wantToReadBooks[index]
                                                      .coverSmallUrl,
                                                  width: 150.w,
                                                  height: 150.h,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),

                                                // 중간 공백
                                                const SizedBox(height: 20),

                                                // 도서 제목
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    wantToReadBooks[index]
                                                        .title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 20.h),

                                                // 도서 읽기 버튼
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // 다이어로그
                                                    Get.dialog(
                                                      AlertDialog(
                                                        title: const Text(
                                                          "읽고 있는 도서 추가",
                                                        ),
                                                        content: SizedBox(
                                                          width: 100.w,
                                                          height: 150.h,
                                                          child: Column(
                                                            children: [
                                                              // text
                                                              const Text(
                                                                "읽고 있는 도서로 추가하시겠습니까?",
                                                              ),

                                                              // 중간 공백
                                                              SizedBox(
                                                                height: 50.h,
                                                              ),

                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  // 예
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                      "추가",
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      // 다이어로그를 삭제한다
                                                                      Get.back();

                                                                      // 도서의 총 페이지수를 사용자가 설정하는 다이어로그
                                                                      Get.dialog(
                                                                        AlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            "도서 총 페이지 수 설정",
                                                                          ),
                                                                          content:
                                                                              SizedBox(
                                                                            width:
                                                                                100.w,
                                                                            height:
                                                                                200.h,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                // 아이디를 보여주는 문구
                                                                                const Text("도서 총 페이지 수를 설정해주세요"),

                                                                                // 중간 공백
                                                                                SizedBox(height: 10.h),

                                                                                // 총 페이지 수 설정
                                                                                Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(16.0),
                                                                                    child: SizedBox(
                                                                                      width: 50.w,
                                                                                      height: 50.h,
                                                                                      child: TextField(
                                                                                        textAlign: TextAlign.center,
                                                                                        keyboardType: TextInputType.number,
                                                                                        controller: setPageController,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                // 총 페이지수 설정하는  버튼
                                                                                TextButton(
                                                                                  child: const Text("설정"),
                                                                                  onPressed: () async {
                                                                                    // 서버와 통신
                                                                                    try {
                                                                                      final response = await dio.put(
                                                                                        // totalPage는 자신이 직접 설정해야 한다. 도서의 페이지 수를 결정한다.
                                                                                        "http://${IpAddress.hyunukIP}/bookshelves/addReading?memberId=${UserInfo.userValue}&bookId=${wantToReadBooks[index].itemId}&totalPage=${int.parse(setPageController.text)}",
                                                                                        options: Options(
                                                                                          headers: {
                                                                                            "Authorization": "Bearer ${UserInfo.token}",
                                                                                          },
                                                                                          validateStatus: (_) => true,
                                                                                          contentType: Headers.jsonContentType,
                                                                                          responseType: ResponseType.json,
                                                                                        ),
                                                                                      );

                                                                                      // setPageController.text를 빈칸으로 다시 설정한다
                                                                                      setPageController.text = "";

                                                                                      if (response.statusCode == 200) {
                                                                                        print("서버와 통신 성공");
                                                                                        print("읽고 있는 도서 추가를 통해 받은 데이터 : ${response.data}");

                                                                                        //  다이어로그를 삭제한다.
                                                                                        Get.back();

                                                                                        // 읽고 있는 도서 추가 성공했다는 snackBar를 띄운다.
                                                                                        Get.snackbar(
                                                                                          "읽고 있는 도서로 추가 성공",
                                                                                          "읽고 있는 도서로 추가 성공하였습니다",
                                                                                          duration: const Duration(seconds: 3),
                                                                                          snackPosition: SnackPosition.TOP,
                                                                                        );

                                                                                        // 화면 재랜더링
                                                                                        setState(() {});
                                                                                      }
                                                                                      //
                                                                                      else {
                                                                                        print("서버와 통신 실패");
                                                                                        print("서버 통신 에러 코드 : ${response.statusCode}");

                                                                                        // 다이어로그를 삭제한다.
                                                                                        Get.back();

                                                                                        // 읽고 있는 도서 추가 실패 했다는 다이어로그를 띄운다.
                                                                                        Get.snackbar(
                                                                                          "읽고 있는 도서로 추가 실패",
                                                                                          "읽고 있눈 도서로 추가 실패하였습니다\n이미 읽고 있는 도서에 등록 됐을 가능성이 존재합니다.",
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
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        barrierDismissible:
                                                                            true,
                                                                      );
                                                                    },
                                                                  ),

                                                                  // 아니오
                                                                  TextButton(
                                                                    child: const Text(
                                                                        "추가하지 않음"),
                                                                    onPressed:
                                                                        () {
                                                                      // 다이어로그를 삭제한다.
                                                                      Get.back();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      barrierDismissible: true,
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0.r,
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        Colors.purple,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 10.h,
                                                    ),
                                                  ),
                                                  child: const Text("도서 읽기"),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 25.h),
                                              ],
                                            ),
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
                                      "읽고 싶은 도서가 없습니다.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          "읽고 싶은 도서",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        onTapPadding: 10,
                        closedHeight: 70.h,
                        scrollable: true,
                        borderRadius: 10.r,
                        openedHeight: 400.h,
                      ),

                      // 중간 공백
                      SizedBox(height: 30.h),

                      // 읽고 있는 도서
                      TapToExpand(
                        color: Colors.purple,
                        content: Center(
                          child: SizedBox(
                            width: 300.w,
                            height: 400.h,
                            child: nowReadBooks.isNotEmpty
                                ? ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: nowReadBooks.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        // 도서 상세 페이지로 라우팅
                                        // 해당 도서 데이터를 arguments로 전달하며 이것이 읽고 있는 도서을 알려야 한다.
                                        Get.to(
                                          () => BookShowPreview(),
                                          arguments: nowReadBooks[index],
                                        );
                                      },
                                      child: SizedBox(
                                        width: 250.w,
                                        height: 400.h,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Card(
                                            elevation: 10.0,
                                            shadowColor:
                                                Colors.grey.withOpacity(0.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0.r),
                                            ),
                                            child: Column(
                                              children: [
                                                // 삭제하기 버튼
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      // 삭제하는 다이어로그가 나온다.
                                                      Get.dialog(
                                                        AlertDialog(
                                                          title: const Text(
                                                            "읽고 있는 도서에서 삭제하기",
                                                          ),
                                                          content: SizedBox(
                                                            width: 100.w,
                                                            height: 150.h,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                // 텍스트
                                                                const Text(
                                                                  "읽고 있는 도서에서 삭제하시겠습니까?",
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    // 삭제하기 버튼
                                                                    Center(
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            const Text(
                                                                          "삭제하기",
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          // 서버와 통신
                                                                          // 읽고 있는 도서를 삭제한다.
                                                                          try {
                                                                            final response =
                                                                                await dio.delete(
                                                                              "http://${IpAddress.hyunukIP}/bookshelves/removeBook?memberId=${UserInfo.userValue}&bookId=${nowReadBooks[index].itemId}&param=1",
                                                                              options: Options(
                                                                                headers: {
                                                                                  "Authorization": "Bearer ${UserInfo.token}",
                                                                                },
                                                                                validateStatus: (_) => true,
                                                                                contentType: Headers.jsonContentType,
                                                                                responseType: ResponseType.json,
                                                                              ),
                                                                            );

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              // 다이어로그를 삭제한다.
                                                                              Get.back();

                                                                              Get.snackbar(
                                                                                "읽고 있는 도서에서 삭제 성공",
                                                                                "읽고 싶은 도서에서 삭제 성공하였습니다",
                                                                                duration: const Duration(seconds: 3),
                                                                                snackPosition: SnackPosition.TOP,
                                                                              );

                                                                              // 화면을 재랜더링 한다.
                                                                              setState(() {});
                                                                            }
                                                                            //
                                                                            else {
                                                                              // 다이어로그를 삭제한다.
                                                                              Get.back();

                                                                              Get.snackbar(
                                                                                "읽고 있는 도서에서 삭제 실패",
                                                                                "읽고 싶은 도서에서 삭제 실패하였습니다\n다시 시도해주세요",
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
                                                                        },
                                                                      ),
                                                                    ),

                                                                    // 나가기 버튼
                                                                    Center(
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            const Text(
                                                                          "나가기",
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          // 다이어로그를 삭제한다.
                                                                          Get.back();
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    icon:
                                                        const Icon(Icons.clear),
                                                  ),
                                                ),

                                                // 도서 분야
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.0.w,
                                                    ),
                                                    child: Text(
                                                      category[nowReadBooks[
                                                                  index]
                                                              .categoryId]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 20.h),
                                                // 도서 이미지
                                                Image.network(
                                                  nowReadBooks[index]
                                                      .coverSmallUrl,
                                                  width: 150.w,
                                                  height: 150.h,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),

                                                // 도서 제목
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    nowReadBooks[index].title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 10.h),

                                                // 진행도 표시, 도서 읽기 완료 버튼
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      // 진행도 확인
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: const Text(
                                                                '진행도 수정',
                                                              ),
                                                              content: SizedBox(
                                                                width: 100.w,
                                                                height: 100.h,
                                                                child: Column(
                                                                  children: [
                                                                    // Text
                                                                    const Text(
                                                                      "진행도 수정할 페이지를 입력",
                                                                    ),

                                                                    // 중간 공백
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),

                                                                    // TextField
                                                                    SizedBox(
                                                                      width:
                                                                          50.w,
                                                                      height:
                                                                          50.h,
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            editPageController,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  child:
                                                                      const Text(
                                                                    "적용하기",
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    // 진행도를 수정하도록 서버와 통신한다.
                                                                    print(
                                                                        "진행도 수정 설정한 페이지수 : ${int.parse(editPageController.text)}");
                                                                    try {
                                                                      final response =
                                                                          await dio
                                                                              .post(
                                                                        "http://${IpAddress.hyunukIP}/bookshelves/updateCurrentReading?memberId=${UserInfo.userValue}&bookId=${nowReadBooks[index].itemId}&page=${int.parse(editPageController.text)}",
                                                                        options:
                                                                            Options(
                                                                          headers: {
                                                                            "Authorization":
                                                                                "Bearer ${UserInfo.token}",
                                                                          },
                                                                          validateStatus: (_) =>
                                                                              true,
                                                                          contentType:
                                                                              Headers.jsonContentType,
                                                                          responseType:
                                                                              ResponseType.json,
                                                                        ),
                                                                      );

                                                                      // editPageController.text를 다시 빈칸으로 만듦
                                                                      editPageController
                                                                          .text = "";

                                                                      if (response
                                                                              .statusCode ==
                                                                          200) {
                                                                        // 다이어로그를 삭제한다.
                                                                        Get.back();

                                                                        // 진행도를 수정했다는 snackBar를 삭제한다.
                                                                        Get.snackbar(
                                                                          "진행도 수정 성공",
                                                                          "해당 도서 진행도 수정을 하였습니다",
                                                                          duration:
                                                                              const Duration(seconds: 3),
                                                                          snackPosition:
                                                                              SnackPosition.TOP,
                                                                        );

                                                                        // 화면 잰더링
                                                                        setState(
                                                                          () {},
                                                                        );
                                                                      }
                                                                      //
                                                                      else {
                                                                        // 다이어로그를 삭제한다.
                                                                        Get.back();

                                                                        // 진행도를 수정 실패했다는 snackBar를 삭제한다.
                                                                        Get.snackbar(
                                                                          "진행도 수정 실패",
                                                                          "진행도 수정 실패하였습니다\n다시 시도해주세요",
                                                                          duration:
                                                                              const Duration(seconds: 3),
                                                                          snackPosition:
                                                                              SnackPosition.TOP,
                                                                        );
                                                                      }
                                                                    }
                                                                    // DioError[unknown]: null이 메시지로 나타났을 떄
                                                                    // 즉 서버가 열리지 않았다는 뜻이다
                                                                    catch (e) {
                                                                      Get.snackbar(
                                                                        "서버 열리지 않음",
                                                                        "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                                                        duration:
                                                                            const Duration(seconds: 3),
                                                                        snackPosition:
                                                                            SnackPosition.TOP,
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Card(
                                                          elevation: 10.0,
                                                          shadowColor: Colors
                                                              .grey
                                                              .withOpacity(0.5),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              5.0.r,
                                                            ),
                                                          ),
                                                          child: SizedBox(
                                                            width: 100.w,
                                                            height: 30.h,
                                                            child: Center(
                                                              child: Text(
                                                                "${nowReadBooks_currentPage_totalPage[index]["currentPage"]}/${nowReadBooks_currentPage_totalPage[index]["totalPage"]}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      // 도서 읽기 완료 버튼
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          // 읽기 완료 다이어로그를 표시한다.
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: const Text(
                                                                "읽기 완료",
                                                              ),
                                                              content: SizedBox(
                                                                width: 100.w,
                                                                height: 150.h,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    // 텍스트
                                                                    const Text(
                                                                      "읽기 완료를 하시겠습니까?",
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        // 읽기 완료 버튼
                                                                        Center(
                                                                          child:
                                                                              TextButton(
                                                                            child:
                                                                                const Text(
                                                                              "읽기 완료",
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              try {
                                                                                // 서버와 통신
                                                                                // 도서 읽기 완료 한다.
                                                                                final response = await dio.put(
                                                                                  "http://${IpAddress.hyunukIP}/bookshelves/addFinished?memberId=${UserInfo.userValue}&bookId=${nowReadBooks[index].itemId}",
                                                                                  options: Options(
                                                                                    headers: {
                                                                                      "Authorization": "Bearer ${UserInfo.token}",
                                                                                    },
                                                                                    validateStatus: (_) => true,
                                                                                    contentType: Headers.jsonContentType,
                                                                                    responseType: ResponseType.json,
                                                                                  ),
                                                                                );

                                                                                if (response.statusCode == 200) {
                                                                                  // 다이어로그를 삭제한다.
                                                                                  Get.back();

                                                                                  Get.snackbar(
                                                                                    "도서 읽기 완료 성공",
                                                                                    "해당 도서 읽기 완료 성공하였습니다",
                                                                                    duration: const Duration(seconds: 3),
                                                                                    snackPosition: SnackPosition.TOP,
                                                                                  );

                                                                                  // 화면을 재랜더링 한다.
                                                                                  setState(() {});
                                                                                }
                                                                                //
                                                                                else {
                                                                                  // 다이어로그를 삭제한다.
                                                                                  Get.back();

                                                                                  Get.snackbar(
                                                                                    "도서 읽기 완료 반영 실패",
                                                                                    "해당 도서 읽기 완료 반영이 되지 않았습니다\n다시 시도해주세요",
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
                                                                            },
                                                                          ),
                                                                        ),

                                                                        // 나가기 버튼
                                                                        Center(
                                                                          child:
                                                                              TextButton(
                                                                            child:
                                                                                const Text(
                                                                              "나가기",
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              // 다이어로그를 삭제한다.
                                                                              Get.back();
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
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
                                                            horizontal: 10.w,
                                                            vertical: 10.h,
                                                          ),
                                                        ),
                                                        child:
                                                            const Text("읽기 완료"),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // 중간 공백
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
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
                                      "읽고 있는 도서가 없습니다",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          "읽고 있는 도서",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        onTapPadding: 10,
                        closedHeight: 70.h,
                        scrollable: true,
                        borderRadius: 10.r,
                        openedHeight: 400.h,
                      ),

                      // 중간 공백
                      SizedBox(height: 30.sp),

                      // 읽은 도서
                      TapToExpand(
                        color: Colors.purple,
                        content: Center(
                          child: SizedBox(
                            width: 300.w,
                            height: 350.h,
                            child: readBooks.isNotEmpty
                                ? ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: readBooks.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        // 도서 상세 페이지로 라우팅
                                        // 해당 도서 데이터를 arguments로 전달하며 이것이 읽은 도서을 알려야 한다.
                                        Get.to(
                                          () => BookShowPreview(),
                                          arguments: readBooks[index],
                                        );
                                      },
                                      child: SizedBox(
                                        width: 250.w,
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
                                            children: [
                                              // 삭제하기 버튼
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    // 삭제하는 다이어로그가 나온다.
                                                    Get.dialog(
                                                      AlertDialog(
                                                        title: const Text(
                                                          "읽은 도서에서 삭제하기",
                                                        ),
                                                        content: SizedBox(
                                                          width: 100.w,
                                                          height: 150.h,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              // 텍스트
                                                              const Text(
                                                                "읽은 도서에서 삭제하시겠습니까?",
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  // 삭제하기 버튼
                                                                  Center(
                                                                    child:
                                                                        TextButton(
                                                                      child:
                                                                          const Text(
                                                                        "삭제하기",
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        try {
                                                                          // 서버와 통신
                                                                          // 읽은 도서를 삭제한다.
                                                                          final response =
                                                                              await dio.delete(
                                                                            "http://${IpAddress.hyunukIP}/bookshelves/removeBook?memberId=${UserInfo.userValue}&bookId=${readBooks[index].itemId}&param=2",
                                                                            options:
                                                                                Options(
                                                                              headers: {
                                                                                "Authorization": "Bearer ${UserInfo.token}",
                                                                              },
                                                                              validateStatus: (_) => true,
                                                                              contentType: Headers.jsonContentType,
                                                                              responseType: ResponseType.json,
                                                                            ),
                                                                          );

                                                                          if (response.statusCode ==
                                                                              200) {
                                                                            // 다이어로그를 삭제한다.
                                                                            Get.back();

                                                                            Get.snackbar(
                                                                              "읽은 도서 삭제 성공",
                                                                              "읽은 도서 삭제 성공하였습니다",
                                                                              duration: const Duration(seconds: 3),
                                                                              snackPosition: SnackPosition.TOP,
                                                                            );

                                                                            // 화면을 재랜더링 한다.
                                                                            setState(() {});
                                                                          }
                                                                          //
                                                                          else {
                                                                            Get.snackbar(
                                                                              "읽은 도서 삭제 실패",
                                                                              "읽은 도서 삭제 실패하였습니다\n다시 시도해주세요",
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
                                                                            duration:
                                                                                const Duration(seconds: 3),
                                                                            snackPosition:
                                                                                SnackPosition.TOP,
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),

                                                                  // 나가기 버튼
                                                                  Center(
                                                                    child:
                                                                        TextButton(
                                                                      child:
                                                                          const Text(
                                                                        "나가기",
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        // 다이어로그를 삭제한다.
                                                                        Get.back();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(Icons.clear),
                                                ),
                                              ),

                                              // 도서 분야
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0.w,
                                                  ),
                                                  child: Text(
                                                    category[readBooks[index]
                                                            .categoryId]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                              ),

                                              // 중간 공백
                                              SizedBox(height: 20.h),

                                              // 도서 이미지
                                              Image.network(
                                                readBooks[index].coverSmallUrl,
                                                width: 150.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.high,
                                              ),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${readBooks_completed_dateTime[index]} 읽기 완료",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),

                                              // 중간 공백
                                              SizedBox(height: 10.h),

                                              // 도서 제목
                                              Text(
                                                readBooks[index].title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),

                                              // 중간 공백
                                              SizedBox(height: 10.h),
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
                                      "읽은 도서가 없습니다",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        title: Text(
                          "읽은 도서",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        onTapPadding: 10,
                        closedHeight: 70.h,
                        scrollable: true,
                        borderRadius: 10.r,
                        openedHeight: 350.h,
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
