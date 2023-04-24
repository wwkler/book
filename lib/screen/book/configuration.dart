// 환경 설정 페이지
import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {
  Configuration({Key? key}) : super(key: key);

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      print("Configuration InitState 시작");
      super.initState();
    }

    @override
    void dispose() {
      print("Configuration dispose 시작");
      super.dispose();
    }

    return Container(
      // 배경 이미지
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/background_book1.jpg"),
          fit: BoxFit.fill,
          opacity: 0.3,
        ),
      ),

      child: Center(
        child: Text("Configuration Page"),
      ),
    );
  }
}
