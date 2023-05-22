// 환경 설정 페이지
import 'package:book_project/const/ban_check.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/my_page.dart';
import 'package:book_project/screen/book/report_history.dart';
import 'package:book_project/screen/book/user_management.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Configuration extends StatefulWidget {
  Configuration({Key? key}) : super(key: key);

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  // 비밀번호를 입력받는 textEditor
  final inputPasswordController = TextEditingController();

  // 검색어 저장 켜기, 끄기 변수
  bool isSaveSearch = true;

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    print("Configuration InitState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Configuration state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // 배경 이미지
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/background_book1.jpg"),
          fit: BoxFit.fill,
          opacity: 0.3,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 중간 공백
            const SizedBox(height: 50),

            // 환경 설정 Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Card(
                  elevation: 10.0,
                  color: const Color.fromARGB(255, 228, 201, 232),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const SizedBox(
                    width: 250,
                    height: 40,
                    child: Center(
                      child: Text(
                        "환경 설정",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중간 공백
            const SizedBox(height: 50),

            // 검색어 저장 켜기/끄기
            GestureDetector(
              onTap: () {
                // 서버와 통신
                // 사용자에 대한 검색어 저장 켜기를 설정한다.
                // 사용자에 대한 검색어 저장 끄기를 설정한다.
              },
              child: Card(
                elevation: 10.0,
                color: const Color.fromARGB(255, 233, 227, 234),
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                      isSaveSearch ? "검색어 저장 켜기" : "검색어 저장 끄기",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중간 공백
            const SizedBox(height: 50),

            // 검색 기록 삭제
            GestureDetector(
              onTap: () {
                // 서버와 통신
                // 서버에서 사용자에 대한 검색 기록을 삭제한다.
              },
              child: Card(
                elevation: 10.0,
                color: const Color.fromARGB(255, 233, 227, 234),
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const SizedBox(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                      "검색 기록 삭제",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중간 공백
            const SizedBox(height: 50),

            // 내 정보 변경하기
            GestureDetector(
              onTap: () {
                // 내 정보 변경하기 페이지로 라우팅
                Get.off(() => const MyPage());
              },
              child: Card(
                elevation: 10.0,
                color: const Color.fromARGB(255, 233, 227, 234),
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const SizedBox(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                      "내 정보 변경하기",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중간 공백
            const SizedBox(height: 50),

            // 로그아웃
            GestureDetector(
              onTap: () async {
                // 사용자 일 떄
                if (UserInfo.identity == UserManagerCheck.user) {
                  // ban을 실시간으로 하는 모니터링 하는 것을 중단한다
                  await BanCheck.monitorBan!.cancel();

                  // // ban을 실시간으로 하는 모니터링 하고 있지 않음을 표현한다
                  BanCheck.monitorBanFlag = false;
                }

                // user_info.dart에 있는 정보 초기화
                UserInfo.identity = null;
                UserInfo.userValue = null;
                UserInfo.id = null;
                // UserInfo.password = null;
                UserInfo.name = null;
                UserInfo.age = null;
                UserInfo.selectedCode = null;
                UserInfo.email = null;

                // 로그아웃 snackBar를 보여준다
                Get.snackbar(
                  "로그아웃",
                  "로그아웃을 하였습니다",
                  duration: const Duration(seconds: 5),
                  snackPosition: SnackPosition.TOP,
                );

                // 로그아웃
                Get.off(() => const LoginScreen());
              },
              child: Card(
                elevation: 10.0,
                color: const Color.fromARGB(255, 233, 227, 234),
                shadowColor: Colors.grey.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const SizedBox(
                  width: 250,
                  height: 50,
                  child: Center(
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중간 공백
            const SizedBox(height: 50),

            // 회원 탈퇴 (사용자만 볼 수 있고, 관리자는 볼 수 없다)
            UserInfo.identity == UserManagerCheck.user
                ? GestureDetector(
                    onTap: () async {
                      // 비밀번호를 입력하는 다이어로그를 띄운다.
                      Get.dialog(
                        AlertDialog(
                          title: const Text("회원 탈퇴"),
                          content: SizedBox(
                            width: 100,
                            height: 200,
                            child: Column(
                              children: [
                                // 아이디를 보여주는 문구
                                const Text("비밀번호를 입력해주세요"),

                                // 중간 공백
                                const SizedBox(height: 10),

                                // 비밀번호를 입력을 받는다.
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: TextField(
                                        controller: inputPasswordController,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                                // 로고인 페이지로 이동하는 버튼
                                TextButton(
                                  child: const Text("클릭"),
                                  onPressed: () async {
                                    if (inputPasswordController.text != "") {
                                      try {
                                        // 다이어로그에 있는 버튼을 누르면 서버와 통신을 한다.
                                        final response = await dio.post(
                                          'http://${IpAddress.hyunukIP}/withdrawMember',
                                          data: {
                                            // 계정
                                            'account': UserInfo.id,
                                            // 비밀번호
                                            'password':
                                                inputPasswordController.text,
                                          },
                                          options: Options(
                                            headers: {
                                              "Authorization":
                                                  "Bearer ${UserInfo.token}",
                                            },
                                            validateStatus: (_) => true,
                                            contentType:
                                                Headers.jsonContentType,
                                            responseType: ResponseType.json,
                                          ),
                                        );

                                        // 서버와 통신 성공
                                        if (response.statusCode == 200) {
                                          print("서버와 통신 성공");
                                          print(
                                              "서버에서 제공해주는 데이터 : ${response.data}");

                                          // 서버에서 받은 데이터가 true면 회원 탈퇴 임을 알리고 로고인 페이지로 이동시킨다.
                                          if (response.data == true) {
                                            print("회원 탈퇴 되었습니다.");

                                            // ban을 실시간으로 하는 모니터링 하는 것을 중단한다
                                            await BanCheck.monitorBan!.cancel();

                                            // // ban을 실시간으로 하는 모니터링 하고 있지 않음을 표현한다
                                            BanCheck.monitorBanFlag = false;

                                            // 회원 탈퇴 했음을 snackBar로 띄운다
                                            Get.snackbar(
                                              "회원탈퇴 성공",
                                              "사용자 정보가 삭제되었습니다",
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition: SnackPosition.TOP,
                                            );

                                            // 아이디를 보여주는 다이어로그를 삭제한다.
                                            Get.back();

                                            // 로고인 페이지로 라우팅
                                            Get.off(() => const LoginScreen());
                                          }
                                        }
                                        //
                                        else {
                                          // 탈퇴 다이어로그를 제거한다.
                                          Get.back();

                                          Get.snackbar(
                                            "회원탈퇴 반영 실패",
                                            "사용자 정보가 삭제되지 않았습니다",
                                            duration:
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      }
                                      // DioError[unknown]: null이 메시지로 나타났을 떄
                                      // 즉 서버가 열리지 않았다는 뜻이다
                                      catch (e) {
                                        Get.back();

                                        // 서버가 열리지 않았다는 snackBar를 띄운다
                                        Get.snackbar(
                                          "서버 열리지 않음",
                                          "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                          duration: const Duration(seconds: 5),
                                          snackPosition: SnackPosition.TOP,
                                        );
                                      }
                                    }
                                    //
                                    else {
                                      Get.back();

                                      Get.snackbar(
                                        "이상 메시지",
                                        "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                        duration: const Duration(seconds: 5),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "회원 탈퇴",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다."),
                  ),

            // 중간 공백
            UserInfo.identity == UserManagerCheck.user
                ? const SizedBox(height: 50)
                : const SizedBox(height: 0),

            // 문의하기 (사용자만 볼 수 있고, 관리자는 볼 수 없다)
            UserInfo.identity == UserManagerCheck.user
                ? GestureDetector(
                    onTap: () {
                      // 내 정보 변경하기 페이지로 라우팅
                    },
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "문의하기",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다"),
                  ),

            // 중간 공백
            UserInfo.identity == UserManagerCheck.user
                ? const SizedBox(height: 50)
                : const SizedBox(height: 0),

            // 개인정보 보호 정책 (사용자만 볼 수 있고, 관리자는 볼 수 없다.)
            UserInfo.identity == UserManagerCheck.user
                ? GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "개인정보 보호 정책",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다"),
                  ),

            // 중간 공백
            UserInfo.identity == UserManagerCheck.user
                ? const SizedBox(height: 50)
                : const SizedBox(height: 0),

            // 오픈소스 라이선스 (사용자만 볼 수 있고, 관리자는 볼 수 없다.)
            UserInfo.identity == UserManagerCheck.user
                ? GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "오픈소스 라이선스",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다"),
                  ),

            // 사용자 관리 (관리자만 볼 수 있고, 사용자는 볼 수 없다.)
            UserInfo.identity == UserManagerCheck.manager
                ? GestureDetector(
                    onTap: () {
                      // 사용자 관리 페이지로 라우팅
                      Get.off(() => UserManagement());
                    },
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "사용자 관리",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다"),
                  ),

            // 중간 공백
            UserInfo.identity == UserManagerCheck.manager
                ? const SizedBox(height: 50)
                : const SizedBox(height: 0),

            // 신고 내역 (관리자만 볼 수 있고, 사용자는 볼 수 없다.)
            UserInfo.identity == UserManagerCheck.manager
                ? GestureDetector(
                    onTap: () {
                      // 사용자 관리 페이지로 라우팅
                      Get.off(() => ReportHistory());
                    },
                    child: Card(
                      elevation: 10.0,
                      color: const Color.fromARGB(255, 233, 227, 234),
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const SizedBox(
                        width: 250,
                        height: 50,
                        child: Center(
                          child: Text(
                            "신고 내역",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const Visibility(
                    visible: false,
                    child: Text("버튼은 보이지 않습니다"),
                  ),

            // 중간 공백
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
