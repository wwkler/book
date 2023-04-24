// 도서 커뮤니티 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/screen/book/book_review_write.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookCommunity extends StatefulWidget {
  const BookCommunity({super.key});

  @override
  State<BookCommunity> createState() => _BookCommunityState();
}

class _BookCommunityState extends State<BookCommunity> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();
  // 검색어를 요청해서 서버로부터 받은 데이터가 존재하는지 안하는지 판별하는 변수
  bool isReviewData = true;

  @override
  void initState() {
    print("Book Community initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book Community state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 중간 공백
              const SizedBox(height: 10),

              // 도서 커뮤니티 Text
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
                          "도서 커뮤니티",
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

              // search bar, 리뷰 작성하기
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // search bar
                    AnimSearchBar(
                      width: 250,
                      textController: searchTextController,
                      helpText: "책 또는 저자를 입력",
                      suffixIcon: const Icon(Icons.arrow_back),
                      onSuffixTap: () {
                        setState(() {
                          searchTextController.clear();
                        });
                      },
                      onSubmitted: (String value) {
                        // 서버와 통신
                        // 검색어를 통한 결과가 있는지 확인한다.
                      },
                    ),

                    // 리뷰 작성하기 버튼
                    ElevatedButton(
                      onPressed: () {
                        // 도서 리뷰 작성 페이지로 라우팅
                        Get.off(() => BookReviewWrite());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 40.0,
                          vertical: 15,
                        ),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text(
                            "리뷰 작성",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 중간 공백
              const SizedBox(height: 10),

              // 리뷰 결과물 -> 없으면 결과가 없다는 text를 화면에 보여주고, 있으면 리뷰들을 보여준다.
              isReviewData == true
                  ? Expanded(
                      flex: 1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 400,
                            child: SingleChildScrollView(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  //모서리를 둥글게 하기 위해 사용
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 4.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      // 이름
                                      const Text(
                                        "김영우님이 리뷰하였습니다.",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      // 중간 공백
                                      const SizedBox(height: 10),

                                      // 리뷰 별점, 좋아요, 신고하기
                                      Row(
                                        children: [
                                          // 리뷰 별점
                                          RatingBarIndicator(
                                            rating: 2.75,
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 30.0,
                                            direction: Axis.horizontal,
                                          ),

                                          // 좋아요 버튼
                                          IconButton(
                                            onPressed: () {
                                              // 클라이언트에서 좋아요 수를 업데이트하고
                                              // 서버에 이를 알려줘서 리뷰 데이터에 대한 좋아요 수를 업데이트 하도록 한다.
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                          ),

                                          // 좋아요 수
                                          const Text(
                                            "5",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          // 신고하기 버튼
                                          IconButton(
                                            onPressed: () {
                                              // 신고하기 다이어로그를 띄운다.

                                              // 서버에 신고받은 사용자 목록에 업데이트한다.
                                            },
                                            icon: const Icon(
                                              Icons.priority_high_outlined,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),

                                          // 신고하기 Text
                                          const Text(
                                            "신고하기",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // 중간 공백
                                      const SizedBox(height: 10),

                                      // 도서 정보
                                      GestureDetector(
                                        onTap: () {
                                          // 도서 상세 정보 페이지로 이동
                                          Get.off(() => BookShowPreview());
                                        },
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              //모서리를 둥글게 하기 위해 사용
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            elevation: 4.0, //그림자 깊이
                                            child: Row(
                                              children: [
                                                // 도서 이미지
                                                Image.asset(
                                                  "assets/imgs/icon.png",
                                                  width: 150,
                                                  height: 150,
                                                ),

                                                // 도서 작가, 출판사, 분류, 평균 평점
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: const [
                                                    Text("작가: 윤양주 저"),
                                                    Text("출판사: 위즈덤스타일"),
                                                    Text("분류: 국내도서 > 여향"),
                                                    Text("평균 평점 : 9.3"),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                      // 중간 공백
                                      const SizedBox(height: 10),

                                      // 리뷰 감상평
                                      const Text(
                                        "감상평입니다.\n감상평입니다.\n감상평입니다.\n감상평입니다.\n감상평입니다.\n",
                                      ),

                                      // 리뷰평
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 중간 공백
                          const SizedBox(height: 40),

                          // 데이터가 존재하지 않는 아이콘
                          Image.asset(
                            "assets/imgs/sad.png",
                            width: 100,
                            height: 100,
                          ),

                          // 중간 공백
                          const SizedBox(height: 40),

                          // 데이터가 존재하지 않습니다 Text
                          const Text(
                            "데이터가 존재하지 않습니다.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

              // 중간 공백
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
