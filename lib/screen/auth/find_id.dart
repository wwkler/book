// 아이디를 찾기 위한 화면
import 'dart:math';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  final _formKey = GlobalKey<FormState>();

  // 이메일
  String email = "";
  bool isEmailState = false;

  // 앱에서 사용자에게 제공하는 인증번호
  // EmailOTP myauth = EmailOTP();

  // 사용자가 입력해야 하는 인증번호
  // String emailVerificationValue = "";
  // bool isEmailVerificationValue = false;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    // twilioFlutter = TwilioFlutter(
    //     accountSid: 'ACe85bf95b8c67f941ffdff01de2fdae7b',
    //     authToken: 'dc5637ccfa2cce5809ee5d46d801e1b0',
    //     twilioNumber: '+16073604847');
    print("Find_id initState 시작");

    super.initState();
  }

  @override
  void dispose() {
    print("Find_id state 종료");
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 이전 페이지 아이콘
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.off(() => const LoginScreen());
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),

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
                      "BookMakase FindID Screen",
                      style: GoogleFonts.indieFlower(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    // Please Sign Up to continue using our app Text
                    Text(
                      "Please FindID to continue using our app",
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

                    // 이메일
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
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
                        // 이메일 정규 표현식 ^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+
                        validator: (value) {
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                            isEmailState = false;
                            return "이메일을 입력해주세요";
                          } else {
                            isEmailState = true;
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.purple,
                          ),
                          //   suffixIcon: GestureDetector(
                          //     onTap: () async {
                          //       if (isEmailState == true) {
                          //         myauth.setConfig(
                          //           appEmail: "me@rohitchouhan.com",
                          //           appName: "Email OTP",
                          //           userEmail: email,
                          //           otpLength: 6,
                          //           otpType: OTPType.digitsOnly,
                          //         );

                          //         if (await myauth.sendOTP() == true) {
                          //           Get.snackbar(
                          //             "확인 메시지",
                          //             "이메일로 인증 번호를 전송했습니다",
                          //             duration: const Duration(seconds: 5),
                          //             snackPosition: SnackPosition.TOP,
                          //           );
                          //         } else {
                          //           Get.snackbar(
                          //             "이상 메시지",
                          //             "FAIL",
                          //             duration: const Duration(seconds: 5),
                          //             snackPosition: SnackPosition.TOP,
                          //           );
                          //         }
                          //       } else {
                          //         Get.snackbar(
                          //           "이상 메시지",
                          //           "이메일을 올바르게 입력해주세요",
                          //           duration: const Duration(seconds: 5),
                          //           snackPosition: SnackPosition.TOP,
                          //         );
                          //       }
                          //     },
                          //     child: const Icon(Icons.message),
                          //   ),
                          //   filled: true,
                          //   fillColor: Colors.white,
                          //   labelText: "이메일 주소",
                          //   hintText: 'ex) abcdef@naver.com',
                          //   labelStyle: const TextStyle(color: Colors.purple),
                          // ),
                        ),
                      ),
                    ),

                    // 인증값
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 40,
                    //     right: 40,
                    //     bottom: 20,
                    //     top: 20,
                    //   ),
                    //   child: TextFormField(
                    //     autovalidateMode: AutovalidateMode.always,
                    //     onChanged: (val) {
                    //       setState(() {
                    //         emailVerificationValue = val;
                    //       });
                    //     },
                    //     onSaved: (val) {
                    //       setState(() {
                    //         emailVerificationValue = val!;
                    //       });
                    //     },
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "인증번호를 입력해주세요";
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //       focusedBorder: const UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       enabledBorder: const UnderlineInputBorder(
                    //         borderSide: BorderSide.none,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //       prefixIcon: const Icon(
                    //         Icons.person,
                    //         color: Colors.purple,
                    //       ),
                    //       suffixIcon: GestureDetector(
                    //         onTap: () async {
                    //           if (await myauth.verifyOTP(
                    //                   otp: emailVerificationValue) ==
                    //               true) {
                    //             isEmailVerificationValue = true;
                    //             Get.snackbar(
                    //               "확인 메시지",
                    //               "인증 완료 되었습니다",
                    //               duration: const Duration(seconds: 5),
                    //               snackPosition: SnackPosition.TOP,
                    //             );
                    //           } else {
                    //             isEmailVerificationValue = false;
                    //             Get.snackbar(
                    //               "이상 메시지",
                    //               "FAIL",
                    //               duration: const Duration(seconds: 5),
                    //               snackPosition: SnackPosition.TOP,
                    //             );
                    //           }
                    //         },
                    //         child: const Icon(Icons.check),
                    //       ),
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       labelText: "인증번호",
                    //       hintText: 'ex) 000000',
                    //       labelStyle: const TextStyle(color: Colors.purple),
                    //     ),
                    //   ),
                    // ),

                    // 중간 공백
                    const SizedBox(
                      height: 20,
                    ),

                    // 아이디 찾기 버튼
                    ElevatedButton(
                      onPressed: () async {
                        if (isEmailState == true) {
                          // 서버와 통신
                          // 이메일을 통해 사용자의 아이디를 찾는다.
                          final response = await dio.post(
                            'http://${IpAddress.hyunukIP}:8080/Find/Account',
                            data: {
                              // 이메일(String)
                              'email': email,
                            },
                            options: Options(
                              validateStatus: (_) => true,
                              contentType: Headers.jsonContentType,
                              responseType: ResponseType.json,
                            ),
                          );

                          // 서버와 통신 성공
                          if (response.statusCode == 200) {
                            print("서버와 통신 성공");
                            print("서버에서 제공해주는 데이터 : ${response.data}");

                            // 아이디를 보여주는 다이어로그
                            Get.dialog(
                              AlertDialog(
                                title: const Text("아이디 찾기"),
                                content: SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      // 아이디를 보여주는 문구
                                      Text("회원님 아이디는\n${response.data}입니다."),

                                      // 중간 공백
                                      const SizedBox(height: 50),

                                      // 로고인 페이지로 이동하는 버튼
                                      TextButton(
                                        child: const Text("로고인 페이지로 이동"),
                                        onPressed: () {
                                          // 아이디를 보여주는 다이어로그를 삭제한다.
                                          Get.back();

                                          // 로고인 페이지로 라우팅
                                          Get.off(() => const LoginScreen());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          // 서버와 통신 실패
                          else {
                            print("서버와 통신 실패");
                            print("서버 통신 에러 코드 : ${response.statusCode}");

                            Get.snackbar(
                              "서버 통신 실패",
                              "서버 통신 에러 코드 : ${response.statusCode}",
                              duration: const Duration(seconds: 5),
                              snackPosition: SnackPosition.TOP,
                            );
                          }
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
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3.3,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Find ID",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(
                      height: 40,
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
