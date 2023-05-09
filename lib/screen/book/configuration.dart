// 환경 설정 페이지
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/my_page.dart';
import 'package:book_project/screen/book/report_history.dart';
import 'package:book_project/screen/book/user_management.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Configuration extends StatefulWidget {
  Configuration({Key? key}) : super(key: key);

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  // 검색어 저장 켜기, 끄기 변수
  bool isSaveSearch = true;

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
                Get.off(() => MyPage());
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
              onTap: () {
                // user_info.dart에 있는 정보 초기화
                UserInfo.identity = null;
                UserInfo.userValue = null;
                UserInfo.id = null;
                // UserInfo.password = null;
                UserInfo.name = null;
                UserInfo.age = null;
                UserInfo.selectedCode = null;
                UserInfo.email = null;

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
                    onTap: () {
                      // 서버와 통신
                      // 사용자 정보를 삭제한다.
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
