// 신고 내역을 자세하게 보여주는 페이지
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ReportHistoryShowPreview extends StatefulWidget {
  const ReportHistoryShowPreview({super.key});

  @override
  State<ReportHistoryShowPreview> createState() =>
      _ReportHistoryShowPreviewState();
}

class _ReportHistoryShowPreviewState extends State<ReportHistoryShowPreview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // 배경 이미지
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/background_book1.jpg"),
                fit: BoxFit.fill,
                opacity: 0.3,
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
                      Get.off(() => BookFluidNavBar());
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(height: 10),

                  // 신고 내역 상세 보기 Text
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
                              "신고 내역 상세 보기",
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
                  const SizedBox(height: 20),

                  // 신고 내역 상세 보기 목록
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.white,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: SizedBox(
                        width: 350,
                        height: 600,
                        // 사용자명, 아이디, 신고 날짜, 신고 사유, 내용
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 사용자명, 아이디
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 350,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "사용자명 : 김영우(lakrista)",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 신고 날짜
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 350,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "신고 날짜 : 2023-04-21",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 신고 사유
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const SizedBox(
                                  width: 350,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "신고 사유 : 스팸/광고성",
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
                            const SizedBox(height: 30),

                            // 일지 감상평
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "너무 스팸/광고성 리뷰를 작성해서 이런 이유로 신고합니다",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(height: 20),

                  // 정지, 탈퇴 버튼
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 정지 버튼
                        ElevatedButton(
                          onPressed: () {
                            // 서버와 통신
                            // 사용자 계정을 정지한다.
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            "정지",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),

                        // 탈퇴 버튼
                        ElevatedButton(
                          onPressed: () {
                            // 서버와 통신
                            // 사용자 계정을 탈퇴한다.
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            "탈퇴",
                            style: TextStyle(fontSize: 12),
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
    );
  }
}
