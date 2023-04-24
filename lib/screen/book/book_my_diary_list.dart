// 도서 일지 리스트를 보여주는 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_my_diary_show_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMyDiaryList extends StatefulWidget {
  const BookMyDiaryList({super.key});

  @override
  State<BookMyDiaryList> createState() => _BookMyDiaryListState();
}

class _BookMyDiaryListState extends State<BookMyDiaryList> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    print("Book My Diary List initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book My Diary List state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Book My Diary List build 실행");

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

                  // 일지 목록 보기 Text
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
                              "일지 목록 보기",
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

                  // 제목으로 도서 검색
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimSearchBar(
                      width: 300,
                      textController: searchTextController,
                      helpText: "도서 제목 검색",
                      suffixIcon: const Icon(Icons.arrow_back),
                      onSuffixTap: () {
                        // 도서 제목 비어있는 상태로 검색
                        setState(() {
                          searchTextController.clear();
                        });
                      },
                      onSubmitted: (String value) {
                        // 도서 제목 검색
                        setState(() {});
                      },
                    ),
                  ),

                  // 작성한 일지 목록
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
                              // 번호, 제목, 날짜
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

                                    // 제목
                                    Text(
                                      "제목",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // 중간 공백
                                    SizedBox(width: 120),

                                    // 날짜
                                    Text(
                                      "날짜",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
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
                                  itemCount: 20,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      // 도서 일지 상세 정보 페이지로 라우팅
                                      Get.off(() => BookMyDiaryShowPreview());
                                    },
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
