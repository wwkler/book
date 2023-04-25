import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _formKey = GlobalKey<FormState>();

  // id
  String id = "사용자 원래 ID";
  bool isIdState = false;

  // password
  String password = "사용자 원래 Password";
  bool isPasswordState = false;

  // verifyPassword
  String verifyPassword = "사용자 원래 Password";
  bool isVerifyPasswordState = false;

  // name
  String name = "사용자 원래 이름";
  bool isNameState = false;

  // age
  String age = "사용자 원래 나이";
  bool isAgeState = false;

  // category
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

  @override
  void initState() {
    super.initState();
    print("MyPage initState 시작");
  }

  @override
  void dispose() {
    print("MyPage state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                          Get.off(() => BookFluidNavBar());
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 20),

                    // 마이 페이지 Text
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
                                "마이페이지",
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

                    // 변경할 ID
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: id,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          setState(() {
                            id = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            id = val!;
                          });
                        },
                        validator: (value) {
                          // 아이디 정규식: ^[0-9a-z]+$; (숫자 또는 영문 또는 숫자와 영문 조합 아이디 생성 가능)
                          // 아이디 길이는 8자리 이상 12자리 이하
                          if (!RegExp(r"^[0-9a-z]+$").hasMatch(value!)) {
                            isIdState = false;
                            return "숫자, 영문만 입력해주세요";
                          } else if (value.length < 8 || value.length > 13) {
                            isIdState = false;
                            return "8자리 이상 12자리 이하를 입력해주세요";
                          } else {
                            isIdState = true;
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
                          labelText: "ID",
                          hintText: 'ex) abcdefg1',
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 Password
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: password,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            password = val!;
                          });
                        },
                        // 비밀번호 정규식: ^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$ (숫자, 특수문자 각 1회 이상, 영문 2개 이상 사용하여 8자리 이상 입력)
                        validator: (String? value) {
                          if (!RegExp(
                                  r"^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$")
                              .hasMatch(value!)) {
                            isPasswordState = false;
                            return "숫자, 특수문자 각 1회 이상, 영문 2개 이상 사용하여\n8자리 입력해주세요";
                          } else {
                            isPasswordState = true;
                            return null;
                          }
                        },

                        obscuringCharacter: '*',
                        obscureText: true,
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
                          labelText: "Password",
                          hintText: 'ex) ********',
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // Verify Password
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: verifyPassword,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          verifyPassword = val;
                        },
                        onSaved: (val) {
                          setState(() {
                            verifyPassword = val!;
                          });
                        },
                        validator: (String? value) {
                          if (isPasswordState == false) {
                            isVerifyPasswordState = false;
                            return "적합한 Password를 먼저 입력해주세요";
                          }

                          if (isPasswordState == true && value!.isEmpty) {
                            isVerifyPasswordState = false;
                            return "사전에 입력한 Password를 다시 입력해주세요";
                          }

                          if (isPasswordState == true && value != password) {
                            isVerifyPasswordState = false;
                            return "사전에 입력한 Password와 맞지 않습니다.";
                          }

                          if (isPasswordState == true && value == password) {
                            isVerifyPasswordState = true;
                            return null;
                          }
                        },
                        obscuringCharacter: '*',
                        obscureText: true,
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
                          labelText: "Verify Password",
                          hintText: 'ex) ********',
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 이름
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: name,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            name = val!;
                          });
                        },
                        // 이름 정규표현식 : ^[가-힣]{2,4}$ (한글 이름 최소 2자 최대 4자)
                        validator: (String? value) {
                          if (!RegExp(r"^[가-힣]{2,4}$").hasMatch(value!)) {
                            isNameState = false;
                            return "한글 이름 2-4자를 입력해주세요";
                          }
                          isNameState = true;
                          return null;
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
                          labelText: "이름",
                          hintText: "ex) 홍길동",
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 나이
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: age,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          setState(() {
                            age = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            age = val!;
                          });
                        },
                        // 나이 정규표현식 ^[0-9]+$
                        // 나이는 최소 1자 최대 2자
                        validator: (String? value) {
                          if (!RegExp(r"^[0-9]+$").hasMatch(value!)) {
                            isAgeState = false;
                            return "숫자를 입력해주세요";
                          } else if (value.length >= 3) {
                            isAgeState = false;
                            return "숫자로 최소 1자, 최대 2자를 입력해주세요";
                          } else {
                            isAgeState = true;
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
                          labelText: "나이",
                          hintText: "ex) 25",
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 선호하는 도서 장르
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
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 50),

                    // 개인 정보 변경하기
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            // 검증

                            // 서버와 통신

                            // 사용자의 개인 정보를 변경한다.
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
                                "개인 정보 변경하기",
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
    );
  }
}
