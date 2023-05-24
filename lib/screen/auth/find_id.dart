// 아이디를 찾기 위한 화면
import 'dart:math';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
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
    return WillPopScope(
      onWillPop: () async {
        // 뒤로 가기가 가능하다.
        return true;
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
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30.sp,
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
                        "BookMakase FindID Screen",
                        style: GoogleFonts.indieFlower(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.sp,
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
                            fontSize: 15.sp,
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 30.h,
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
                          ),
                        ),
                      ),

                      // 중간 공백
                      SizedBox(
                        height: 20.h,
                      ),

                      // 아이디 찾기 버튼
                      ElevatedButton(
                        onPressed: () async {
                          if (isEmailState == true) {
                            // 서버와 통신 시도
                            try {
                              final response = await dio.post(
                                'http://${IpAddress.hyunukIP}/Find/Account',
                                data: {
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
                                      width: 100.w,
                                      height: 150.h,
                                      child: Column(
                                        children: [
                                          // 아이디를 보여주는 문구
                                          Text(
                                              "회원님 아이디는\n${response.data}입니다."),

                                          // 중간 공백
                                          SizedBox(height: 50.h),

                                          // 로그인 페이지로 이동하는 버튼
                                          TextButton(
                                            child: const Text("로그인 페이지로 이동"),
                                            onPressed: () {
                                              // 아이디를 보여주는 다이어로그를 삭제한다.
                                              Get.back();

                                              // 로그인 페이지로 라우팅
                                              Get.offAll(
                                                  () => const LoginScreen());
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
                                print("메시지 : ${response.data}");

                                // 이메일을 찾을 수 없습니다
                                if (response.data == "이메일을 찾을수 없습니다") {
                                  Get.snackbar(
                                    "이메일 찾기 실패",
                                    "회원 가입시 입력했던 이메일이 적합하지 않습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                                // 그 외 메시지
                                else {
                                  Get.snackbar(
                                    "아이디 찾기 실패",
                                    "서버 통신 에러로 아이디 찾기가 실패하였습니다",
                                    duration: const Duration(seconds: 3),
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
                                duration: const Duration(seconds: 3),
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          }
                          // 사용자의 입력이 올바르지 않았을 떄
                          else {
                            Get.snackbar(
                              "이상 메시지",
                              "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                              duration: const Duration(seconds: 3),
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
                          "Find ID",
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
