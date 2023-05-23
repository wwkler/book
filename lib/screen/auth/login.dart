// 앱의 로그인 페이지 화면
import 'dart:io';

import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/find_id.dart';
import 'package:book_project/screen/auth/find_password.dart';
import 'package:book_project/screen/auth/sign_up.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_search_recommend.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            // 배경 이미지
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/background_book1.jpg"),
                fit: BoxFit.fill,
                opacity: 0.5,
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
                    SizedBox(height: 40.h),

                    // 자물쇠 이미지
                    Lottie.network(
                      'https://assets6.lottiefiles.com/private_files/lf30_ulp9xiqw.json',
                      //'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                      animate: true,
                      height: 120.h,
                      width: 600.w,
                    ),

                    // BookMakase Login Screen Text
                    Text(
                      "BookMakase Login Screen",
                      style: GoogleFonts.indieFlower(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
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
                          fontSize: 15.sp,
                        ),
                      ),
                    ),

                    // 중간 공백
                    SizedBox(
                      height: 30.h,
                    ),

                    // ID와 Password
                    Container(
                      width: MediaQuery.of(context).size.width.w / 1.1,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          // ID
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.h,
                              top: 20.h,
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
                                }
                                //
                                else if (value.length < 6 ||
                                    value.length > 13) {
                                  isIdState = false;
                                  return "6자리 이상 12자리 이하를 입력해주세요";
                                }
                                //
                                else {
                                  isIdState = true;
                                  return null;
                                }
                                // isIdState = true;
                                // return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "ID",
                                hintText: 'ex) abcdefg',
                                labelStyle:
                                    const TextStyle(color: Colors.purple),
                              ),
                            ),
                          ),

                          // Password
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
                              // 비밀번호 8자리 ~ 14자리만 받도록 합니다.
                              validator: (String? value) {
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
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Password",
                                hintText: 'ex) ********',
                                labelStyle:
                                    const TextStyle(color: Colors.purple),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 중간 공백
                    SizedBox(
                      height: 15.h,
                    ),

                    // 로그인 버튼
                    ElevatedButton(
                      onPressed: () async {
                        // 검증 작업
                        if (isIdState == true && isPasswordState == true) {
                          // 서버 통신 시도
                          try {
                            final response = await dio.post(
                              'http://${IpAddress.hyunukIP}/login',
                              data: {
                                'account': id,
                                'password': password,
                              },
                              options: Options(
                                validateStatus: (_) => true,
                                contentType: Headers.jsonContentType,
                                responseType: ResponseType.json,
                              ),
                            );

                            // 서버와 통신 성공
                            // 아이디와 비밀번호를 체크한다
                            if (response.statusCode == 200) {
                              print("서버와 통신 성공");
                              print("서버에서 제공해주는 사용자 정보 데이터 : ${response.data}");

                              // 서버에서 회원 정보를 가져와서 model에 user_info.dart에 저장한다.
                              if (response.data["roles"][0]["name"] ==
                                  "ROLE_ADMIN") {
                                UserInfo.identity = UserManagerCheck.manager;
                              }
                              //
                              else {
                                UserInfo.identity = UserManagerCheck.user;
                              }
                              UserInfo.userValue = response.data["id"];
                              UserInfo.id = response.data["account"];
                              UserInfo.name = response.data["name"];
                              UserInfo.age = response.data["age"];
                              UserInfo.selectedCode = response.data["prefer"];
                              UserInfo.token = response.data["token"];
                              UserInfo.email = response.data["email"];

                              UserInfo.identity == UserManagerCheck.user
                                  ?
                                  // 로그인에 성공하였다는 snackBar를 띄운다
                                  Get.snackbar(
                                      "사용자 로그인 성공",
                                      "사용자 로그인에 성공하였습니다",
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.TOP,
                                    )
                                  : Get.snackbar(
                                      "관리자 로그인 성공",
                                      "관리자 로그인에 성공하였습니다",
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.TOP,
                                    );

                              // 회원 가입 페이지에서 벗어나 메인 페이지로 라우팅한다.
                              Get.off(() => BookFluidNavBar(
                                    route: BookSearchRecommend(),
                                    routeIndex: 0,
                                  ));
                            }
                            // 서버와 통신 실패
                            else {
                              print("서버와 통신 실패");
                              print("서버 통신 에러 코드 : ${response.statusCode}");
                              print("메시지 : ${response.data}");

                              // 잘못된 계정 정보 입니다
                              if (response.data == "잘못된 계정 정보입니다.") {
                                Get.snackbar(
                                  "잘못된 계정 정보",
                                  "아이디, 비밀번호를 다시 입력해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }

                              // 잘못된 비밀번호 입니다
                              else if (response.data == "잘못된 비밀번호입니다.") {
                                Get.snackbar(
                                  "잘못된 비밀번호",
                                  "비밀번호를 다시 입력해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }

                              // 로그인 중에 오류가 발생했습니다
                              else if (response.data == "로그인 중에 오류가 발생했습니다.") {
                                Get.snackbar(
                                  "로그인 중에 오류 발생",
                                  "서버측 에러로 관리자에게 문의해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }

                              // ban 됐을 떄 처리
                              else {
                                Get.snackbar(
                                  "사용자 계정 정지 알림",
                                  "${(response.data as String).substring(0, 10)}까지 계정이 정지되었습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            }
                          }
                          // DioError[unknown]: null이 메시지로 나타났을 떄
                          // 즉 서버가 열리지 않았다는 뜻이다
                          catch (e) {
                            print("메시지 : $e");
                            // 서버가 열리지 않았다는 snackBar를 띄운다
                            Get.snackbar(
                              "서버 열리지 않음",
                              "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                              duration: const Duration(seconds: 5),
                              snackPosition: SnackPosition.TOP,
                            );

                            // 앱을 종료하는 다이어로그를 띄운다
                            Get.dialog(
                              AlertDialog(
                                title: const Text("서버가 열리지 않음"),
                                content: SizedBox(
                                  width: 100.w,
                                  height: 150.h,
                                  child: Column(
                                    children: [
                                      // 아이디를 보여주는 문구
                                      const Text("서버가 열리지 않아서 앱을 종료합니다"),

                                      // 중간 공백
                                      SizedBox(height: 50.h),

                                      // 앱 종료하기 버튼
                                      TextButton(
                                        child: const Text("앱 종료하기"),
                                        onPressed: () {
                                          // 앱 종료하기 보여주는 다이어로그를 삭제한다.
                                          Get.back();

                                          // 앱 종료
                                          exit(0);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                        // 사용자가 입력값을 적합하지 않게 했을 떄
                        else {
                          Get.snackbar(
                            "이상 메시지",
                            "아이디/비밀번호 정규표현식이 적합하지 않음",
                            duration: const Duration(seconds: 5),
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width.w / 3.3,
                          vertical: 20.h,
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),

                    // 중간 공백
                    SizedBox(
                      height: 15.h,
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
      ),
    );
  }
}
