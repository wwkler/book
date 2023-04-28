// 사용자 관리하는 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class UserManagement extends StatefulWidget {
  UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => UserManagementState();
}

class UserManagementState extends State<UserManagement> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

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

                  // 사용자 관리 Text
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
                              "사용자 관리",
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
                              // 번호, 사용자 이름, 아이디, 관리
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

                                    // 관리
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "관리",
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
                                  itemCount: 20,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.yellow[50],
                                      width: 200,
                                      height: 100,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            // 번호
                                            Container(
                                              width: 50,
                                              height: 100,
                                              child: Center(
                                                child: Text("11"),
                                              ),
                                            ),
                                            // 사용자명
                                            Container(
                                              width: 100,
                                              height: 100,
                                              child: Center(
                                                child: Text("김영우"),
                                              ),
                                            ),
                                            // 아이디
                                            Container(
                                              width: 100,
                                              height: 100,
                                              child: Center(
                                                child: Text("winner23456"),
                                              ),
                                            ),

                                            // 중간 공백
                                            const SizedBox(width: 20),

                                            // 관리
                                            SizedBox(
                                              width: 200,
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  // 정지 버튼
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // 서버와 통신
                                                      // 사용자 계정을 정지한다.
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      backgroundColor:
                                                          Colors.purple,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                        vertical: 15,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "정지",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),

                                                  // 중간 공백
                                                  const SizedBox(width: 10),

                                                  // 탈퇴 버튼
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // 서버와 통신
                                                      // 사용자 계정을 탈퇴한다.
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      backgroundColor:
                                                          Colors.purple,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                        vertical: 15,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "탈퇴",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
}
