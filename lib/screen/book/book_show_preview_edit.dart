// 관리자에 한해서 도서 상세 정보를 수정할 수 있는 페이지
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class BookShowPreviewEdit extends StatefulWidget {
  BookShowPreviewEdit({super.key});

  @override
  State<BookShowPreviewEdit> createState() => _BookShowPreviewEditState();
}

class _BookShowPreviewEditState extends State<BookShowPreviewEdit> {
  final _formKey = GlobalKey<FormState>();

  // 변경할 도서 제목
  String editBookTtitle = "원래 도서 제목";
  bool isEditBookTitle = true;

  // 변경할 도서 작가
  String editBookAuthor = "원래 도서 작가 이름";
  bool isEditBookAuthor = true;

  // 변경할 출판사
  String editBookPublisher = "원래 도서 출판사";
  bool isEditBookPublisher = true;

  // 변경할 category
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
  String selectedCategory = "국내도서>소설"; // 원래 도서 분야여야 한다.

  // 변경할 도서 평점
  String editBookGrade = "원래 도서 평점";
  bool isEditBookGrade = true;

  // 변경할 도서 가격
  String editBookPrice = "원래 도서 가격";
  bool isEditBookPrice = true;

  // 변경할 도서 구입 URL
  String editBookPurchaseURL = "원래 도서 구입 URL";
  bool isEditBookPurchaseURL = true;

  // 변경할 도서 목차
  String editBookContent = "원래 도서 목차";
  bool isEditBookContent = true;

  @override
  void initState() {
    super.initState();
    print("Book Show Preview Edit initState 시작");
  }

  @override
  void dispose() {
    print("Book Show Preview Edit state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 뒤로 가기가 불가능하다는 다이어로그를 띄운다.
        Get.snackbar(
          "뒤로 가기 불가능",
          "사용자 임의로 뒤로 가기를 할 수 없습니다.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
        );

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // 배경 이미지
            decoration: BoxDecoration(
              image: DecorationImage(
                image: UserInfo.identity == UserManagerCheck.user
                    ? const AssetImage("assets/imgs/background_book1.jpg")
                    : const AssetImage("assets/imgs/background_book2.jpg"),
                fit: BoxFit.fill,
                opacity: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 이전 페이지 아이콘
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            // Get.off(() => BookFluidNavBar());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 20),

                      // 도서 상세 정보 변경 Text
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
                                  "도서 상세 정보 변경",
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
                      const SizedBox(height: 30),

                      // 변경할 도서 제목
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookTtitle,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookTtitle = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookTtitle = val!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              isEditBookTitle = false;
                              return "글자를 입력해주세요";
                            } else {
                              isEditBookTitle = true;
                              return null;
                            }
                          },
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
                            labelText: "도서 제목",
                            hintText: 'ex) 홍길동을 찾아서',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 작가
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookAuthor,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookAuthor = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookAuthor = val!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              isEditBookAuthor = false;
                              return "글자를 입력해주세요";
                            } else {
                              isEditBookAuthor = true;
                              return null;
                            }
                          },
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
                            labelText: "도서 작가",
                            hintText: 'ex) 홍길동',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 출판사
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookAuthor,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookPublisher = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookPublisher = val!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              isEditBookAuthor = false;
                              return "글자를 입력해주세요";
                            } else {
                              isEditBookAuthor = true;
                              return null;
                            }
                          },
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
                            labelText: "도서 출판사",
                            hintText: 'ex) 이한출판사',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 분야
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
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
                            hintText: "ex) 인문",
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                          value: selectedCategory,
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          items: category
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 평점
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookGrade,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookGrade = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookGrade = val!;
                            });
                          },
                          validator: (value) {
                            // 검증
                            // 0.0, 6.5, 10.0 이렇게 되어야 한다.
                          },
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
                            labelText: "도서 평점",
                            hintText: 'ex) 6.5',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 가격
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookPrice,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookPrice = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookPrice = val!;
                            });
                          },
                          validator: (value) {
                            // 검증
                            // 숫자만 있어야 한다.
                          },
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
                            labelText: "도서 가격",
                            hintText: 'ex) 20000',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 구입 URL
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookPurchaseURL,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookPurchaseURL = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookPurchaseURL = val!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              isEditBookPurchaseURL = false;
                              return "구입 URL를 작성하세요";
                            } else {
                              isEditBookPurchaseURL = true;
                              return null;
                            }
                          },
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
                            labelText: "도서 구입 URL",
                            hintText: 'ex) https://book.com',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 10),

                      // 변경할 도서 목차
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                          bottom: 20,
                          top: 20,
                        ),
                        child: TextFormField(
                          initialValue: editBookContent,
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: (val) {
                            setState(() {
                              editBookContent = val;
                            });
                          },
                          onSaved: (val) {
                            setState(() {
                              editBookContent = val!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              isEditBookContent = false;
                              return "구입 URL를 작성하세요";
                            } else {
                              isEditBookContent = true;
                              return null;
                            }
                          },
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
                            labelText: "도서 목차",
                            hintText: 'ex) 1. 첫 시작 2. 두 번째 줄거리 3. 세 번째 줄거리',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      const SizedBox(height: 50),

                      // 도서 정보 변경하기
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 250,
                          child: ElevatedButton(
                            onPressed: () {
                              // 검증
                              if (isEditBookTitle == true &&
                                  isEditBookAuthor == true &&
                                  isEditBookPublisher == true &&
                                  isEditBookGrade == true &&
                                  isEditBookPrice == true &&
                                  isEditBookPurchaseURL == true &&
                                  isEditBookContent == true) {
                                print("서버와 통신");
                                // 서버와 통신

                                // 사용자의 개인 정보를 변경한다.
                              } else {
                                Get.snackbar(
                                    "이상 메시지", "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP);
                              }
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
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.change_circle_outlined,
                                  size: 20,
                                ),
                                SizedBox(width: 30),
                                Text(
                                  "도서 정보 변경하기",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
