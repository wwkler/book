// 회원가입 하는 페이지 화면
import 'dart:convert';
import 'dart:math';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // id
  String id = "";
  bool isIdState = false;

  // password
  String password = "";
  bool isPasswordState = false;

  // verifyPassword
  String verifyPassword = "";
  bool isVerifyPasswordState = false;

  // name
  String name = "";
  bool isNameState = false;

  // age
  int age = -1;
  bool isAgeState = false;

  // gender
  String gender = "";
  bool isGenderState = false;

  // category
  Map<String, int> category = {
    "국내도서>소설": 101,
    "국내도서>시/에세이": 102,
    "국내도서>예술/대중문화": 103,
    "국내도서>사회과학": 104,
    "국내도서>역사와 문화": 105,
    "국내도서>잡지": 107,
    "국내도서>만화": 108,
    "국내도서>유아": 109,
    "국내도서>아동": 110,
    "국내도서>가정과 생활": 111,
    "국내도서>청소년": 112,
    "국내도서>초등학습서": 113,
    "국내도서>고등학습서": 114,
    "국내도서>국어/외국어/사전": 115,
    "국내도서>자연과 과학": 116,
    "국내도서>경제경영": 117,
    "국내도서>자기계발": 118,
    "국내도서>인문": 119,
    "국내도서>종교/역학": 120,
    "국내도서>컴퓨터/인터넷": 122,
    "국내도서>자격서/수험서": 123,
    "국내도서>취미/레저": 124,
    "국내도서>전공도서/대학교재": 125,
    "국내도서>건강/뷰티": 126,
    "국내도서/여행": 128,
    "국내도서>중등학습서": 129,
  };
  String selectedCategory = "국내도서>소설";
  int selectedCode = 101;

  // 이메일
  String email = "";
  bool isEmailState = false;

  // 앱에서 사용자에게 제공하는 인증번호
  EmailOTP myauth = EmailOTP();

  // 사용자가 입력해야 하는 인증번호
  String emailVerificationValue = "";
  bool isEmailVerificationValue = false;

  // isServiceCheck, isPersonInformationCheck
  bool isServiceCheck = false;
  bool isPersonInformationCheck = false;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    // twilioFlutter = TwilioFlutter(
    //   accountSid: TwilloApiKey.accountSid,
    //   authToken: TwilloApiKey.authToken,
    //   twilioNumber: TwilloApiKey.twilioNumber,
    // );
    print("Sign Up initState 시작");

    super.initState();
  }

  @override
  void dispose() {
    print("Sign Up state 종료");
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
                      "BookMakase Sign Up Screen",
                      style: GoogleFonts.indieFlower(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    // Please Sign Up to continue using our app Text
                    Text(
                      "Please Sign Up to continue using our app",
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
                          // 아이디 길이는 6자리 이상 12자리 이하
                          if (!RegExp(r"^[0-9a-z]+$").hasMatch(value!)) {
                            isIdState = false;
                            return "숫자, 영문만 입력해주세요";
                          } else if (value.length < 6 || value.length > 13) {
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
                          hintText: 'ex) abcdefg1',
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // Password
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
                          // if (!RegExp(
                          //         r"^(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,14})(?=.*[a-zA-Z]{2,14}).{8,14}$")
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

                    // Verify Password
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

                    // 이름
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

                    // 나이
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                        bottom: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (String val) {
                          setState(() {
                            age = int.parse(val);
                          });
                        },
                        onSaved: (String? val) {
                          setState(() {
                            age = int.parse(val!);
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
                          } else if (int.parse(value) <= 0) {
                            return "1 이상 99 이하의 정수를 입력해주세요";
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

                    // 성별
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
                            gender = val;
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            gender = val!;
                          });
                        },
                        // 성별은 "남" or "여"만 받을 수 있다.
                        validator: (String? value) {
                          if (value == "남" || value == "여") {
                            isGenderState = true;
                            return null;
                          } else {
                            isGenderState = false;
                            return "남 또는 여를 입력하세요";
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
                          labelText: "성별",
                          hintText: "남 or 여",
                          labelStyle: TextStyle(color: Colors.purple),
                        ),
                      ),
                    ),

                    // 선호하는 도서 장르
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
                        onChanged: (String? key) {
                          setState(() {
                            selectedCategory = key!;
                            selectedCode = category[key]!;
                            print(selectedCode);
                          });
                        },
                        items: category.keys
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
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
                            print(email);
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

                    // 인증 확인
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
                            print(emailVerificationValue);
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

                    // 서비스 이용 약관 동의
                    Row(
                      children: [
                        const SizedBox(width: 30),

                        // 체크 박스
                        Checkbox(
                          value: isServiceCheck,
                          onChanged: (bool? isServiceCheck) {
                            setState(() {
                              this.isServiceCheck = isServiceCheck!;
                            });
                          },
                        ),

                        // 서비스 약관 동의 Text
                        const Text(
                          "서비스 약관 동의",
                        ),

                        const SizedBox(width: 60),

                        // 자세히 보기 Text
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "자세히 보기 > ",
                          ),
                        ),
                      ],
                    ),

                    // 개인정보 수집, 이용 동의
                    Row(
                      children: [
                        const SizedBox(width: 30),

                        // 체크 박스
                        Checkbox(
                          value: isPersonInformationCheck,
                          onChanged: (bool? isPersonInformationCheck) {
                            setState(() {
                              this.isPersonInformationCheck =
                                  isPersonInformationCheck!;
                            });
                          },
                        ),

                        // 개인정보 수집, 이용 동의 Text
                        const Text(
                          "개인정보 수집, 이용 동의",
                        ),

                        const SizedBox(width: 15),

                        // 자세히 보기 Text
                        const Text(
                          "자세히 보기 > ",
                        ),
                      ],
                    ),

                    // 중간 공백
                    const SizedBox(
                      height: 15,
                    ),

                    // Sign Up 버튼
                    ElevatedButton(
                      onPressed: () async {
                        if (isIdState == true &&
                            isPasswordState == true &&
                            isVerifyPasswordState == true &&
                            isNameState == true &&
                            isAgeState == true &&
                            isGenderState == true &&
                            isEmailState == true &&
                            isEmailVerificationValue == true &&
                            isServiceCheck == true &&
                            isPersonInformationCheck == true) {
                          // 서버와 통신
                          // 회원 정보를 데이터베이스에 등록한다.
                          final response = await dio.post(
                            'http://${IpAddress.hyunukIP}:8080/register',
                            data: {
                              // 사용자 아이디(string)
                              'account': id,

                              // 사용자 비밀번호(string)
                              'password': password,

                              // 이름(String)
                              'name': name,

                              // 나이(int)
                              'age': age,

                              // 성별(String)
                              'gender': gender,

                              // 선호 도서 장르(int)
                              'prefer': selectedCode,

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

                            // 회원 가입 페이지에서 벗어나 로고인 페이지로 라우팅한다.
                            Get.off(() => const LoginScreen());
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
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 3.3,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
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
