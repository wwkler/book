// 앱의 로고인 페이지 화면
import 'package:book_project/screen/auth/find_id.dart';
import 'package:book_project/screen/auth/find_password.dart';
import 'package:book_project/screen/auth/sign_up.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // id
  String id = "";
  bool isIdState = false;

  // password
  String password = "";
  bool isPasswordState = false;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    super.initState();

    print("Login initState 시작");
  }

  @override
  void dispose() {
    print("Login state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // 배경 이미지
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/imgs/background_book1.jpg"),
              fit: BoxFit.fill,
              opacity: 0.3,
            ),
          ),

          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 중간 공백
                  const SizedBox(height: 40),

                  // 자물쇠 이미지
                  Lottie.network(
                    'https://assets6.lottiefiles.com/private_files/lf30_ulp9xiqw.json',
                    //'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                    animate: true,
                    height: 120,
                    width: 600,
                  ),

                  // BookMakase Login Screen Text
                  Text(
                    "BookMakase Login Screen",
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  // Please login to continue using our app Text
                  Text(
                    "Please login to continue using our app",
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(
                    height: 30,
                  ),

                  // ID와 Password
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // ID
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                            top: 20,
                          ),
                          child: TextFormField(
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
                              // 아이디 길이는 6자리 이상 12자리 이하
                              if (!RegExp(r"^[0-9a-z]+$").hasMatch(value!)) {
                                isIdState = false;
                                return "숫자, 영문만 입력해주세요";
                              } else if (value.length < 6 ||
                                  value.length > 13) {
                                isIdState = false;
                                return "6자리 이상 12자리 이하를 입력해주세요";
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
                              hintText: 'ex) abcdefg',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ),

                        // Password
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
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
                              //   return "숫자, 특수문자 각 1회 이상 포함한 8자리 이상 입력해주세요";
                              // } else {
                              //   isPasswordState = true;
                              //   return null;
                              // }

                              // 비밀번호 8자리 ~ 14자리만 받도록 합니다.
                              if (!(value!.length > 7 && value.length < 15)) {
                                isPasswordState = false;
                                return "비밀번호는 8 ~ 14자 여야 합니다.";
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
                      ],
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(
                    height: 15,
                  ),

                  // 로고인 버튼
                  ElevatedButton(
                    onPressed: () async {
                      Get.off(() => BookFluidNavBar());

                      // if (isIdState == true && isPasswordState == true) {
                      //   // 서버와 통신
                      //   // ID, Password가 존재하는지 확인한다.
                      //   final response = await dio.post(
                      //     'http://49.161.110.41:8080/login',
                      //     data: {
                      //       // 사용자 아이디(string)
                      //       'account': id,

                      //       // 사용자 비밀번호(string)
                      //       'password': password,
                      //     },
                      //     options: Options(
                      //       validateStatus: (_) => true,
                      //       contentType: Headers.jsonContentType,
                      //       responseType: ResponseType.json,
                      //     ),
                      //   );

                      //   // 서버와 통신 성공
                      //   if (response.statusCode == 200) {
                      //     print("서버와 통신 성공");
                      //     print("서버에서 제공해주는 데이터 : ${response.data}");

                      //     // 회원 정보를 가져와서 user_info.dart에 저장한다.
                      //     if (response.data["roles"][0]["name"] == "ADMIN") {
                      //       UserInfo.identity = UserManagerCheck.manager;
                      //     }
                      //     //
                      //     else {
                      //       UserInfo.identity = UserManagerCheck.user;
                      //     }

                      //     UserInfo.userValue = response.data["id"].toString();
                      //     UserInfo.id = response.data["account"];
                      //     UserInfo.name = response.data["name"];
                      //     UserInfo.age = response.data["age"];
                      //     UserInfo.selectedCode = response.data["prefer"];
                      //     UserInfo.email = response.data["email"];

                      //     // 회원 가입 페이지에서 벗어나 메인 페이지로 라우팅한다.
                      //     Get.off(() => BookFluidNavBar());
                      //   }
                      //   // 서버와 통신 실패
                      //   else {
                      //     print("서버와 통신 실패");
                      //     print("서버 통신 에러 코드 : ${response.statusCode}");

                      //     Get.snackbar(
                      //       "서버 통신 실패",
                      //       "서버 통신 에러 코드 : ${response.statusCode}",
                      //       duration: const Duration(seconds: 5),
                      //       snackPosition: SnackPosition.TOP,
                      //     );
                      //   }
                      // } else {
                      //   Get.snackbar(
                      //     "이상 메시지",
                      //     "아이디/비밀번호 정규표현식이 적합하지 않음",
                      //     duration: const Duration(seconds: 5),
                      //     snackPosition: SnackPosition.TOP,
                      //   );
                      // }
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
                      "Login",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(
                    height: 15,
                  ),

                  // Sign Up, 아이디/비밀번호 찾기 Row
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // You haven't any account Text
                          Text(
                            'You haven\'t any account?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          // Sign Up Text
                          TextButton(
                            onPressed: () {
                              Get.off(() => const SignUpScreen());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // 아이디 찾기
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 아이디 찾기 Text
                          Text(
                            'Forgot your ID?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          // Sign Up Text
                          TextButton(
                            onPressed: () {
                              Get.off(() => const FindIdScreen());
                            },
                            child: const Text(
                              'Find ID',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // 비밀번호 변경하기
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 비밀번호 변경하기 Text
                          Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          // Find Password Text
                          TextButton(
                            onPressed: () {
                              Get.off(() => FindPasswordScreen());
                            },
                            child: const Text(
                              'Find Password',
                              style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
