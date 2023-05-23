// 임시 비밀번호 제공 페이지
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

class FindPasswordScreen extends StatefulWidget {
  FindPasswordScreen({Key? key}) : super(key: key);

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  // id
  String id = "";
  bool isIdState = false;

  // 이메일
  String email = "";
  bool isEmailState = false;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
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

                      // BookMakase Find Password Text
                      Text(
                        "BookMakase\n Find Password Screen",
                        style: GoogleFonts.indieFlower(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                        ),
                      ),

                      // Please Find Password to continue using our app Text
                      Text(
                        "Please Find Password to continue using our app",
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
                            } else if (value.length < 6 || value.length > 13) {
                              isIdState = false;
                              return "6자리 이상 12자리 이하를 입력해주세요";
                            } else {
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
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "이메일 주소",
                            hintText: 'ex) abcdef@naver.com',
                            labelStyle: const TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 15.h,
                      ),

                      // 비밀번호 변경 버튼
                      ElevatedButton(
                        onPressed: () async {
                          if (isIdState == true && isEmailState == true) {
                            // 서버와 통신 시도
                            try {
                              final response = await dio.post(
                                'http://${IpAddress.hyunukIP}/Find/PWD',
                                data: {
                                  // 사용자 아이디(string)
                                  'account': id,

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
                              // 임시 비밀번호를 발급한다
                              if (response.statusCode == 200) {
                                print("서버와 통신 성공");
                                print("서버에서 제공해주는 데이터 : ${response.data}");

                                Get.dialog(
                                  AlertDialog(
                                    title: const Text("임시 비밀번호 발급"),
                                    content: SizedBox(
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        children: [
                                          // 임시 비밀번호를 보여주는 문구
                                          const Text(
                                            "임시 비밀번호는 이메일에서 확인하세요",
                                          ),

                                          // 중간 공백
                                          SizedBox(height: 25.h),

                                          // 로고인 페이지로 이동하는 버튼
                                          TextButton(
                                            child: const Text("로고인 페이지로 이동"),
                                            onPressed: () {
                                              // 아이디를 보여주는 다이어로그를 삭제한다.
                                              Get.back();

                                              // 비밀번호 변경 페이지에서 벗어나 로고인 페이지로 라우팅한다.
                                              Get.off(
                                                  () => const LoginScreen());
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // 서버 통신 실패
                              else {
                                print("서버와 통신 실패");
                                print("서버 통신 실패 코드 : ${response.statusCode}");
                                print("메시지 : ${response.data}");

                                //이메일 또는 계정을 찾을수 없습니다.
                                if (response.data == "이메일 또는 계정을 찾을수 없습니다.") {
                                  Get.snackbar(
                                    "이메일 또는 계정 찾기 실패",
                                    "이메일 또는 계정을 다시 입력해주세요",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                                // 나머지 외
                                else {
                                  Get.snackbar(
                                    "임시 비밀번호 발급 실패",
                                    "서버 통신 에러로\n임시 비밀번호 발급이 실패하였습니다",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
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
                          // 사용자가 입력값을 적합하지 않게 했을 떄
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
                            horizontal: 40.w,
                            vertical: 20.h,
                          ),
                        ),
                        child: Text(
                          "임시 비밀번호 발급",
                          style: TextStyle(fontSize: 15.sp),
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
