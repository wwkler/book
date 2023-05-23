// 회원가입 하는 페이지 화면
import 'dart:convert';
import 'dart:math';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        "BookMakase Sign Up Screen",
                        style: GoogleFonts.indieFlower(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.sp,
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
                            fontSize: 15.sp,
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 30.h,
                      ),

                      // ID
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
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
                            else if (value.length < 6 || value.length > 13) {
                              isIdState = false;
                              return "6자리 이상 12자리 이하를 입력해주세요";
                            }
                            //
                            else {
                              isIdState = true;
                              return null;
                            }
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
                            hintText: 'ex) abcdefg1',
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // Password
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                          // 비밀번호는 8자리 ~ 14자리만 받도록 한다.
                          validator: (String? value) {
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
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // Verify Password
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                            labelText: "Verify Password",
                            hintText: 'ex) ********',
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 이름
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                            labelText: "이름",
                            hintText: "ex) 홍길동",
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 나이
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                            }
                            //
                            else if (value.length >= 3) {
                              isAgeState = false;
                              return "숫자로 최소 1자, 최대 2자를 입력해주세요";
                            }
                            //
                            else if (int.parse(value) <= 0) {
                              return "1 이상 99 이하의 정수를 입력해주세요";
                            }
                            //
                            else {
                              isAgeState = true;
                              return null;
                            }
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
                            labelText: "나이",
                            hintText: "ex) 25",
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 성별
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                            labelText: "성별",
                            hintText: "남 or 여",
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 선호하는 도서 장르
                      Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
                        ),
                        child: DropdownButtonFormField(
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
                            labelText: "선호하는 도서 장르",
                            hintText: "인문",
                            labelStyle: const TextStyle(color: Colors.purple),
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
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                if (isEmailState == true) {
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
                                  }
                                  //
                                  else {
                                    Get.snackbar(
                                      "이상 메시지",
                                      "FAIL",
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                }
                                //
                                else {
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
                        padding: EdgeInsets.only(
                          left: 40.w,
                          right: 40.w,
                          bottom: 20.h,
                          top: 20.h,
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
                                }
                                //
                                else {
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
                          SizedBox(width: 30.w),

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

                          SizedBox(width: 60.w),

                          // 자세히 보기 Text
                          GestureDetector(
                            onTap: () {
                              Get.dialog(
                                SizedBox(
                                  width: 300.w,
                                  height: 300.h,
                                  child: AlertDialog(
                                    title: const Text("서비스 이용 약관"),
                                    content: SizedBox(
                                      width: 300.w,
                                      height: 300.h,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            // Text
                                            const Text(
                                                "이용자님의 권리 및 의무를 이해하기 위하여 애플리케이션 소프트웨어 이용약관(이하 본 약관)을 주의 깊게 읽어주시길 바랍니다."),

                                            // 중간 공백
                                            SizedBox(height: 50.h),

                                            const Text(
                                                "제1조 목적\n본 약관은 ㈜북마카세(이하 ‘회사’)가 스마트 기기를 통해 제공하는 모든 애플리케이션, 기타 제반 서비스(이하 ‘서비스’)를 이용하는 사용자(이하 ‘이용자’)와 회사 간에 서비스의 이용에 관한 권리, 의무 및 책임 사항, 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조 용어 정의\n① 본 약관에서 사용하는 용어의 정의는 다음과 같습니다. ‘애플리케이션’이란 회사가 제공하는 서비스를 이용하기 위해 스마트 기기를 통해 다운로드 받거나 설치하여 사용하는 프로그램 일체를 말합니다. ‘이용자’란 본 약관에 동의함을 전제로 회사가 제공하는 모든 애플리케이션 및 제반 서비스를 이용하는 자를 말합니다. ‘스마트 기기’란 콘텐츠를 다운로드 받거나 설치하여 이용하거나 네트워크를 통하여 이용할 수 있는 스마트폰, 태블릿 등의 네트워크를 사용할 수 있는 기기를 말합니다. ‘콘텐츠’란 스마트 기기 등을 통하여 이용할 수 있도록 회사가 제공하는 애플리케이션 서비스와 관련되어 디지털 방식으로 제작된 텍스트, 사진, 그림 등 내용물 일체를 말합니다.\n② 본 약관에서 사용하는 용어의 정의는 제 2조 1항에서 정하는 것을 제외하고는 관계 법령에서 정하는 바를 따릅니다. 관계 법령에서 정하지 않는 것은 일반적인 상 관례에 의합니다.\n\n제3조 약관의 효력 및 변경\n① 본 약관은 애플리케이션 소프트웨어 및 해당 애플리케이션의 모든 패치, 업데이트, 업그레이드 또는 새로운 버전에 적용되며, 가장 최신 버전이 모든 기존 버전에 우선합니다.\n② 본 약관은 서비스 이용계약의 성격상 회사의 웹사이트 또는 서비스 이용을 위한 애플리케이션 내에 본 약관을 명시하고, 이용자가 애플리케이션을 설치 및 실행함과 동시에 효력이 발생합니다.\n③ 회사는 관계 법령 또는 상관습에 위배되지 않는 범위에서 본 약관을 개정할 수 있습니다.\n④ 회사는 관련 법령의 변경이나 이용자의 권리 및 의무사항, 서비스 등을 개선하기 위해 본 약관을 변경할 수 있으며, 변경된 경우에 약관의 내용과 적용 일을 정하여, 적용일 7일 전 서비스 웹사이트나 애플리케이션 등을 통해 이용자에게 고지하고 적용일부터 효력이 발생합니다.\n⑤ 이용자는 변경된 약관에 대해 거부할 권리가 있습니다. 본 약관의 변경에 대해 이의가 있는 이용자는 서비스 이용을 중단하고 이용을 해지(탈퇴 및 삭제)할 수 있습니다.\n⑥ 회사가 본 조 4항에 따라 변경된 약관을 공시 또는 고지하면서 이용자가 기간 내의 의사표시를 하지 않으면 변경된 약관에 동의한 것으로 간주합니다.\n\n제4조 약관의 해석\n본 약관은 회사가 제공하는 개별 서비스의 별도 정책과 함께 적용되며, 이에 명시되지 아니한 사항에 대해서는 별도의 약관 혹은 정책을 둘 수 있으며, 약관 및 정책은 정부가 제정한 관계 법령 또는 상 관례에 따릅니다.\n\n제5조 이용계약의 성립\n① 이용계약은 이용자가 본 이용약관에 대한 동의 또는 회사의 애플리케이션을 다운로드 받거나 실행하여 이용하는 경우 이 약관에 동의한 것으로 간주합니다.\n② 이용자는 동의하지 않는 경우 서비스 탈퇴 및 애플리케이션 계정 삭제와 함께 이를 철회할 수 있습니다.\n\n제6조 개인 정보의 보호 및 사용\n① 회사는 관계 법령이 정하는 바에 따라 이용자의 개인정보를 보호하기 위해 노력하며, 개인 정보의 보호 및 사용에 대해서는 관련 법령 및 회사의 개인정보 취급방침에 따릅니다. 단, 회사에서 제공하지 않는 서비스 및 애플리케이션에 대해서는 회사의 개인정보취급방침이 적용되지 않습니다.\n② 회사는 통신비밀보호법, 정보통신망법 등 관계 법령에 의해 관련 국가기관 등의 요구가 있는 경우를 제외하고는 이용자의 개인정보를 본인의 승낙 없이 타인에게 제공하지 않습니다.\n\n제7조 개인 정보의 관리 및 변경\n이용자는 본 서비스의 이용을 위해 자신의 개인 정보를 성실히 관리해야 하며, 개인정보에 변동사항이 있을 경우 이를 변경해야 합니다. 본 서비스를 이용하면서 이용자의 개인정보변경이 지연되거나 누락, 이용자에 의해 유출되어 발생하는 손해는 이용자의 책임으로 합니다.\n\n제8조 회사의 의무\n① 회사는 관련법과 본 약관의 금지하는 행위를 하지 않으며, 계속적이고 안정적인 서비스를 제공하기 위하여 최선을 다하여 노력합니다.\n② 회사는 이용자의 개인정보보호를 위한 보안 의무에 최선을 다합니다.\n③ 회사는 이용자로부터 제기되는 의견이나 불만이 정당하고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 즉시 처리하여야 합니다. 다만, 즉시 처리가 불가한 경우에는 이용자에게 그 사유와 처리 일정을 통보하여야 합니다.\n\n제9조 이용자의 의무\n① 이용자는 본 약관에서 규정하는 사항과 기타 회사가 정한 제반 규정, 회사가 공지하는 사항을 준수하여야 합니다. 또한, 이용자는 회사의 업무에 방해가 되는 행위, 회사의 명예를 손상시키는 행위를 해서는 안 됩니다.\n② 이용자는 청소년보호법 등 관계 법령에 준수하여야 합니다. 이용자가 청소년 보호법 등 관계 법령을 위반한 경우는 해당 법령에 의거 처벌을 받게 됩니다.\n③ 이용자는 회사의 사전 승낙 없이 영리를 목적으로 서비스를 사용할 수 없으며, 이와 같은 행위로 회사에 손해를 끼친 경우, 이용자는 회사에 대한 손해배상 의무를 지며, 회사는 해당 이용자에 대해 서비스 이용 제한 및 적법한 절차를 거쳐 손해배상 등을 청구할 수 있습니다.\n④ 이용자의 닉네임에 관한 관리책임은 이용자에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.\n⑤ 이용자는 다음 각호에 해당하는 행위를 하여서는 안 되며, 해당 행위를 하는 경우에 회사는 이용자의 서비스 이용제한, 관련 정보(글, 사진, 영상 등) 삭제 및 적법 조치를 포함한 이용제한 조치를 가할 수 있습니다. 또한, 그로 인해 발생한 문제의 책임은 이용자 본인에게 있습니다.\n(1) 각종 신청, 변경, 등록 시 허위의 내용을 등록하거나, 타인을 기만하는 행위\n(2) 타인의 정보를 도용한 행위\n(3) 회사로부터 특별한 권리를 받지 않고 애플리케이션을 역설계, 디컴파일, 분해, 임대, 재허락, 발행, 수정, 개조, 개작 또는 번역함, 2차적 저작물 작성, 다른 유저들이 네트워크에 접속하여 이용 가능하도록 하는 행위\n(4) 애플리케이션의 이전 버전을 재설치(이하 “다운그레이드”라고 함)하는 행위\n(5) 회사로부터 정식으로 인가된 배포 방식을 통하지 않고 다른 방식으로 애플리케이션을 배포 또는 사용하는 행위\n(6) 회사의 서버를 해킹하거나 웹사이트 또는 게시된 정보의 일부분 또는 전체를 임의로 변경하거나, 회사의 서비스를 비정상적인 방법으로 사용하는 행위\n(7) 회사의 애플리케이션 상의 버그를 악용하는 행위\n(8) 서비스에 위해를 가하거나 서비스를 고의로 방해하는 행위\n(9) 본 서비스를 통해 얻은 정보를 회사의 사전 승낙 없이 서비스 이용 외의 목적으로 복제하거나, 이를 출판 및 방송 등에 사용하거나, 제 3자에게 제공하는 행위\n(10) 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 전송, 게시 또는 기타의 방법으로 타인에게 유포하는 행위\n(11) 청소년보호법 또는 법에 위반되는 저속, 음란한 내용의 정보, 문장, 도형, 음향, 동영상을 전송, 게시 또는 기타의 방법으로 타인에게 유포 하는 행위\n(12) 타인에게 불쾌감을 줄 수 있는 모욕적이거나 개인신상에 대한 내용이나 타인의 명예나 프라이버시를 침해할 수 있는 내용을 전송, 게시 또는 기타의 방법으로 타인에게 유포하는 행위"),

                                            const Text(
                                                "\n(13) 다른 이용자를 희롱 또는 위협하거나, 특정 이용자에게 지속해서 고통 또는 불편을 주는 행위\n(14) 회사의 승인을 받지 않고 다른 사용자의 개인 정보를 수집 또는 저장하는 행위\n(15) 범죄와 결부된다고 객관적으로 판단되는 행위\n(16) 기타 관계 법령에 위배되는 행위\n\n제10조 서비스의 제공\n① 이용자가 본 약관에 대한 동의 또는 회사의 애플리케이션을 다운로드하거나 실행하여 이용하는 시점에 서비스 이용계약이 성립한 것으로 간주합니다. 단, 일부 서비스의 경우 회사의 필요에 따라 지정된 일자부터 서비스를 개시할 수 있습니다.\n② 회사는 이용자에게 본 약관에 정하고 있는 서비스를 포함하여 기타 부가적인 서비스를 함께 제공할 수 있습니다. \n\n제11조 서비스의 이용\n① 회사는 스마트 기기를 위한 전용 애플리케이션을 이용하여 서비스를 제공하며, 이용자는 애플리케이션을 다운로드하여 설치하여 무료로 서비스를 이용할 수 있습니다.\n② 네트워크를 통해 애플리케이션 다운로드 또는 서비스를 이용하는 경우 가입한 이동통신사에서 정한 별도의 요금이 발생할 수 있습니다."),

                                            const Text(
                                                "\n③ 회사는 업무상 또는 기술상의 장애로 인하여 서비스 이용이 불가능한 경우를 제외하고는 연중무휴 24시간으로 함을 원칙으로 합니다.\n④ 회사가 제공하는 서비스 이용에 필요한 시스템 최소 요구사항은 아래와 같습니다.\n∙ Mobile\n- iOS : 9.0 이상\n- Android 4.4 이상"),

                                            const Text(
                                                "\n\n제12조 서비스의 변경 및 중지\n① 회사는 운영상 또는 기술상의 필요에 따라 제공하고 있는 서비스를 변경할 수 있습니다. 변경될 서비스의 내용 및 제공 일자 등에 대해서는 공식 홈페이지 또는 애플리케이션을 통해서 이용자에게 사전 공지합니다. 단, 회사가 사전에 통지할 수 없는 치명적인 버그 발생, 서버의 오작동, 긴급 보안 문제 해결 등의 부득이한 사정이 있는 경우 사후에 통지할 수 있습니다.\n② 회사는 서비스의 기획이나 운영상 또는 회사의 긴박한 상황 등에 의해 서비스 전부를 중단할 필요가 있는 경우 공식 웹사이트 또는 애플리케이션을 통해서 이를 공지하고 서비스의 제공을 중단할 수 있습니다.\n③ 회사는 다음 각호에 해당하는 경우 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다."),

                                            const Text(
                                                "\n(1) 전시, 사변, 천재지변 또는 국가비상사태 등 불가항력적인 사유가 있는 경우\n(2) 정전, 제반 설비의 장애 또는 이용량의 폭주 등으로 정상적인 서비스 이용에 지장이 있는 경우\n(3) 서비스용 설비의 보수 등 공사로 인한 부득이한 경우\n(4) 회사의 제반 사정으로 서비스를 할 수 없는 경우"),

                                            const Text(
                                                "\n④ 회사는 서비스의 변경 및 중지로 발생하는 문제에 대해서는 책임을 지지 않습니다.\n\n 제13조 서비스 이용 제한\n회사는 이용자가 서비스 이용 내용에 있어서 본 약관 제9조 내용을 위반하는 경우 사전 통보 없이 서비스 이용을 제한할 수 있습니다."),

                                            const Text(
                                                "\n제14조 정보의 제공 및 광고 게재\n① 회사는 본 서비스 등을 유지하기 위하여 광고를 게재할 수 있으며, 이용자는 서비스 이용 시 노출되는 광고게재에 대하여 동의합니다.\n② 회사가 제공하는, 제 3자가 주체인, 본 조제 1항의 광고에 이용자가 참여하거나 교신 또는 거래를 함으로써 발생하는 손실과 손해에 대해서는 회사는 어떠한 책임도 부담하지 않습니다."),

                                            const Text(
                                                "\n③ 회사는 서비스 개선 및 이용자 대상 서비스 소개 등을 위한 목적으로 이용자 개인에 대한 추가 정보를 요구할 수 있으며, 동 요청에 대해 이용자는 승낙하여 추가 정보를 제공하거나 거부할 수 있습니다.\n④ 회사는 이용자의 사전 동의 하에 이용자로부터 수집한 개인정보를 활용하여 본 조제 1항의 광고 및 제 3항의 정보 등을 제공하는 경우 SMS(LMS), 스마트폰 알림(Push 알림), E-Mail을 활용하여 발송할 수 있으며, 이용자가 원하지 않는 경우에는 언제든지 수신을 거부할 수 있습니다.\n⑤ 상기 정보제공과 광고와 관련해서 정보를 회사에 제공하는 플랫폼 사업자, 앱스토어 사업자의 약관 및 회사의 약관에 준거하며 관련 법령 및 시행령에 따라 제공합니다."),

                                            const Text(
                                                "\n\n제15조 저작권의 귀속 및 이용제한\n① 애플리케이션을 사용할 수 있는 모든 권리는 라이선스에 의하여만 부여될 수 있으며, 회사가 애플리케이션에 대한 모든 지적재산권을 보유합니다. 이용자는 애플리케이션에 대한 어떠한 소유권 및 이권도 부여되지 않습니다.\n② 회사가 작성한 저작물에 대한 저작권 및 기타 지적재산권은 회사에 귀속합니다.\n③ 이용자는 서비스를 이용하면서 얻은 정보를 회사의 승낙 없이 영리목적으로 이용하거나 제 3자에게 이용하게 할 수 없습니다."),

                                            const Text(
                                                "\n\n제16조 이용자의 게시물\n① 이용자의 게시물로 인해 발생하는 손실이나 문제는 이용자 개인의 책임이며, 회사는 이에 대한 책임을 지지 않습니다.\n② 회사는 특정 게시물이 명예훼손, 사생활침해 등에 해당한다고 판단될 경우 그 게시자에게 사전 통지 없이 관련 게시물이나 자료에 대하여 ‘임시 조치’를 취하며, 그 이후에는 당사자 간 합의와 관련 법령 및 회사의 정책에 따라 이를 삭제 또는 복원할 수 있습니다."),

                                            const Text(
                                                "\n\n제17조 계약 해지 및 서비스 이용 중지\n① 이용자는 언제든지 서비스 이용을 원하지 않는 경우 회원탈퇴를 통해 계약을 해지할 수 있습니다. 탈퇴는 즉시처리 되며 탈퇴 시 이용자가 작성한 콘텐츠 정보는 모두 삭제되어 복구가 불가능합니다.\n② 이용자가 다음 각 호의 사유에 해당하는 행위를 한 경우, 이용계약을 해지하거나 기간을 정하여 서비스 이용을 중지할 수 있습니다."),

                                            const Text(
                                                "\n(1) 서비스 신청 시에 허위 내용을 등록한 경우\n(2) 서비스 운영을 고의로 방해한 경우\n(3) 타인의 정보를 도용한 경우\n(4) 서비스의 안정적 운영을 방해할 목적으로 다량의 정보를 전송하거나 광고성 정보를 전송하는 경우\n(5) 회사 및 이용자에게 피해를 유발하는 컴퓨터 바이러스 프로그램 등을 유포하는 경우\n(6) 그 외 서비스 정책에 위배되는 사항"),

                                            const Text(
                                                "\n③ 본 조 2항의 규정에 따라 이용계약을 해지하거나 중단하는 경우 이용자는 다운로드 받은 콘텐츠를 이용할 수 없습니다."),

                                            const Text(
                                                "\n\n제18조 손해 배상\n① 회사는 회사가 제공하는 무료 서비스 이용과 관련하여 이용자에게 발생한 어떠한 손해에 대해서도 책임을 지지 않습니다. 다만, 회사의 귀책사유로 인한 것일 경우에는 이용자가 입은 손해에 대해 배상합니다."),

                                            const Text(
                                                "\n② 회사가 개별서비스 제공자와 제휴 계약을 맺고 이용자에게 개별서비스를 제공함에 있어 이용자가 개별서비스 이용약관에 동의한 뒤 개별서비스 제공자의 귀책사유로 인해 손해가 발생할 경우 관련 손해에 대해서는 개별서비스 제공자가 책임을 집니다.\n③ 이용자가 서비스를 이용함에 있어 행한 불법 행위나 본 약관 위반행위로 인하여 회사가 당해 이용자 이외의 제 3자로부터 손해배상 청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 이용자는 자신의 책임과 비용으로 회사를 면책시켜야 하며, 회사가 면책되지 못한 경우 당해 이용자는 그로 인한 회사에 발생한 모든 손해를 배상할 책임이 있습니다.\n\n제19조 면책사항"),

                                            const Text(
                                                "\n① 회사는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.\n② 회사는 서비스용 설비의 보수, 교체, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다.\n③ 회사는 스마트 기기 환경으로 인하여 발생하는 제반 문제 또는 회사의 귀책사유가 없는 네트워크 환경으로 인하여 발생하는 문제에 대해서 책임을 지지 않습니다.\n④ 회사는 이용자의 귀책사유로 인한 서비스의 중지 또는 이용 장애, 계약해지에 대하여 책임을 지지 않습니다."),

                                            const Text(
                                                "\n⑤ 회사는 이용자가 본인의 개인정보 등(계정 포함)을 변경하여 얻는 불이익 및 정보 상실에 대해서는 일체 책임을 지지 않습니다."),

                                            const Text(
                                                "\n⑥ 회사는 이용자 상호 간 또는 이용자와 제 3자 상호 간에 서비스를 매개로 발생하는 분쟁에 대해 개입할 의무가 없으며 이로 인한 손해를 배상할 책임을 지지 않습니다."),

                                            const Text(
                                                "\n\n제20조 분쟁의 해결\n① 본 약관에 명시되지 않은 사항이 관계 법령에 규정되어 있을 경우에는 해당 규정에 따릅니다.\n② 서비스 이용으로 발생한 분쟁에 대해 소송이 제기되는 경우 법령에 정한 절차에 따른 법원을 관할 법원으로 합니다."),

                                            const Text(
                                                "\n\n본 약관은 2023년 06월 02일부터 시행됩니다."),

                                            // 읽기 완료 이동하는 버튼
                                            TextButton(
                                              child: const Text("읽기 완료"),
                                              onPressed: () {
                                                // 서비스 이용 약관 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                barrierDismissible: true,
                              );
                            },
                            child: const Text(
                              "자세히 보기 > ",
                            ),
                          ),
                        ],
                      ),

                      // 개인정보 수집, 이용 동의
                      Row(
                        children: [
                          SizedBox(width: 30.w),

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

                          SizedBox(width: 15.w),

                          // 자세히 보기 Text
                          GestureDetector(
                            onTap: () {
                              // 개인정보 수집, 이용 동의 dialog
                              Get.dialog(
                                SizedBox(
                                  width: 300.w,
                                  height: 300.h,
                                  child: AlertDialog(
                                    title: const Text("서비스 이용 약관"),
                                    content: SizedBox(
                                      width: 300.w,
                                      height: 300.h,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            // 개인정보 수집, 이용 동의 text
                                            const Text(
                                                "1. 개인정보의 수집 및 이용 목적\n회사는 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다."),

                                            const Text(
                                                "\n이용자 가입의사 확인, 이용자에 대한 서비스 제공 및 이에 따른 본인 식별.인증, 회원자격 유지.관리,\n서비스 부정이용 방지, 물품 또는 서비스 공급에 따른 요금 결제ㆍ정산, 물품 또는 서비스의 공급.배송,\n인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성,\n지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 개발 및 기존 서비스 개선, 마케팅•광고에의 활용, 이용자 민원처리(민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보 등), 불법 및 부정 이용 방지 등"),

                                            const Text(
                                                "\n\n2. 수집하려는 개인정보의 항목\n"),

                                            const Text(
                                                "회사는 다음의 개인정보 항목을 수집하고 있습니다."),

                                            const Text(
                                                "필수항목 : 생년월일, 이메일, 비밀번호, 이름, 전화번호, 거주 국가, 서비스 이용 기록, 접속로그,\n 쿠키, 접속 IP 정보, 결제기록, 법정대리인 이름, 법정대리인 이메일, 법정대리인 휴대전화번호,\n Google 이용 가입/로그인 시 관련 정보 (Google 계정에 사용자가 생성하거나 제공하는 이름 등의 공개적 개인정보, 사용자가 Google 서비스에 액세스할 때 사용하는 앱, 브라우저, 기기에 대한 정보, 사용자의 활동 정보), Facebook 이용 가입/로그인 시 관련 정보 (Facebook 계정 가입자의 이름, 프로필 사진, 이메일 주소), 음성, 사진, 동영상 등의 형태로 지원 요청 등을 위해 이용자가 스스로 제출하는 자료, 공유 플랫폼,\n 콘텐츠 카테고리, 세부 콘텐츠 카테고리, 콘텐츠 작성 내용"),

                                            const Text("\n3. 개인정보의 보유 및 이용 기간"),

                                            const Text(
                                                "\n회사는 이용자로부터 개인정보를 수집할 때 동의 받은 개인정보 보유 이용기간 또는 법령에 따른 개인정보 보유 이용기간 내에서 개인정보를 처리, 보유합니다."),

                                            const Text(
                                                "\n구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다."),

                                            const Text(
                                                "\n전자상거래에서의 계약ㆍ청약철회, 대금결제, 재화 등 공급기록: 5년, 소비자의 불만 또는 분쟁처리에 관한 기록: 3년, 표시ㆍ광고에 관한 기록: 6개월"),

                                            const Text(
                                                "\n* 가입 신청자 및 가입 신청자의 법정보호자는 상기된 개인정보 수집ㆍ이용을 거부하실 수 있으나, 이 경우 회원 가입이 거절될 수 있습니다."),

                                            // 읽기 완료 이동하는 버튼
                                            TextButton(
                                              child: const Text("읽기 완료"),
                                              onPressed: () {
                                                // 서비스 이용 약관 다이어로그를 삭제한다.
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                barrierDismissible: true,
                              );
                            },
                            child: const Text(
                              "자세히 보기 > ",
                            ),
                          ),
                        ],
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 15.h,
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
                            // 서버와 통신 시도
                            try {
                              final response = await dio.post(
                                'http://${IpAddress.hyunukIP}/register',
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
                              // 회원 정보를 데이터베이스에 등록한다.
                              if (response.statusCode == 200) {
                                print("서버와 통신 성공");
                                print("서버에서 제공해주는 데이터 : ${response.data}");

                                // 회원 가입 성공했다는 snackBar를 보여준다
                                Get.snackbar(
                                  "회원 가입 성공",
                                  "회원 가입에 성공하였습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );

                                // 회원 가입 페이지에서 벗어나 로고인 페이지로 라우팅한다.
                                Get.off(() => const LoginScreen());
                              }
                              // 서버와 통신 실패
                              else {
                                print("서버와 통신 실패");
                                print("서버 통신 에러 코드 : ${response.statusCode}");

                                // 회원 가입 실패했다는 snackBar를 보여준다
                                Get.snackbar(
                                  "회원 가입 실패",
                                  "서버 통신 에러로 회원 가입이 실패하였습니다",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            }
                            // DioError[unknown]: null이 메시지로 나타났을 떄
                            // 즉 서버가 열리지 않았다는 뜻이다
                            catch (e) {
                              print("try catch 의 메시지 : ${e}");

                              // 서버가 열리지 않았다는 snackBar를 띄운다
                              Get.snackbar(
                                "서버 열리지 않음",
                                "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                duration: const Duration(seconds: 5),
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          }
                          // 사용자의 입력값이 올바르지 않았을 떄
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
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width.w / 3.3,
                            vertical: 20.h,
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 40.h,
                      ),
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
