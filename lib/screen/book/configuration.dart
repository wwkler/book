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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child: Container(
        width: MediaQuery.of(context).size.width.w,
        height: MediaQuery.of(context).size.height.h,
        // 배경 이미지
        decoration: BoxDecoration(
          image: DecorationImage(
            image: UserInfo.identity == UserManagerCheck.user
                ? const AssetImage("assets/imgs/background_book1.jpg")
                : const AssetImage("assets/imgs/background_book2.jpg"),
            fit: BoxFit.fill,
            opacity: 0.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 중간 공백
              SizedBox(height: 50.h),

              // 환경 설정 Text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Card(
                    elevation: 10.0,
                    color: const Color.fromARGB(255, 228, 201, 232),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    child: SizedBox(
                      width: 250.w,
                      height: 40.h,
                      child: Center(
                        child: Text(
                          "환경 설정",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 중간 공백
              // const SizedBox(height: 50),

              // // 검색어 저장 켜기/끄기
              // GestureDetector(
              //   onTap: () {
              //     // 서버와 통신
              //     // 사용자에 대한 검색어 저장 켜기를 설정한다.
              //     // 사용자에 대한 검색어 저장 끄기를 설정한다.
              //   },
              //   child: Card(
              //     elevation: 10.0,
              //     color: const Color.fromARGB(255, 233, 227, 234),
              //     shadowColor: Colors.grey.withOpacity(0.5),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: SizedBox(
              //       width: 250,
              //       height: 50,
              //       child: Center(
              //         child: Text(
              //           isSaveSearch ? "검색어 저장 켜기" : "검색어 저장 끄기",
              //           style: const TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // // 중간 공백
              // const SizedBox(height: 50),

              // // 검색 기록 삭제
              // GestureDetector(
              //   onTap: () {
              //     // 서버와 통신
              //     // 서버에서 사용자에 대한 검색 기록을 삭제한다.
              //   },
              //   child: Card(
              //     elevation: 10.0,
              //     color: const Color.fromARGB(255, 233, 227, 234),
              //     shadowColor: Colors.grey.withOpacity(0.5),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: const SizedBox(
              //       width: 250,
              //       height: 50,
              //       child: Center(
              //         child: Text(
              //           "검색 기록 삭제",
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              // 중간 공백
              SizedBox(height: 50.h),

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
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                  child: SizedBox(
                    width: 250.w,
                    height: 50.h,
                    child: Center(
                      child: Text(
                        "내 정보 변경하기",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 중간 공백
              SizedBox(height: 50.h),

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
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                  child: SizedBox(
                    width: 250.w,
                    height: 50.h,
                    child: Center(
                      child: Text(
                        "로그아웃",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 중간 공백
              SizedBox(height: 50.h),

              // 회원 탈퇴 (사용자만 볼 수 있고, 관리자는 볼 수 없다)
              UserInfo.identity == UserManagerCheck.user
                  ? GestureDetector(
                      onTap: () async {
                        // 비밀번호를 입력하는 다이어로그를 띄운다.
                        Get.dialog(
                          AlertDialog(
                            title: const Text("회원 탈퇴"),
                            content: SizedBox(
                              width: 100.w,
                              height: 200.h,
                              child: Column(
                                children: [
                                  // 아이디를 보여주는 문구
                                  const Text("비밀번호를 입력해주세요"),

                                  // 중간 공백
                                  SizedBox(height: 10.h),

                                  // 비밀번호를 입력을 받는다.
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SizedBox(
                                        width: 50.w,
                                        height: 50.h,
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
                                              await BanCheck.monitorBan!
                                                  .cancel();

                                              // // ban을 실시간으로 하는 모니터링 하고 있지 않음을 표현한다
                                              BanCheck.monitorBanFlag = false;

                                              // 탈퇴 다이어로그를 삭제한다.
                                              Get.back();

                                              // 회원 탈퇴 했음을 snackBar로 띄운다
                                              Get.snackbar(
                                                "회원탈퇴 성공",
                                                "사용자 정보가 삭제되었습니다",
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );

                                              // 로고인 페이지로 라우팅
                                              Get.off(
                                                  () => const LoginScreen());
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
                                            duration:
                                                const Duration(seconds: 5),
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
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "회원 탈퇴",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.sp,
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
                  ? SizedBox(height: 50.h)
                  : SizedBox(height: 0.h),

              // 문의하기 (사용자만 볼 수 있고, 관리자는 볼 수 없다)
              UserInfo.identity == UserManagerCheck.user
                  ? GestureDetector(
                      onTap: () {
                        // 문의하기
                      },
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 233, 227, 234),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "문의하기",
                              style: TextStyle(
                                fontSize: 15.sp,
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
                  ? SizedBox(height: 50.h)
                  : SizedBox(height: 0.h),

              // 개인정보 보호 정책 (사용자만 볼 수 있고, 관리자는 볼 수 없다.)
              UserInfo.identity == UserManagerCheck.user
                  ? GestureDetector(
                      onTap: () {
                        // 개인정보 보호정책 dialog를 띄운다.
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
                                      // 개인정보 보호정책 text
                                      const Text(
                                          "아래의 개인정보 처리 방침은 BookMakase 개인이 서비스 하는 모든 제품에 적용 됩니다.\n"),

                                      const Text(
                                          "1. 개인정보의 처리 목적\nBookMakase 은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.\n"),

                                      const Text(
                                          "- 고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본신 식별 및 인증, 회원자격 유지 및 관리, 물품이나 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급 및 배송 등\n"),

                                      const Text(
                                          "2. 개인정보의 처리 및 보유 기간\n1) BookMakase 는 정보 주체로 부터 개인정보를 수집할 때 동의 받은 개인정보 보유 이용기간 또는 법령에 따른 개인정보 보유, 이용기간 내에서 개인정보를 처리 및 보유 합니다.\n2) 구체적인 개인정보 보유 기간은 다음과 같습니다.\n- 고객가입 및 관리 : 서비스 이용 계약 또는 회원가입 해지시 까지\n"),

                                      const Text(
                                          "3. 개인정보의 제3자 제공에 관한 사항\n1) BookMakase는 정보주체의 동의, 법률의 특별한 규정등 개인정보 보호법 제 17조 및 18조에 해당하는 경우에만 개인정보를 제 3자에게 제공합니다.\n2) BlockDMask 는 다음과 같이 개인정보를 제 3자에게 제공하고 있습니다.\n"),

                                      const Text(
                                          "- 제공받는 자의 개인정보 이용목적 : 다운받은 앱 사용시 수명주기와 발생 이벤트 등의 분석 및 통계용 (구글 애널리틱스), 정보주체별 맞춤광고 제공용(구글 애드몹)\n"),

                                      const Text(
                                          "- 제공받는 자의 보유, 이용기간 : 앱 설치시 부터 제품별 구글이 정한 기간에 따름\n- 제공받는 자의 제품별 개인정보처리방침 : 구글 개인정보 처리방침에 따름 (https://policies.google.com/privacy?hl=ko)\n"),

                                      const Text(
                                          "4. 개인정보처리 위탁\n① BookMakase 는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.\n1. <위탁없음.>\n- 위탁받는 자 (수탁자) : 없음.\n- 위탁하는 업무의 내용 : 없음.\n- 위탁기간 : 없음.\n"),

                                      const Text(
                                          "② BlockDMask 은(는) 위탁계약 체결시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.\n"),

                                      const Text(
                                          "③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.\n"),

                                      const Text(
                                          "5. 정보주체와 법정대리인의 권리·의무 및 그 행사방법 이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.\n① 정보주체는 BlockDMask 에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.\n1. 개인정보 열람요구\n2. 오류 등이 있을 경우 정정 요구\n3. 삭제요구\n4. 처리정지 요구\n"),

                                      const Text(
                                          "6. 처리하는 개인정보의 항목 작성\n① BookMakase 은(는) 다음의 개인정보 항목을 처리하고 있습니다.\n- 필수항목 : 없음.\n- 선택항목 : 없음.\n"),

                                      const Text(
                                          "7. 개인정보의 파기\nBookMakase는 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.\n-파기절차 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.\n-파기기한 이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.\n"),

                                      const Text(
                                          "8. 개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항\nBookMakase는 정보주체의 이용정보를 저장하고 수시로 불러오는 '쿠키'를 사용하지 않습니다.\n정보 주체가 제3자인 구글에게 제공하는 정보는 BlockDMask와 상관없이 정보 주체 기기상의 구글 설정에 따릅니다.\n"),

                                      const Text(
                                          "9. 개인정보 보호책임자 작성\n① BookMakase는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.\n▶ 개인정보 보호책임자 BookMakase (이메일 : BookMakase@gmail.com)\n"),

                                      const Text(
                                          "10. 개인정보 처리방침 변경\n①이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.\n\n"),

                                      const Text("2023.06.02. 최종 업데이트 됨."),

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
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 233, 227, 234),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "개인정보 보호 정책",
                              style: TextStyle(
                                fontSize: 15.sp,
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
                  ? SizedBox(height: 50.h)
                  : SizedBox(height: 0.h),

              // 오픈소스 라이선스 (사용자만 볼 수 있고, 관리자는 볼 수 없다.)
              UserInfo.identity == UserManagerCheck.user
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const LicensePage()));
                      },
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 233, 227, 234),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "오픈소스 라이선스",
                              style: TextStyle(
                                fontSize: 15.sp,
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
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "사용자 관리",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.sp,
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
                  ? SizedBox(height: 50.h)
                  : SizedBox(height: 0.h),

              // 신고 내역 (관리자만 볼 수 있고, 사용자는 볼 수 없다.)
              UserInfo.identity == UserManagerCheck.manager
                  ? GestureDetector(
                      onTap: () {
                        // 사용자 관리 페이지로 라우팅
                        Get.off(() => const ReportHistory());
                      },
                      child: Card(
                        elevation: 10.0,
                        color: const Color.fromARGB(255, 233, 227, 234),
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0.r),
                        ),
                        child: SizedBox(
                          width: 250.w,
                          height: 50.h,
                          child: Center(
                            child: Text(
                              "신고 내역",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15.sp,
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
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
