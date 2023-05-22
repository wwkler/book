// 목표 설정/수정하는 페이지
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_my_goal_edit2.dart';
import 'package:book_project/screen/book/book_my_goal_edit3.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'book_fluid_nav_bar.dart';

class BookMyGoalEdit1 extends StatefulWidget {
  const BookMyGoalEdit1({super.key});

  @override
  State<BookMyGoalEdit1> createState() => _BookMyGoalEdit1State();
}

class _BookMyGoalEdit1State extends State<BookMyGoalEdit1> {
  // 목표 선택할 도서 분야에 대한 변수
  Map<String, int> category = {
    "국내도서>소설": 101,
    "국내도서>시/에세이": 102,
    "국내도서>예술/대중문화": 103,
    "국내도서>사회과학": 104,
    "국내도서>역사와 문화": 105,
    "국내도서>잡지": 107,
    "국내도서>만화": 108,
    "국내도서>유아": 109,
    "국내도서>아동": 110,
    "국내도서>가정과 생활": 111,
    "국내도서>청소년": 112,
    "국내도서>초등학습서": 113,
    "국내도서>고등학습서": 114,
    "국내도서>국어/외국어/사전": 115,
    "국내도서>자연과 과학": 116,
    "국내도서>경제경영": 117,
    "국내도서>자기계발": 118,
    "국내도서>인문": 119,
    "국내도서>종교/역학": 120,
    "국내도서>컴퓨터/인터넷": 122,
    "국내도서>자격서/수험서": 123,
    "국내도서>취미/레저": 124,
    "국내도서>전공도서/대학교재": 125,
    "국내도서>건강/뷰티": 126,
    "국내도서/여행": 128,
    "국내도서>중등학습서": 129,
  };
  String selectedCategory = "국내도서>소설";
  int selectedCode = 101;

  // 목표 도서 권수에 대한 변수
  final readBooksCountController = TextEditingController();

  // 목표 설정 변수
  String objDate = "목표 기간을 설정해주세요";

  // 이전 페이지에서 받은 배열 objectives
  List<Map<String, dynamic>>? objectives;

  // 현재 시간
  DateTime? currentTime;

  // 서버 통신 사용함
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    print("Book My Goal Edit1 initState 시작");
    objectives = Get.arguments;
  }

  @override
  void dispose() {
    print("Book My Goal Edit1 dispose 시작");
    super.dispose();
  }

  // 날짜를 format 시켜주는 함수
  String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  // 한국 시간을 얻기 위한 함수
  Future<void> getKoreanTime() async {
    // 한국 시간을 얻는다.
    currentTime = await NTP.now();
    currentTime = currentTime!.toUtc().add(const Duration(hours: 9));
    print(currentTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getKoreanTime(),
      builder: (context, snapshot) {
        // getKoreanTime을 실행하고 있으면?...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
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

                    Text(
                      "기다려주세요",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // getKoreanTime을 실행 완료 했으면?...
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 중간 공백
                        const SizedBox(height: 10),

                        // 이전 페이지 아이콘, 목표 1, 목표 2, 목표 3 버튼
                        Row(
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
                            const SizedBox(
                              width: 20,
                            ),

                            // 목표 1
                            Card(
                              elevation: 10.0,
                              color: Colors.purple[200],
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const SizedBox(
                                width: 80,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "목표 1",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 목표 2
                            GestureDetector(
                              onTap: () {
                                // 목표 2 페이지로 라우팅
                                Get.off(
                                  () => BookMyGoalEdit2(),
                                  arguments: objectives,
                                );
                              },
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 233, 227, 234),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "목표 2",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 목표 3
                            GestureDetector(
                              onTap: () {
                                // 목표 3 페이지로 라우팅
                                Get.off(
                                  () => BookMyGoalEdit3(),
                                  arguments: objectives,
                                );
                              },
                              child: Card(
                                elevation: 10.0,
                                color: const Color.fromARGB(255, 233, 227, 234),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: const SizedBox(
                                  width: 80,
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "목표 3",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // 중간 공백
                        const SizedBox(height: 50),

                        // 목표 선택할 도서 분야 Text
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
                                    "목표 선택할 도서 분야",
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
                        const SizedBox(height: 25),

                        // 목표 선택할 도서 분야 설정
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.purple,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "선호하는 도서 장르",
                              hintText: "인문",
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                            value: selectedCategory,
                            onChanged: (String? key) {
                              setState(() {
                                selectedCategory = key!;
                                selectedCode = category[key]!;
                                print(selectedCode);
                              });
                            },
                            items: category.keys
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 50),

                        // 목표 도서 권수 Text
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
                                    "목표 도서 권수",
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

                        // 목표 도서 권수 설정
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: TextField(
                                controller: readBooksCountController,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 5),

                        // 목표 도서 권수 설정할 떄 주의사항
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.warning, color: Colors.red),
                              const SizedBox(width: 10),
                              Text(
                                "숫자만 입력, 최소 1자 최대 2자 입력 가능",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 40),

                        // 목표 설정 기간 Text
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
                                    "목표 설정 기간",
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
                        const SizedBox(height: 25),

                        // 목표 기간 설정하는 버튼
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final currentTime = await NTP.now();
                                // ignore: use_build_context_synchronously
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  initialDate: currentTime
                                      .toUtc()
                                      .add(const Duration(days: 1)),
                                  firstDate: currentTime
                                      .toUtc()
                                      .add(const Duration(days: 1)),
                                  lastDate: DateTime.utc(2023, 12, 31),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    objDate = formatDate(selectedDate);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10,
                                ),
                              ),
                              child: objDate == "목표 기간을 설정해주세요"
                                  ? const Text(
                                      "목표 기간을 설정해주세요",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  : Text(
                                      "$objDate까지",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 50),

                        // 아예 서버에서 받아온 목표 데이터가 없거나 , endDate가 현재 시간보다 작으면 목표 설정하기 버튼을 보여준다.
                        // endDate가 현재 시간보다 크면 목표 수정하기 버튼을 보여준다.
                        objectives![0]["data"] == "none" ||
                                objectives![0]["endDate"]
                                        .toString()
                                        .compareTo(formatDate(currentTime!)) <
                                    0

                            // 목표 설정하기 버튼 나옴
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // 검증하기
                                      if (readBooksCountController
                                                  .text.length >=
                                              1 &&
                                          readBooksCountController.text.length <
                                              3 &&
                                          objDate != "목표 기간을 설정해주세요") {
                                        try {
                                          // 서버와 통신
                                          final response = await dio.post(
                                            'http://${IpAddress.hyunukIP}/goal',
                                            // 서버에 보내야 하는 데이터
                                            data: {
                                              // 사용자 고유값
                                              "memberId": UserInfo.userValue,

                                              // 목표 이름
                                              "goalname": "목표_1_${UserInfo.id}",

                                              // 도서 카테코리 번호
                                              "categoryId": selectedCode,

                                              // 목표 도서량
                                              "targetQuantity": int.parse(
                                                readBooksCountController.text,
                                              ),

                                              // 읽은 책 갯수(0으로 초기 설정)
                                              "readed": 0,

                                              // 시작일
                                              "startDate":
                                                  formatDate(currentTime!),

                                              // 목표일
                                              "endDate": objDate,

                                              // 완료 여부(false로 초기설정)
                                              "completed": false,
                                            },
                                            options: Options(
                                              validateStatus: (_) => true,
                                              contentType:
                                                  Headers.jsonContentType,
                                              responseType: ResponseType.json,
                                            ),
                                          );

                                          // 서버와 통신 성공
                                          if (response.statusCode == 200) {
                                            print("서버와 통신 성공");
                                            print(
                                                "서버에서 제공해주는 데이터 : ${response.data}");

                                            Get.snackbar(
                                              "목표1 설정하기 반영 성공",
                                              "목표1 설정하기 반영 성공하였습니다",
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition: SnackPosition.TOP,
                                            );

                                            // 라우팅
                                            Get.off(() => BookFluidNavBar());
                                          }
                                          // 서버와 통신 실패
                                          else {
                                            print("서버와 통신 실패");
                                            print(
                                                "서버 통신 에러 코드 : ${response.statusCode}");

                                            Get.snackbar(
                                              "목표1 설정하기 반영 실패",
                                              "목표1 설정하기 반영 실패하였습니다\n다시 시도해주세요",
                                              duration:
                                                  const Duration(seconds: 5),
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
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      }
                                      //
                                      else {
                                        Get.snackbar(
                                          "이상 메시지",
                                          "클라이언트에서 입력을 적합하지 않게 하였습니다.",
                                          duration: const Duration(seconds: 5),
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 20,
                                      ),
                                    ),
                                    child: const Text(
                                      "목표 설정하기",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                            // 목표 수정하기 버튼 나옴
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      //검증하기
                                      if (readBooksCountController.text.length >= 1 &&
                                          readBooksCountController.text.length <
                                              3 &&
                                          objDate != "목표 기간을 설정해주세요") {
                                        try {
                                          // 서버와 통신
                                          final response = await dio.put(
                                            'http://${IpAddress.hyunukIP}/goal/update',
                                            // 서버에 보내야 하는 데이터
                                            data: {
                                              // 목표 이름
                                              "goalname": objectives![0]
                                                  ["goalname"],

                                              // 도서 카테코리 번호
                                              "categoryId": selectedCode,

                                              // 목표 도서량
                                              "targetQuantity": int.parse(
                                                readBooksCountController.text,
                                              ),

                                              // 읽은 책 갯수(0으로 초기 설정)
                                              "readed": 0,

                                              // 시작일
                                              "startDate":
                                                  formatDate(currentTime!),

                                              // 목표일
                                              "endDate": objDate,

                                              // 완료 여부
                                              // "completed": ,
                                            },
                                            options: Options(
                                              validateStatus: (_) => true,
                                              contentType:
                                                  Headers.jsonContentType,
                                              responseType: ResponseType.json,
                                            ),
                                          );

                                          // 서버와 통신 성공
                                          if (response.statusCode == 200) {
                                            print("서버와 통신 성공");
                                            print(
                                                "서버에서 제공해주는 데이터 : ${response.data}");

                                            Get.snackbar(
                                              "목표1 수정 반영 성공",
                                              "목표1 수정 반영 성공하였습니다",
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                          // 서버와 통신 실패
                                          else {
                                            print("서버와 통신 실패");
                                            print(
                                                "서버 통신 에러 코드 : ${response.statusCode}");

                                            Get.snackbar(
                                              "목표1 수정 반영 실패",
                                              "목표1 수정 반영 실패하였습니다\n다시 시도해주세요",
                                              duration:
                                                  const Duration(seconds: 5),
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
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      }
                                      //
                                      else {
                                        Get.snackbar(
                                          "이상 메시지",
                                          "클라이언트에서 입력을 적합하지 않게 하였습니다.",
                                          duration: const Duration(seconds: 5),
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      backgroundColor: Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 20,
                                      ),
                                    ),
                                    child: const Text(
                                      "목표 수정하기",
                                      style: TextStyle(fontSize: 15),
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
          );
        }
      },
    );
  }
}
