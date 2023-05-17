import 'dart:async';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

class BanCheck {
  // 서버와 통신하기 위해 쓰는 변수
  static var dio = Dio();

  // 사용자가 앱을 사용하면서 ban됐는지 실시간으로 확인하는 변수
  static StreamSubscription<int>? monitorBan;

  // 사용자가 앱을 사용하면서 ban됐는지 실시간으로 확인하는 플래그
  static bool monitorBanFlag = false;

  // 실시간으로 사용자가 ban됐는지 체크하는 함수
  static Future<void> monitor() async {
    monitorBan = Stream.periodic(
      const Duration(seconds: 20),
      (x) => x,
    ).listen(
      (event) async {
        // 밴 됐는지 안됐는지 확인하는 메소드를 호출한다.
        try {
          final response = await dio.post(
            "http://${IpAddress.youngZoonIP}:8080/user/getInfo",
            // "http://${IpAddress.hyunukIP}:8080/user/getInfo",
            data: {
              "account": UserInfo.id,
            },
            options: Options(
              headers: {
                "Authorization": "Bearer ${UserInfo.token}",
              },
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
          );

          if (response.statusCode == 200) {
            print("서버와 통신 성공");
            print("서버에서 받아온 ban 정보 : ${response.data}");

            // response.data["ban"]이 null이 아닐 떄 
            if (response.data["ban"] != null) {
              DateTime currentTime = await NTP.now();
              currentTime = currentTime.toUtc().add(const Duration(hours: 9));

              // 현재 시간과 banUntilTime을 구해서 변수에 저장한다
              String nowTime = currentTime.toString().substring(0, 19);
              String banUntilTime =
                  "${response.data["ban"].toString().substring(0, 10)} ${response.data["ban"].toString().substring(11, 19)}";

              print("nowTime : $nowTime");
              print("banUntilTime : $banUntilTime");

              // banUntilTime >= nowTime일 떄 사용자가 ban됐다는 것을 알리고 로고인 페이지로 라우팅 하게 안내한다
              if (banUntilTime.compareTo(nowTime) >= 0) {
                print("사용자는 ban을 먹어야 합니다");
                // 스트림을 제거한다.
                await monitorBan!.cancel();

                // ban을 실시간으로 하는 모니터링 하고 있지 않음을 표현한다
                monitorBanFlag = false;

                // 사용자가 ban됐다는 것을 알리고, 로고인 페이지로 라우팅 하게끔 안내한다
                Get.dialog(
                  AlertDialog(
                    title: const Text("로고인 이동"),
                    content: SizedBox(
                      width: 100,
                      height: 150,
                      child: Column(
                        children: [
                          // 사용자 계정이 ban됐음을 알린다
                          const Text("사용자 계정이 ban 되었습니다"),

                          // 중간 공백
                          const SizedBox(height: 50),

                          // 로고인 페이지로 이동하는 버튼
                          TextButton(
                            child: const Text("로고인 페이지로 이동"),
                            onPressed: () {
                              // 아이디를 보여주는 다이어로그를 삭제한다.
                              Get.back();

                              // 로고인 페이지로 라우팅
                              Get.off(() => const LoginScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
              }
              //
              else {
                print("벤 안먹임");
              }
            } 
            // response.data["ban"]이 null일 떄 
            else {
              print("벤 안먹임");
            }
          }
          //
          else {
            print("서버와 통신 실패");
            print("서버 통신 에러 코드 : ${response.statusCode}");
            print("에러 메시지 : ${response.data}");
          }
        }
        // DioError[unknown]: null이 메시지로 나타났을 떄
        // 즉 서버가 열리지 않았다는 뜻이다
        catch (e) {
          print("서버가 열리지 않음");
        }
      },
    );
  }
}
