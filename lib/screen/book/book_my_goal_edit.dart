// 목표 설정/수정하는 페이지
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_fluid_nav_bar.dart';

class BookMyGoalEdit extends StatefulWidget {
  const BookMyGoalEdit({super.key});

  @override
  State<BookMyGoalEdit> createState() => _BookMyGoalEditState();
}

class _BookMyGoalEditState extends State<BookMyGoalEdit> {
  // 목표 선택할 도서 분야에 대한 변수
  List<String> category = [
    "국내도서>소설",
    "국내도서>시/에세이",
    "국내도서>예술/대중문화",
    "국내도서>사회과학",
    "국내도서>역사와 문화",
    "국내도서>잡지",
    "국내도서>만화",
    "국내도서>유아",
    "국내도서>아동",
    "국내도서>가정과 생활",
    "국내도서>청소년",
    "국내도서>초등학습서",
    "국내도서>고등학습서",
    "국내도서>국어/외국어/사전",
    "국내도서>자연과 과학",
    "국내도서>경제경영",
    "국내도서>자기계발",
    "국내도서>인문",
    "국내도서>종교/역학",
    "국내도서>컴퓨터/인터넷",
    "국내도서>자격서/수험서",
    "국내도서>취미/레저",
    "국내도서>전공도서/대학교재",
    "국내도서>건강/뷰티",
    "국내도서/여행",
    "국내도서>중등학습서",
  ];
  String selectedCategory = "국내도서>소설";

  // 목표 도서 권수에 대한 변수
  final readBooksCountController = TextEditingController();

  @override
  void initState() {
    print("Book My Goal Edit initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book My Goal Edit dispose 시작");
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
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      items: category
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
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
                  const SizedBox(height: 25),

                  // 목표 설정 기간 안내
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "목표 기간은\n2023-04-21 ~ 2023-05-21 입니다",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(height: 25),

                  // 목표 설정/수정 버튼
                  Padding(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3.3,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "목표 설정/수정하기",
                        style: TextStyle(fontSize: 15),
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
