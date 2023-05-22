import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _formKey = GlobalKey<FormState>();

  // 이메일
  String email = UserInfo.email.toString();
  bool isEmailState = true;

  // password
  String password = "";
  bool isPasswordState = false;

  // verifyPassword
  // String verifyPassword = "";
  // bool isVerifyPasswordState = false;

  // // name
  // String name = "";
  // bool isNameState = false;

  // // age
  // String age = "";
  // bool isAgeState = false;

  // category
  Map<int, String> category = {
    101: "국내도서>소설",
    102: "국내도서>시/에세이",
    103: "국내도서>예술/대중문화",
    104: "국내도서>사회과학",
    105: "국내도서>역사와 문화",
    107: "국내도서>잡지",
    108: "국내도서>만화",
    109: "국내도서>유아",
    110: "국내도서>아동",
    111: "국내도서>가정과 생활",
    112: "국내도서>청소년",
    113: "국내도서>초등학습서",
    114: "국내도서>고등학습서",
    115: "국내도서>국어/외국어/사전",
    116: "국내도서>자연과 과학",
    117: "국내도서>경제경영",
    118: "국내도서>자기계발",
    119: "국내도서>인문",
    120: "국내도서>종교/역학",
    122: "국내도서>컴퓨터/인터넷",
    123: "국내도서>자격서/수험서",
    124: "국내도서>취미/레저",
    125: "국내도서>전공도서/대학교재",
    126: "국내도서>건강/뷰티",
    128: "국내도서/여행",
    129: "국내도서>중등학습서",
  };
  String? selectedCategory;
  int selectedCode = UserInfo.selectedCode!;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    print("MyPage initState 시작");
    selectedCategory = category[selectedCode];
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

                    // 변경할 이메일
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        initialValue: UserInfo.email,
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            email = val!;
                          });
                        },
                        validator: (value) {
                          // 이메일 정규식 체크
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            isEmailState = false;
                            return "올바른 이메일 형식이 아닙니다.";
                          }
                          //
                          else {
                            isEmailState = true;
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
                          labelText: "Email",
                          hintText: 'ex) winner23456@naver.com',
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
                          // if (!RegExp(
                          //         r"^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$")
                          //     .hasMatch(value!)) {
                          //   isPasswordState = false;
                          //   return "숫자, 특수문자 각 1회 이상, 영문 2개 이상 사용하여\n8자리 입력해주세요";
                          // } else {
                          //   isPasswordState = true;
                          //   return null;
                          // }

                          // 비밀번호 8자리 ~ 14자리만 받도록 합니다.
                          if (!(value!.length > 7 && value.length < 15)) {
                            isPasswordState = false;
                            return "비밀번호는 8 ~ 14자 여야 합니다.";
                          }
                          //
                          else {
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

                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "비밀번호를 변경하고 싶으면 변경한 비밀번호를 적고\n 그렇지 않으면 원래 비밀번호를 입력해주세요 ",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),

                    // Verify Password
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 40,
                    //     right: 40,
                    //     bottom: 20,
                    //     top: 20,
                    //   ),
                    //   child: TextFormField(
                    //     initialValue: verifyPassword,
                    //     autovalidateMode: AutovalidateMode.always,
                    //     onChanged: (val) {
                    //       verifyPassword = val;
                    //     },
                    //     onSaved: (val) {
                    //       setState(() {
                    //         verifyPassword = val!;
                    //       });
                    //     },
                    //     validator: (String? value) {
                    //       if (isPasswordState == false) {
                    //         isVerifyPasswordState = false;
                    //         return "적합한 Password를 먼저 입력해주세요";
                    //       }

                    //       if (isPasswordState == true && value!.isEmpty) {
                    //         isVerifyPasswordState = false;
                    //         return "사전에 입력한 Password를 다시 입력해주세요";
                    //       }

                    //       if (isPasswordState == true && value != password) {
                    //         isVerifyPasswordState = false;
                    //         return "사전에 입력한 Password와 맞지 않습니다.";
                    //       }

                    //       if (isPasswordState == true && value == password) {
                    //         isVerifyPasswordState = true;
                    //         return null;
                    //       }
                    //     },
                    //     obscuringCharacter: '*',
                    //     obscureText: true,
                    //     decoration: const InputDecoration(
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.person,
                    //         color: Colors.purple,
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       labelText: "Verify Password",
                    //       hintText: 'ex) ********',
                    //       labelStyle: TextStyle(color: Colors.purple),
                    //     ),
                    //   ),
                    // ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 이름
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 40,
                    //     right: 40,
                    //     bottom: 20,
                    //     top: 20,
                    //   ),
                    //   child: TextFormField(
                    //     initialValue: UserInfo.name,
                    //     autovalidateMode: AutovalidateMode.always,
                    //     onChanged: (val) {
                    //       setState(() {
                    //         name = val;
                    //       });
                    //     },
                    //     onSaved: (val) {
                    //       setState(() {
                    //         name = val!;
                    //       });
                    //     },
                    //     // 이름 정규표현식 : ^[가-힣]{2,4}$ (한글 이름 최소 2자 최대 4자)
                    //     validator: (String? value) {
                    //       if (!RegExp(r"^[가-힣]{2,4}$").hasMatch(value!)) {
                    //         isNameState = false;
                    //         return "한글 이름 2-4자를 입력해주세요";
                    //       }
                    //       isNameState = true;
                    //       return null;
                    //     },
                    //     decoration: const InputDecoration(
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.person,
                    //         color: Colors.purple,
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       labelText: "이름",
                    //       hintText: "ex) 홍길동",
                    //       labelStyle: TextStyle(color: Colors.purple),
                    //     ),
                    //   ),
                    // ),

                    // 중간 공백
                    const SizedBox(height: 10),

                    // 변경할 나이
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 40,
                    //     right: 40,
                    //     bottom: 20,
                    //     top: 20,
                    //   ),
                    //   child: TextFormField(
                    //     initialValue: UserInfo.age.toString(),
                    //     autovalidateMode: AutovalidateMode.always,
                    //     onChanged: (val) {
                    //       setState(() {
                    //         age = val;
                    //       });
                    //     },
                    //     onSaved: (val) {
                    //       setState(() {
                    //         age = val!;
                    //       });
                    //     },
                    //     // 나이 정규표현식 ^[0-9]+$
                    //     // 나이는 최소 1자 최대 2자
                    //     validator: (String? value) {
                    //       if (!RegExp(r"^[0-9]+$").hasMatch(value!)) {
                    //         isAgeState = false;
                    //         return "숫자를 입력해주세요";
                    //       } else if (value.length >= 3) {
                    //         isAgeState = false;
                    //         return "숫자로 최소 1자, 최대 2자를 입력해주세요";
                    //       } else {
                    //         isAgeState = true;
                    //         return null;
                    //       }
                    //     },
                    //     decoration: const InputDecoration(
                    //       focusedBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       enabledBorder: UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       prefixIcon: Icon(
                    //         Icons.person,
                    //         color: Colors.purple,
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       labelText: "나이",
                    //       hintText: "ex) 25",
                    //       labelStyle: TextStyle(color: Colors.purple),
                    //     ),
                    //   ),
                    // ),

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
                        value: category[UserInfo.selectedCode],
                        onChanged: (String? value) {
                          setState(() {
                            selectedCategory = value!;
                            selectedCode = category.keys
                                .toList()
                                .where(
                                  (int key) => category[key] == value,
                                )
                                .toList()[0];
                            print(selectedCode);
                          });
                        },
                        items: category.values
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
                          onPressed: () async {
                            if (isEmailState == true &&
                                isPasswordState == true) {
                              try {
                                // 서버와 통신
                                // 회원 정보를 데이터베이스에 등록한다.
                                final response = await dio.put(
                                  'http://${IpAddress.hyunukIP}/MyPage/info_change',
                                  // 'http://${IpAddress.youngZoonIP}/MyPage/info_change',
                                  data: {
                                    'id': UserInfo.userValue,
                                    'email': email,
                                    'password': password,
                                    'prefer': selectedCode,
                                  },
                                  options: Options(
                                    headers: {
                                      "Authorization":
                                          "Bearer ${UserInfo.token}"
                                    },
                                    validateStatus: (_) => true,
                                    contentType: Headers.jsonContentType,
                                    responseType: ResponseType.json,
                                  ),
                                );

                                // 서버와 통신 성공
                                if (response.statusCode == 200) {
                                  print("서버와 통신 성공");
                                  print("서버에서 제공해주는 데이터 : ${response.data}");

                                  // 정보를 변경해서 로그인 페이지로 안내하는 다이어로그
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text("로그인 페이지 이동 안내"),
                                      content: SizedBox(
                                        width: 100,
                                        height: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "내 정보를 변경해서 로그인 페이지로 안내합니다",
                                            ),

                                            // 중간 공백
                                            const SizedBox(height: 20),

                                            // 다이어로그에서 나가는 버튼
                                            Center(
                                              child: TextButton(
                                                child: const Text("로그인 페이지 이동"),
                                                onPressed: () {
                                                  // 다이어로그를 삭제한다.
                                                  Get.back();

                                                  // 라우팅
                                                  Get.off(() =>
                                                      const LoginScreen());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    barrierDismissible: true,
                                  );
                                }
                                // 서버와 통신 실패
                                else {
                                  print("서버와 통신 실패");
                                  print("서버 통신 에러 코드 : ${response.statusCode}");

                                  Get.snackbar(
                                    "내 정보 변경 실패",
                                    "내 정보가 변경되지 않았습니다",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              }
                              // DioError[unknown]: null이 메시지로 나타났을 떄
                              // 즉 서버가 열리지 않았다는 뜻이다
                              catch (e) {
                                // 서버가 열리지 않았다는 snackBar를 띄운다
                                Get.snackbar(
                                  "서버 열리지 않음",
                                  "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            }
                            // 사용자가 입력한 값이 적합하지 않음
                            else {
                              Get.snackbar(
                                "이상 메시지",
                                "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.TOP,
                              );
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
