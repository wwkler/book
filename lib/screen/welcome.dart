// 아이디, 비밀번호를 입력하는 로그인 화면
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 중간 공백
              const SizedBox(
                height: 20,
              ),

              Lottie.network(
                'https://assets1.lottiefiles.com/packages/lf20_1pxqjqps.json',
                height: 300,
                width: 600,
              ),

              // Welcome Text
              const Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),

              Expanded(
                flex: 0,
                child: Text(
                  'Login to your account and access our wonderful app',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w300,
                      // height: 1.5,
                      fontSize: 15),
                ),
              ),

              // 중간 공백
              const SizedBox(
                height: 135,
              ),

              // 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.3,
                      vertical: 20),
                ),
                onPressed: () {
                  print("버튼을 클릭했습니다.");
                },
                child: const Text(
                  'Sounds Good!',
                  style: TextStyle(fontSize: 17),
                ),
              ),

              // Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have\'t any account?',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("버튼을 클릭했습니다.");
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
