// 도서 나만의 목표 페이지
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_my_goal_edit1.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_to_expand/tap_to_expand.dart';

class BookMyGoal extends StatefulWidget {
  BookMyGoal({Key? key}) : super(key: key);

  @override
  State<BookMyGoal> createState() => _BookMyGoalState();
}

class _BookMyGoalState extends State<BookMyGoal> {
  // 읽고 있는 책의 진행도를 설정하기 위한 변수
  final editPageController = TextEditingController();

  // 목표 1, 2, 3 데이터를 담는 배열
  List<Map<String, dynamic>> objectives = [
    {"data": "none"},
    {"data": "none"},
    {"data": "none"},
  ];

  // 읽고 싶은 도서 (배열)

  // 읽고 있는 도서 (배열)

  // 읽은 도서 (배열)

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
  Future<void> getMyGoals() async {
    // 서버와 통신
    // 서버에 목표 1 데이터가 있는지 확인한다.
    final response1 = await dio.get(
      "http://116.122.96.53:8080/goal/isExist?goalname=목표_1_${UserInfo.id}",
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // 목표 1 데이터가 있을 떄.... -> 목표 1과 관련된 내용을 서버를 통해 가져온다.
    if (response1.data == true) {
      final response1_1 = await dio.get(
        "http://116.122.96.53:8080/goal/getByGoalname?goalname=목표_1_${UserInfo.id}",
        options: Options(
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

    // 목표 2과 관련된 내용을 서버를 통해 가져온다.
    final response2 = await dio.get(
      "http://116.122.96.53:8080/goal/isExist?goalname=목표_2_winner23456",
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // 목표 2 데이터가 있을 떄.... -> 목표 2과 관련된 내용을 서버를 통해 가져온다.
    if (response2.data == true) {
      final response2_2 = await dio.get(
        "http://116.122.96.53:8080/goal/getByGoalname?goalname=목표_2_winner23456",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response2_2.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 목표 1 받은 데이터 : ${response2_2.data}");
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

    // 목표 3과 관련된 내용을 서버를 통해 가져온다.
    print("objectives : $objectives");
  }

  @override
  Widget build(BuildContext context) {
    print("Book_my_goal build 시작");

    return FutureBuilder(
      future: getMyGoals(),
      builder: (context, snapshot) {
        // getMyGoals()를 실행하는 동안만 실행
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
        // GetMyGoals()를 실행하고 난 후...
        else {
          return SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 중간 공백
                    const SizedBox(height: 30),

                    // 목표 확인, 사용사 서재 Text
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
                                "목표 확인 및 사용자 서재",
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
                    const SizedBox(height: 30),

                    // 목표 설정/수정하기 버튼
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // 화면을 라우팅하면서 목표 1, 2, 3를 관리하는 배열 objectives를 같이 넘긴다.
                          Get.off(
                            () => BookMyGoalEdit1(),
                            arguments: objectives,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 20.0,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "목표 설정/수정",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 25),

                    // 1번째 목표, 2번쨰 목표, 3번쨰 목표
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 목표 1를 눌렀을 떄 다이어로그를 표시한다.
                          GestureDetector(
                            onTap: () {
                              // 목표 1과 관련된 dialog를 요약적으로 보여준다.
                              Get.dialog(
                                // 목표 1과 관련되서 데이터가 없거나, 현재 시간이 endTime보다 클 경우
                                //  // 목표를 설정해야 한다고 알림 메시지를 보여준다.

                                // 현재 시간이 endTime보다 작을 경우
                                // 목표 1 데이터에 대해서 자세히 보여준다.
                                //
                                AlertDialog(
                                  title: const Text("목표 1"),
                                  content: SizedBox(
                                    width: 100,
                                    height: 150,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 진행 기간
                                          Text(
                                              "진행 기간 : 2023-04-21 ~ 2023-05-21"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 도서 분야
                                          Text("도서 분야 : 국내도서/여행"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 목표 권수
                                          Text("목표 권수 : 10권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 권수
                                          Text("진행 권수 : 5권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 로고인 페이지로 이동하는 버튼
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
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

                          // 목표 2
                          GestureDetector(
                            onTap: () {
                              // 목표 2와 관련된 dialog를 요약적으로 보여준다.
                              Get.dialog(
                                AlertDialog(
                                  title: const Text("목표 2"),
                                  content: SizedBox(
                                    width: 100,
                                    height: 150,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 진행 기간
                                          Text(
                                              "진행 기간 : 2023-04-21 ~ 2023-05-21"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 도서 분야
                                          Text("도서 분야 : 국내도서/여행"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 목표 권수
                                          Text("목표 권수 : 10권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 권수
                                          Text("진행 권수 : 5권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 로고인 페이지로 이동하는 버튼
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
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

                          // 목표 3
                          GestureDetector(
                            onTap: () {
                              // 목표 3와 관련된 dialog를 요약적으로 보여준다.
                              Get.dialog(
                                AlertDialog(
                                  title: const Text("목표 3"),
                                  content: SizedBox(
                                    width: 100,
                                    height: 150,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // 진행 기간
                                          Text(
                                              "진행 기간 : 2023-04-21 ~ 2023-05-21"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 도서 분야
                                          Text("도서 분야 : 국내도서/여행"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 목표 권수
                                          Text("목표 권수 : 10권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 진행 권수
                                          Text("진행 권수 : 5권"),

                                          // 중간 공백
                                          const SizedBox(height: 20),

                                          // 로고인 페이지로 이동하는 버튼
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 228, 201, 232),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
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
                    ),

                    // 중간 공백
                    const SizedBox(height: 25),

                    // 목표와 관련된 여러 정보들을 취합해서 Card로 나타낸다.
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
                                        "목표와 관련된 분석 내용",
                                        //"목표를 설정해주세요",
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

                    // 읽고 싶은 도서
                    TapToExpand(
                      color: Colors.purple,
                      content: Center(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // 도서 상세 페이지로 라우팅
                                // 해당 도서 데이터를 arguments로 전달하며 이것이 읽고 싶은 도서임을 알려야 한다.
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

                                    // 도서 제목
                                    Text("도서입니다."),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        // 읽고 싶은 도서 삭제하기
                                        ElevatedButton(
                                          onPressed: () {
                                            // 클라이언트에서 해당 책을 삭제하고 서버와 통신
                                            // 서버는 읽고 싶은 책에서 해당 책을 삭제한다.
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Colors.purple,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                          ),
                                          child: const Text("삭제하기"),
                                        ),

                                        // 중간 공백
                                        const SizedBox(width: 10),

                                        // 책 읽기
                                        ElevatedButton(
                                          onPressed: () {
                                            // 클라이언트에서 해당 책을 삭제하고 읽고 있는 책으로 등록한다.

                                            // 서버와 통신
                                            // 서버는 읽고 싶은 책에서 해당 책을 삭제한다.
                                            // 서버는 읽고 있는 책으로 해당 책을 등록한다.
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Colors.purple,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                          ),
                                          child: Text("도서 읽기"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        "읽고 싶은 도서",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onTapPadding: 10,
                      closedHeight: 70,
                      scrollable: true,
                      borderRadius: 10,
                      openedHeight: 400,
                    ),

                    // 중간 공백
                    const SizedBox(height: 30),

                    // 읽고 있는 도서
                    TapToExpand(
                      color: Colors.purple,
                      content: Center(
                        child: SizedBox(
                          width: 350,
                          height: 350,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // 도서 상세 페이지로 라우팅
                                // 해당 도서 데이터를 arguments로 전달하며 이것이 읽고 있는 도서을 알려야 한다.
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

                                    const Text("2023-4-21 읽기 시작"),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    // 도서 제목
                                    const Text("도서입니다."),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    // 진행도 확인
                                    GestureDetector(
                                      onTap: () {
                                        Get.dialog(
                                          AlertDialog(
                                            title: const Text('진행도 수정'),
                                            content: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  // Text
                                                  const Text("진행도 수정할 페이지를 입력"),

                                                  // 중간 공백
                                                  const SizedBox(height: 10),

                                                  // TextField
                                                  SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          editPageController,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text("적용하기"),
                                                onPressed: () {
                                                  print(int.parse(
                                                      editPageController.text));

                                                  // 클라이언트에 읽은 페이지를 업데이트하고
                                                  // 서버와 통신
                                                  // 서버는 해당 책에 대한 읽은 페이지를 업데이트한다.

                                                  // 만약 클라이언트에서 해당 책에 대한 최종 페이지를 입력했다면
                                                  // 클라이언트는 읽고 있는 책에서 해당 책을 삭제하고 읽은 책으로 등록한다.
                                                  // 서버와 통신
                                                  // 서버는 읽고 있는 책에서 해당 책을 삭제하고 읽은 책으로 등록한다.
                                                  editPageController.text = "";
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 10.0,
                                        shadowColor:
                                            Colors.grey.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: const SizedBox(
                                          width: 100,
                                          height: 30,
                                          child: Center(
                                            child: Text(
                                              "100/500",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
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
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        "읽고 있는 도서",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onTapPadding: 10,
                      closedHeight: 70,
                      scrollable: true,
                      borderRadius: 10,
                      openedHeight: 400,
                    ),

                    // 중간 공백
                    const SizedBox(height: 30),

                    // 읽은 도서
                    TapToExpand(
                      color: Colors.purple,
                      content: Center(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // 도서 상세 페이지로 라우팅
                                // 해당 도서 데이터를 arguments로 전달하며 이것이 읽은 도서을 알려야 한다.
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

                                    Text("2023-4-21 읽기 완료"),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    // 도서 제목
                                    Text("도서입니다."),

                                    // 중간 공백
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        "읽은 도서",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onTapPadding: 10,
                      closedHeight: 70,
                      scrollable: true,
                      borderRadius: 10,
                      openedHeight: 400,
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
