// 회원가입 하는 페이지 화면
import 'dart:math';
import 'package:book_project/screen/auth/login.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // id
  String id = "";
  bool isIdState = false;

  // 이메일
  String email = "";
  bool isEmailState = false;

  // 앱에서 사용자에게 제공하는 인증번호
  // late TwilioFlutter twilioFlutter;
  // String session = "";
  EmailOTP myauth = EmailOTP();

  // 사용자가 입력해야 하는 인증번호
  String emailVerificationValue = "";
  bool isEmailVerificationValue = false;

  // 새로운 password
  String password = "";
  bool isPasswordState = false;

  // 새로운 password 확인
  String verifyPassword = "";
  bool isVerifyPasswordState = false;

  @override
  void initState() {
    // twilioFlutter = TwilioFlutter(
    //     accountSid: 'ACe85bf95b8c67f941ffdff01de2fdae7b',
    //     authToken: 'dc5637ccfa2cce5809ee5d46d801e1b0',
    //     twilioNumber: '+16073604847');
    print("Find Password initState 시작");

    super.initState();
  }

  @override
  void dispose() {
    print("Find Password state 종료");
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

                    // BookMakase ChangePassword Text
                    Text(
                      "BookMakase\n ChangePassword Screen",
                      style: GoogleFonts.indieFlower(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    // Please ChangePassword to continue using our app Text
                    Text(
                      "Please FindPassword to continue using our app",
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

                    // ID
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
                        // 핸드폰 번호 정규표현식 : ^010-?([0-9]{4})-?([0-9]{4})$
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
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              if (isEmailState == true) {
                                // 앱에서 인증번호를 만들어서 사용자 핸드폰 번호에 전달함
                                // session = Random().nextInt(99999).toString();

                                // await twilioFlutter.sendSMS(
                                //   toNumber: "+82$phoneNumber",
                                //   messageBody: '인증번호는 $session 입니다.',
                                // );

                                myauth.setConfig(
                                  appEmail: "me@rohitchouhan.com",
                                  appName: "Email OTP",
                                  userEmail: email,
                                  otpLength: 6,
                                  otpType: OTPType.digitsOnly,
                                );

                                if (await myauth.sendOTP() == true) {
                                  Get.snackbar(
                                    "확인 메시지",
                                    "이메일로 인증 번호를 전송했습니다",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                } else {
                                  Get.snackbar(
                                    "이상 메시지",
                                    "FAIL",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "이상 메시지",
                                  "이메일을 올바르게 입력해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                            child: const Icon(Icons.message),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "이메일 주소",
                          hintText: 'ex) abcdef@naver.com',
                          labelStyle: const TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 인증값
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
                            emailVerificationValue = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            emailVerificationValue = val!;
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
                            onTap: () async {
                              if (await myauth.verifyOTP(
                                      otp: emailVerificationValue) ==
                                  true) {
                                isEmailVerificationValue = true;
                                Get.snackbar(
                                  "확인 메시지",
                                  "인증 완료 되었습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              } else {
                                isEmailVerificationValue = false;
                                Get.snackbar(
                                  "이상 메시지",
                                  "FAIL",
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

                    // 새로운 Password
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

                    // 새로운 Password 확인
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
                    const SizedBox(
                      height: 15,
                    ),

                    // 비밀번호 변경 버튼
                    ElevatedButton(
                      onPressed: () {
                        if (isIdState == true &&
                            isEmailState == true &&
                            isEmailVerificationValue == true &&
                            isPasswordState == true &&
                            isVerifyPasswordState == true) {
                          print("서버와 통신");

                          // 서버와 통신
                          // 비밀번호 변경해서 데이터베이스에 업데이트한다.
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
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Change Password",
                        style: TextStyle(fontSize: 15),
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
