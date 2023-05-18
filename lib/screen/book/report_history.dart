// 신고 내역 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/report_history_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ReportHistory extends StatefulWidget {
  const ReportHistory({super.key});

  @override
  State<ReportHistory> createState() => _ReportHistoryState();
}

class _ReportHistoryState extends State<ReportHistory> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

  // 사용자 신고 데이터를 모아두는 배열
  List<Map<String, dynamic>> reports = [];

  // 서버를 사용하기 위한 변수
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    print("Report History initState 시작");
  }

  @override
  void dispose() {
    print("Report History state 종료");
    super.dispose();
  }

  // 신고 데이터를 가져오는 함수
  Future<void> getReports() async {
    reports.clear();

    try {
      final response = await dio.get(
        'http://${IpAddress.hyunukIP}/reviews/getAllreports',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // 서버와 통신 성공
      // 회원 정보를 데이터베이스에 등록한다.
      if (response.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 제공해주는 데이터 : ${response.data}");

        for (var map in response.data) {
          reports.add(map as Map<String, dynamic>);
        }

        print("reports : $reports");
      }
      // 서버와 통신 실패
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
    return FutureBuilder(
      future: getReports(),
      builder: (context, snapshot) {
        // getReports()를 실행하는 동안...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
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

                  // 사용자 신고 데이터들을 가져오고 있습니다.
                  Text(
                    "사용자 신고 데이터를 가져오고 있습니다",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // getReports()를 실행한 후....
        else {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이전 페이지 아이콘
                        IconButton(
                          onPressed: () {
                            Get.off(() => BookFluidNavBar());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 20),

                        // 신고 내역 Text
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
                                    "신고 내역",
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

                        // 사용자 이름 혹은 아이디로 검색
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimSearchBar(
                            width: 300,
                            textController: searchTextController,
                            helpText: "사용자 이름 또는 아이디 검색",
                            suffixIcon: const Icon(Icons.arrow_back),
                            onSuffixTap: () {
                              // 값이 비어있는 상태로 검색
                              setState(() {
                                searchTextController.clear();
                              });
                            },
                            onSubmitted: (String value) {
                              // 사용자 이름 또는 아이디로 검색헸으면?
                              setState(() {});
                            },
                          ),
                        ),

                        // 사용자 계정 목록
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Card(
                              elevation: 10.0,
                              color: Colors.white,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: SizedBox(
                                width: 450,
                                height: 600,
                                child: Column(
                                  children: [
                                    // 번호, 사용자 이름, 아이디, 날짜
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          // 번호
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "번호",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // 중간 공백
                                          SizedBox(width: 30),

                                          // 사용자명
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "사용자명",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // 중간 공백
                                          SizedBox(width: 30),

                                          // 아이디
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "아이디",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          // 중간 공백
                                          SizedBox(width: 30),

                                          // 신고 날짜
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "신고 날짜",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    // 일지 리스트
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: reports.length,
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            // 신고 내역 자세히 보여주기 페이지로 라우팅
                                            Get.off(
                                              () =>
                                                  const ReportHistoryShowPreview(),
                                              arguments: reports[index],
                                            );
                                          },
                                          child: Container(
                                            color: Colors.yellow[50],
                                            width: 200,
                                            height: 100,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  // 번호
                                                  SizedBox(
                                                    width: 50,
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(reports[index]
                                                              ["member"]["id"]
                                                          .toString()),
                                                    ),
                                                  ),
                                                  // 사용자명
                                                  SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(reports[index]
                                                          ["member"]["name"]),
                                                    ),
                                                  ),
                                                  // 아이디
                                                  SizedBox(
                                                    width: 100,
                                                    height: 100,
                                                    child: Center(
                                                      child: Text(reports[index]
                                                              ["member"]
                                                          ["account"]),
                                                    ),
                                                  ),

                                                  // 중간 공백
                                                  const SizedBox(width: 20),

                                                  // 신고 당한 날짜
                                                  Text(reports[index]
                                                          ["createdAt"]
                                                      .toString()
                                                      .substring(0, 10)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 50),
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
