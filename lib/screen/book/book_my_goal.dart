// 도서 나만의 목표 페이지
import 'package:book_project/screen/book/book_my_goal_edit1.dart';
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

  @override
  Widget build(BuildContext context) {
    print("Book_my_goal build 시작");

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
              const SizedBox(height: 25),

              // 목표 설정/수정하기 버튼
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => BookMyGoalEdit1());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 20.0,
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

              // 목표 1, 목표 2, 목표 3에 대한 목표와 설정 기간을 보여준다.
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // 목표 1
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 228, 201, 232),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const SizedBox(
                          width: 300,
                          height: 40,
                          child: Center(
                            child: Text(
                              "목표 1 : 2023-04-21 ~ 2023-05-21",
                              // "목표를 설정해주세요!!",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 목표 2
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 228, 201, 232),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const SizedBox(
                          width: 300,
                          height: 40,
                          child: Center(
                            child: Text(
                              "목표 2 : 2023-05-21 ~ 2023-06-21",
                              // "목표를 설정해주세요!!",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 목표 3
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 228, 201, 232),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: const SizedBox(
                          width: 300,
                          height: 40,
                          child: Center(
                            child: Text(
                              "목표 3 : 2023-07-21 ~ 2023-08-21",
                              // "목표를 설정해주세요!!",
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
                              width: MediaQuery.of(context).size.width * 0.9,
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/imgs/icon.png"),
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

              // 읽고 싶은 책
              TapToExpand(
                color: Colors.purple,
                content: Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Card(
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
                                // 읽고 싶은 책 삭제하기
                                ElevatedButton(
                                  onPressed: () {
                                    // 클라이언트에서 해당 책을 삭제하고 서버와 통신
                                    // 서버는 읽고 싶은 책에서 해당 책을 삭제한다.
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: Colors.purple,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text("삭제하기"),
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: Colors.purple,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                  ),
                                  child: Text("책 읽기"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  "읽고 싶은 책",
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

              // 읽고 있는 책
              TapToExpand(
                color: Colors.purple,
                content: Center(
                  child: SizedBox(
                    width: 350,
                    height: 350,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Card(
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
                                              controller: editPageController,
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
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
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
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  "읽고 있는 책",
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

              // 읽은 책
              TapToExpand(
                color: Colors.purple,
                content: Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Card(
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
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                    ),
                  ),
                ),
                title: const Text(
                  "읽은 책",
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
}
