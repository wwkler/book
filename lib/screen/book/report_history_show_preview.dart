// 신고 내역을 자세하게 보여주는 페이지
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/configuration.dart';
import 'package:book_project/screen/book/report_history.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportHistoryShowPreview extends StatefulWidget {
  const ReportHistoryShowPreview({super.key});

  @override
  State<ReportHistoryShowPreview> createState() =>
      _ReportHistoryShowPreviewState();
}

class _ReportHistoryShowPreviewState extends State<ReportHistoryShowPreview> {
  // 신고 당한 사용자의 데이터
  Map<String, dynamic>? report;

  // 서버를 사용하는 변수
  var dio = Dio();

  @override
  void initState() {
    print("ReportHistoryShowPreview initState 시작");
    super.initState();
    report = Get.arguments;
    print("report : $report");
  }

  @override
  void dispose() {
    print("ReportHistoryShowPreview state 종료");
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
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width.w,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이전 페이지 아이콘
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),

                    // 중간 공백
                    SizedBox(height: 10.h),

                    // 신고 내역 상세 보기 Text
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
                                "신고 내역 상세 보기",
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
                    SizedBox(height: 20.h),

                    // 신고 내역 상세 보기 목록
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        elevation: 10.0,
                        color: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        child: SizedBox(
                          width: 350.w,
                          height: 600.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 신고 대상 리뷰 제목
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고 리뷰 제목 : ${report!["review"]["title"]}",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 신고 대상 리뷰 작성자 아이디
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고 리뷰 작성자 아이디 : ${report!["review"]["member"]["account"]}",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 신고 대상 리뷰 작성자 이름
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고 리뷰 작성자 이름 : ${report!["review"]["member"]["name"]}",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 신고 대상 리뷰 내용
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    report!["review"]["content"],
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // 중간 공백
                                SizedBox(height: 50.h),

                                // 신고하는 사람 이름
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고자명 : ${report!["member"]["name"]}",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 신고하는 날짜
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고 날짜 : ${report!["createdAt"].toString().substring(0, 10)}",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 신고하는 사유
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                    ),
                                    child: SizedBox(
                                      width: 350.w,
                                      height: 40.h,
                                      child: Center(
                                        child: Text(
                                          "신고 사유 : ${report!["reason"]}",
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
                                SizedBox(height: 30.h),

                                // 신고하는 내용
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    report!["content"],
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // 중간 공백
                                SizedBox(height: 200.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // 중간 공백
                    SizedBox(height: 20.h),

                    // 넘어가기, 경고, 재재 버튼
                    SizedBox(
                      width: MediaQuery.of(context).size.width.w,
                      height: 100.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 넘어가기 버튼
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final response = await dio.post(
                                  "http://${IpAddress.hyunukIP}/reviews/reportProcess?reportId=${report!["id"]}&process=0",
                                  options: Options(
                                    headers: {
                                      "Authorization":
                                          "Bearer ${UserInfo.token}",
                                    },
                                    validateStatus: (_) => true,
                                    contentType: Headers.jsonContentType,
                                    responseType: ResponseType.json,
                                  ),
                                );

                                if (response.statusCode == 200) {
                                  print("서버와 통신 성공");
                                  print("서버에서 받아온 데이터 : ${response.data}");

                                  // 넘어가기 snackBar를 띄운다
                                  Get.snackbar(
                                    "넘어가기 반영 완료",
                                    "신고 리뷰에 대해서 넘어가기 하였습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );

                                  // configuration 페이지로 라우팅
                                  Get.offAll(() => BookFluidNavBar(
                                      route: Configuration(), routeIndex: 4));
                                }
                                //
                                else {
                                  print("서버와 통신 실패");
                                  print("서버 통신 에러 코드 : ${response.statusCode}");

                                  // 넘어가기 반영 실패 snackBar를 띄운다
                                  Get.snackbar(
                                    "넘어가기 반영 실패",
                                    "신고 리뷰에 대해서 넘어가기 반영 실패 하였습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              }
                              // DioError[unknown]: null이 메시지로 나타났을 떄
                              // 즉 서버가 열리지 않았다는 뜻이다
                              catch (e) {
                                Get.snackbar(
                                  "서버가 열리지 않음",
                                  "서버가 열리지 않았습니다",
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
                                horizontal: 30.w,
                                vertical: 15.h,
                              ),
                            ),
                            child: Text(
                              "넘어가기",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),

                          // 경고 버튼
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final response = await dio.post(
                                  "http://${IpAddress.hyunukIP}/reviews/reportProcess?reportId=${report!["id"]}&process=1",
                                  options: Options(
                                    headers: {
                                      "Authorization":
                                          "Bearer ${UserInfo.token}",
                                    },
                                    validateStatus: (_) => true,
                                    contentType: Headers.jsonContentType,
                                    responseType: ResponseType.json,
                                  ),
                                );

                                if (response.statusCode == 200) {
                                  print("서버와 통신 성공");
                                  print("서버에서 받아온 데이터 : ${response.data}");

                                  // 경고 snackBar를 띄운다
                                  Get.snackbar(
                                    "경고 반영 완료",
                                    "신고 리뷰에 대해서 경고하였습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );

                                  // configuration 페이지로 라우팅
                                  Get.offAll(() => BookFluidNavBar(
                                      route: Configuration(), routeIndex: 4));
                                }
                                //
                                else {
                                  print("서버와 통신 실패");
                                  print("서버 통신 에러 코드 : ${response.statusCode}");

                                  // 경고 반영 실패 snackBar를 띄운다
                                  Get.snackbar(
                                    "경고 반영 실패",
                                    "신고 리뷰에 대해서 경고 반영 실패하였습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              }
                              // DioError[unknown]: null이 메시지로 나타났을 떄
                              // 즉 서버가 열리지 않았다는 뜻이다
                              catch (e) {
                                Get.snackbar(
                                  "서버가 열리지 않음",
                                  "서버가 열리지 않았습니다",
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
                                horizontal: 30.w,
                                vertical: 15.h,
                              ),
                            ),
                            child: Text(
                              "경고",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),

                          // 영구정지 버튼
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                final response = await dio.post(
                                  "http://${IpAddress.hyunukIP}/reviews/reportProcess?reportId=${report!["id"]}&process=2",
                                  options: Options(
                                    headers: {
                                      "Authorization":
                                          "Bearer ${UserInfo.token}",
                                    },
                                    validateStatus: (_) => true,
                                    contentType: Headers.jsonContentType,
                                    responseType: ResponseType.json,
                                  ),
                                );

                                if (response.statusCode == 200) {
                                  print("서버와 통신 성공");
                                  print("서버에서 받아온 데이터 : ${response.data}");

                                  // 영구정지 snackBar를 띄운다
                                  Get.snackbar(
                                    "영구정지 반영 완료",
                                    "신고 리뷰에 대해서 영구정지 하였습니다",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );

                                  // configuration 페이지로 라우팅
                                  Get.offAll(() => BookFluidNavBar(
                                      route: Configuration(), routeIndex: 4));
                                }
                                //
                                else {
                                  print("서버와 통신 실패");
                                  print("서버 통신 에러 코드 : ${response.statusCode}");

                                  // 영구정지 반영 실패 snackBar를 띄운다
                                  Get.snackbar(
                                    "영구정지 반영 실패",
                                    "신고 리뷰에 대해서 영구정지 반영 실패",
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              }
                              // DioError[unknown]: null이 메시지로 나타났을 떄
                              // 즉 서버가 열리지 않았다는 뜻이다
                              catch (e) {
                                Get.snackbar(
                                  "서버가 열리지 않음",
                                  "서버가 열리지 않았습니다",
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
                                horizontal: 30.w,
                                vertical: 15.h,
                              ),
                            ),
                            child: Text(
                              "영구정지",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
