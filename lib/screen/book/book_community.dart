// 도서 커뮤니티 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/controller/user_info.dart';
import 'package:book_project/screen/auth/user_manager_check.dart';
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
    print("Book Community build 실행");

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
                            height: 300,
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
                                        "김영우님이 리뷰하였습니다.\n\n아이디 : ladkfsf243",
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
                                              // 영리목적/홍보성
                                              bool forProfit = false;
                                              // 욕설/인신공격
                                              bool abuse = false;
                                              // 불법정보
                                              bool illegalInfo = false;
                                              // 개인정보노출
                                              bool infoExposure = false;
                                              // 음란성, 선전성
                                              bool obscenity = false;
                                              // 같은 내용 도배
                                              bool papering = false;

                                              // 신고 내용을 적는 textControleller
                                              final reportController =
                                                  TextEditingController();

                                              // 신고하기 다이어로그를 띄운다.
                                              Get.dialog(
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      title: const Text('신고하기'),
                                                      content: SizedBox(
                                                        width: 100,
                                                        height: 200,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              // Text
                                                              const Text(
                                                                  "위 리뷰글을 신고하는 사유를\n체크하시오"),

                                                              // 중간 공백
                                                              const SizedBox(
                                                                height: 10,
                                                              ),

                                                              // 영리목적/홍보성
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        forProfit,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        forProfit =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "영리목적/홍보성",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 욕설/인신공격
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        abuse,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        abuse =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "욕설/인신공격",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 불법정보
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        illegalInfo,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        illegalInfo =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "불법정보",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 개인정보 노출
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        infoExposure,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        infoExposure =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "개인정보노출",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 음란성/선전성
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        obscenity,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        obscenity =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "음란성/선전성",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 같은 내용 도배
                                                              Row(
                                                                children: [
                                                                  // 체크박스
                                                                  Checkbox(
                                                                    value:
                                                                        papering,
                                                                    onChanged:
                                                                        (bool?
                                                                            newValue) {
                                                                      setState(
                                                                          () {
                                                                        papering =
                                                                            newValue!;
                                                                      });
                                                                    },
                                                                  ),

                                                                  const Text(
                                                                    "같은 내용 도배",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              // 내용 적기
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      reportController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  minLines: 2,
                                                                  maxLines: 10,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Colors.purple),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Colors.purple),
                                                                    ),
                                                                    labelText:
                                                                        '신고내용',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: const Text(
                                                              "신고 제출"),
                                                          onPressed: () {
                                                            // 검증

                                                            // 서버와 통신
                                                            // 서버에 신고받은 사용자 목록에 업데이트한다.

                                                            Get.back();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
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

                                      // 리뷰 내용
                                      const Text(
                                        "리뷰 내용입니다.\n리뷰 내용입니다.\n리뷰 내용입니다.\n리뷰 내용입니다.\n리뷰 내용입니다.\n",
                                      ),

                                      // 리뷰글 삭제하기 (관리자 권한)
                                      UserInfo.identity ==
                                              UserManagerCheck.manager
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(64.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  // 서버와 통신
                                                  // 리뷰 글을 삭제한다.
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  backgroundColor:
                                                      Colors.purple,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40,
                                                    vertical: 15,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: const [
                                                    Icon(Icons.delete),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "리뷰 삭제하기",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const Visibility(
                                              visible: false,
                                              child: Text("버튼은 보이지 않습니다."),
                                            ),
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
