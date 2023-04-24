// 아이디를 찾기 위한 화면
import 'dart:math';

import 'package:book_project/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  final _formKey = GlobalKey<FormState>();

  // phoneNNumber
  String phoneNumber = "";
  bool isPhoneNumberState = false;

  // 앱에서 사용자에게 제공하는 인증번호
  late TwilioFlutter twilioFlutter;
  String session = "";

  // 사용자가 입력해야 하는 인증번호
  String phoneSessionValue = "";
  bool isPhoneSessionValue = false;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'ACe85bf95b8c67f941ffdff01de2fdae7b',
        authToken: 'dc5637ccfa2cce5809ee5d46d801e1b0',
        twilioNumber: '+16073604847');
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

                    // -를 제외한 핸드폰번호
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
                            phoneNumber = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            phoneNumber = val!;
                          });
                        },
                        // 핸드폰 번호 정규표현식 : ^010-?([0-9]{4})-?([0-9]{4})$
                        validator: (value) {
                          if (!RegExp(r"^010-?([0-9]{4})-?([0-9]{4})$")
                              .hasMatch(value!)) {
                            isPhoneNumberState = false;
                            return "핸드폰 번호를 입력해주세요";
                          } else {
                            isPhoneNumberState = true;
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
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              if (isPhoneNumberState == true) {
                                // 앱에서 인증번호를 만들어서 사용자 핸드폰 번호에 전달함
                                session = Random().nextInt(99999).toString();
                                await twilioFlutter.sendSMS(
                                  toNumber: "+82$phoneNumber",
                                  messageBody: '인증번호는 $session 입니다.',
                                );
                                Get.snackbar(
                                  "문자 전송 메시지",
                                  "해당 전화번호로 인증번호가 전송됐습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                Get.snackbar(
                                  "이상 메시지",
                                  "핸드폰 번호를 올바르게 입력해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: const Icon(Icons.message),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "-를 제외한 전화번호",
                          hintText: 'ex) 01011112222',
                          labelStyle: const TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 핸드폰번호 인증값
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
                            phoneSessionValue = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            phoneSessionValue = val!;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "인증번호를 입력해주세요";
                          } else {
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (phoneSessionValue != "" &&
                                  phoneSessionValue == session) {
                                isPhoneSessionValue = true;
                                Get.snackbar(
                                  "확인 증명 메시지",
                                  "인증번호가 올바릅니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                isPhoneSessionValue = false;
                                Get.snackbar(
                                  "이상 메시지",
                                  "인증번호가 올바르지 않습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: const Icon(Icons.check),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "인증번호",
                          hintText: 'ex) 000000',
                          labelStyle: const TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(
                      height: 20,
                    ),

                    // 아이디 찾기 버튼
                    ElevatedButton(
                      onPressed: () {
                        if (isPhoneNumberState == true &&
                            isPhoneSessionValue == true) {
                          print("서버와 통신");

                          // 서버와 통신
                          // 핸드폰 번호를 통해 사용자의 아이디를 찾는다.

                          // 서버로부터 아이디를 받으면 다시 LoginScreen으로 이동한다.
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
