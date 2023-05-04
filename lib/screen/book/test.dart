// StatefulWidget - didUpdateWidget() 가 불러와지는지 테스트하기 위함
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    print("TestState init State 시작");
    super.initState();

    Timer.periodic(Duration(seconds: 2), (Timer timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    print("TestState dispose 시작");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("TestState build 시작");
    return MaterialApp(
      home: Test2(),
    );
  }
}

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  void initState() {
    print("TestState2 init State 시작");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Test2 oldWidget) {
    print("TestState2 didUpdateWidget 시작");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("TestState2 dispose 시작");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("TestState2 build 시작");
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("안녕하세요"),
        ),
      ),
    );
  }
}
