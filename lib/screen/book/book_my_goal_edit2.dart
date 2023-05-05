// 목표 설정/수정하는 페이지
import 'package:book_project/screen/book/book_my_goal_edit1.dart';
import 'package:book_project/screen/book/book_my_goal_edit3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    print("Book My Goal Edit2 initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book My Goal Edit2 dispose 시작");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      GestureDetector(
                        onTap: () {
                          // 목표 1 페이지로 라우팅
                          Get.off(() => BookMyGoalEdit1());
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
                                "목표 1",
                                style: TextStyle(
                                  fontSize: 15,
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

                      // 목표 3
                      GestureDetector(
                        onTap: () {
                          Get.off(() => BookMyGoalEdit3());
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: readBooksCountController,
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
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
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
                              objDate =
                                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
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

                  // 목표 설정/수정 버튼
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // 서버와 통신
                          // 서버에서 사용자에 대한 목표 선택할 도서 분야, 목표 도서 권수, 목표기간을 업데이트한다.
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                        ),
                        child: const Text(
                          "목표 설정/수정하기",
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
}
