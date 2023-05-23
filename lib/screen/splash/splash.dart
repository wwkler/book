// 앱의 스플래시 화면
import 'dart:async';
import 'package:book_project/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print("Splash initState 시작");
    super.initState();

    // 10초후 LoginPage로 이동한다.
    Timer(const Duration(seconds: 10), () {
      // SplashScreen과 SplashScreenState를 모두 삭제하고 LoginPage로 이동한다.
      Get.off(() => const LoginScreen());
    });
  }

  // SpalshScreen과 SplashScreenState가 모두 삭제됐으면 deactivate 함수에 이어 dispose 함수가 불려진다.
  @override
  void dispose() {
    print("Splash state 종료");
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
          backgroundColor: Colors.white,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 중간 여백
                  const SizedBox(
                    height: 50,
                  ),

                  // 앱의 splash 로고 이미지
                  Image.asset(
                    'assets/imgs/splash1.png',
                    height: 120,
                  ),

                  // 중간 여백
                  const SizedBox(
                    height: 50,
                  ),

                  // 앱의 제목
                  Text(
                    "BookMakase",
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),

                  // 중간 여백
                  const SizedBox(
                    height: 100,
                  ),

                  // ProgressIndicator
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),

                  // 중간 여백
                  const SizedBox(
                    height: 25,
                  ),

                  // 로딩 중입니다 메시지
                  Text(
                    'Loding... Please Wait a second',
                    style: GoogleFonts.indieFlower(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
