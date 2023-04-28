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
                          width: 350,
                          height: 600,
                          child: Column(
                            children: [
                              // 번호, 사용자 이름, 아이디, 관리
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: const [
                                    // 번호
                                    Text(
                                      "번호",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // 중간 공백
                                    SizedBox(width: 60),

                                    // 사용자 이름
                                    Text(
                                      "제목",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // 중간 공백
                                    SizedBox(width: 120),

                                    // 아이디
                                    Text(
                                      "날짜",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // 관리


                                  ],
                                ),
                              ),

                              // 중간 공백
                              const SizedBox(height: 10),

                              // 일지 리스트
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  itemCount: 20,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      color: Colors.yellow[50],
                                      width: 350,
                                      height: 50,
                                      child: Row(
                                        children: [
                                          // 번호
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Center(
                                              child: Text("11"),
                                            ),
                                          ),
                                          // 제목
                                          Container(
                                            width: 200,
                                            height: 50,
                                            child: Center(
                                              child: Text("어린 왕자입니다"),
                                            ),
                                          ),
                                          // 날짜
                                          Container(
                                            width: 100,
                                            height: 50,
                                            child: Center(
                                              child: Text("2023-04-21"),
                                            ),
                                          ),
                                        ],
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
