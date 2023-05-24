// 목표 설정/수정하는 페이지
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_my_goal.dart';
import 'package:book_project/screen/book/book_my_goal_edit1.dart';
import 'package:book_project/screen/book/book_my_goal_edit3.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'book_fluid_nav_bar.dart';

class BookMyGoalEdit2 extends StatefulWidget {
  const BookMyGoalEdit2({super.key});

  @override
  State<BookMyGoalEdit2> createState() => _BookMyGoalEdit2State();
}

class _BookMyGoalEdit2State extends State<BookMyGoalEdit2> {
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

  // 서버를 사용하는 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book My Goal Edit2 initState 시작");
    super.initState();
    objectives = Get.arguments;
  }

  @override
  void dispose() {
    print("Book My Goal Edit2 dispose 시작");
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
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 가능하다.
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width.w,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 프로그래스바
                      const CircularProgressIndicator(),

                      // 중간 공백
                      SizedBox(height: 40.h),

                      Text(
                        "기다려주세요",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        // getKoreanTime을 실행 완료 했으면?...
        else {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로 가기가 가능하다.
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width.w,
                    // 배경 이미지
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: UserInfo.identity == UserManagerCheck.user
                            ? const AssetImage(
                                "assets/imgs/background_book1.jpg")
                            : const AssetImage(
                                "assets/imgs/background_book2.jpg"),
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
                          SizedBox(height: 10.h),

                          // 이전 페이지 아이콘, 목표 1, 목표 2, 목표 3 버튼
                          Row(
                            children: [
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

                              // 중간 공백
                              SizedBox(
                                width: 20.w,
                              ),

                              // 목표 1
                              GestureDetector(
                                onTap: () {
                                  // 목표 1 페이지로 라우팅
                                  Get.off(
                                    () => const BookMyGoalEdit1(),
                                    arguments: objectives,
                                  );
                                },
                                child: Card(
                                  elevation: 10.0,
                                  color:
                                      const Color.fromARGB(255, 233, 227, 234),
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0.r),
                                  ),
                                  child: SizedBox(
                                    width: 80.w,
                                    height: 50.h,
                                    child: Center(
                                      child: Text(
                                        "목표 1",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 목표 2
                              Card(
                                elevation: 10.0,
                                color: Colors.purple[200],
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                  width: 80.w,
                                  height: 50.h,
                                  child: Center(
                                    child: Text(
                                      "목표 2",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 목표 3
                              GestureDetector(
                                onTap: () {
                                  Get.off(
                                    () => const BookMyGoalEdit3(),
                                    arguments: objectives,
                                  );
                                },
                                child: Card(
                                  elevation: 10.0,
                                  color:
                                      const Color.fromARGB(255, 233, 227, 234),
                                  shadowColor: Colors.grey.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SizedBox(
                                    width: 80.w,
                                    height: 50.h,
                                    child: Center(
                                      child: Text(
                                        "목표 3",
                                        style: TextStyle(
                                          fontSize: 15.sp,
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
                          SizedBox(height: 50.h),

                          // 목표 선택할 도서 분야 Text
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
                                      "목표 선택할 도서 분야",
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
                          SizedBox(height: 25.h),

                          // 목표 선택할 도서 분야 설정
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "선호하는 도서 장르",
                                hintText: "인문",
                                labelStyle:
                                    const TextStyle(color: Colors.purple),
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
                          SizedBox(height: 50.h),

                          // 목표 도서 권수 Text
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
                                      "목표 도서 권수",
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

                          // 목표 도서 권수 설정
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: 50.w,
                                height: 50.h,
                                child: TextField(
                                  controller: readBooksCountController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          ),

                          // 중간 공백
                          SizedBox(height: 5.h),

                          // 목표 도서 권수 설정할 떄 주의사항
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.warning, color: Colors.red),
                                SizedBox(width: 10.w),
                                Text(
                                  "숫자만 입력, 최소 1자 최대 2자 입력 가능",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 중간 공백
                          SizedBox(height: 40.h),

                          // 목표 설정 기간 Text
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
                                      "목표 설정 기간",
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
                          SizedBox(height: 25.h),

                          // 목표 설정 기간 버튼
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
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ),
                                  backgroundColor: Colors.purple,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.w,
                                    vertical: 10.h,
                                  ),
                                ),
                                child: objDate == "목표 기간을 설정해주세요"
                                    ? Text(
                                        "목표 기간을 설정해주세요",
                                        style: TextStyle(fontSize: 15.sp),
                                      )
                                    : Text(
                                        "$objDate까지",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                              ),
                            ),
                          ),

                          // 중간 공백
                          SizedBox(height: 50.h),

                          // 아예 서버에서 받아온 목표 데이터가 없거나 , endDate가 현재 시간보다 작으면 목표 설정하기 버튼을 보여준다.
                          // endDate가 현재 시간보다 같거나 크면 목표 수정하기 버튼을 보여준다.
                          objectives![1]["data"] == "none" ||
                                  objectives![1]["endDate"]
                                          .toString()
                                          .compareTo(
                                              formatDate(DateTime.now())) <
                                      0

                              // 목표 설정하기 버튼 나옴
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //검증하기
                                        if (readBooksCountController
                                                    .text.length >=
                                                1 &&
                                            readBooksCountController
                                                    .text.length <
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
                                                "goalname":
                                                    "목표_2_${UserInfo.id}",

                                                // 도서 카테코리 번호
                                                "categoryId": selectedCode,

                                                // 목표 도서량
                                                "targetQuantity": int.parse(
                                                  readBooksCountController.text,
                                                ),

                                                // 읽은 도서 갯수(0으로 초기 설정)
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

                                              Get.offAll(
                                                () => BookFluidNavBar(
                                                  route: BookMyGoal(),
                                                  routeIndex: 1,
                                                ),
                                              );

                                              Get.snackbar(
                                                "목표2 설정하기 반영 성공",
                                                "목표2 설정하기 반영 성공하였습니다",
                                                duration:
                                                    const Duration(seconds: 3),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                            }
                                            // 서버와 통신 실패
                                            else {
                                              print("서버와 통신 실패");
                                              print(
                                                  "서버 통신 에러 코드 : ${response.statusCode}");

                                              Get.snackbar(
                                                "목표2 설정하기 반영 실패",
                                                "목표2 설정하기 반영 실패하였습니다\n다시 시도해주세요",
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
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        }
                                        //
                                        else {
                                          Get.snackbar(
                                            "이상 메시지",
                                            "클라이언트에서 입력을 적합하지 않게 하였습니다.",
                                            duration:
                                                const Duration(seconds: 3),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0.r),
                                        ),
                                        backgroundColor: Colors.purple,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 20.h,
                                        ),
                                      ),
                                      child: Text(
                                        "목표 설정하기",
                                        style: TextStyle(fontSize: 15.sp),
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
                                        DateTime dt = DateTime.now();
                                        //검증하기
                                        if (readBooksCountController
                                                    .text.length >=
                                                1 &&
                                            readBooksCountController
                                                    .text.length <
                                                3 &&
                                            objDate != "목표 기간을 설정해주세요") {
                                          try {
                                            // 서버와 통신
                                            final response = await dio.put(
                                              'http://${IpAddress.hyunukIP}/goal/update',
                                              // 서버에 보내야 하는 데이터
                                              data: {
                                                // 목표 이름
                                                "goalname": objectives![1]
                                                    ["goalname"],

                                                // 도서 카테코리 번호
                                                "categoryId": selectedCode,

                                                // 목표 도서량
                                                "targetQuantity": int.parse(
                                                  readBooksCountController.text,
                                                ),

                                                // 읽은 도서 갯수(0으로 초기 설정)
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

                                              Get.offAll(
                                                () => BookFluidNavBar(
                                                  route: BookMyGoal(),
                                                  routeIndex: 1,
                                                ),
                                              );

                                              Get.snackbar(
                                                "목표2 수정 반영 성공",
                                                "목표2 수정 반영 성공하였습니다",
                                                duration:
                                                    const Duration(seconds: 3),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                            }
                                            // 서버와 통신 실패
                                            else {
                                              print("서버와 통신 실패");
                                              print(
                                                  "서버 통신 에러 코드 : ${response.statusCode}");

                                              Get.snackbar(
                                                "목표2 수정 반영 실패",
                                                "목표2 수정 반영 실패하였습니다\n다시 시도해주세요",
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
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        }
                                        //
                                        else {
                                          Get.snackbar(
                                            "이상 메시지",
                                            "클라이언트에서 입력을 적합하지 않게 하였습니다.",
                                            duration:
                                                const Duration(seconds: 3),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0.r),
                                        ),
                                        backgroundColor: Colors.purple,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30.w,
                                          vertical: 20.h,
                                        ),
                                      ),
                                      child: Text(
                                        "목표 수정하기",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                    ),
                                  ),
                                )
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
