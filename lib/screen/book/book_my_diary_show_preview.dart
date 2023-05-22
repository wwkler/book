import 'dart:io';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/screen/auth/login.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 도서 일지 상세 정보 페이지
class BookMyDiaryShowPreview extends StatefulWidget {
  const BookMyDiaryShowPreview({super.key});

  @override
  State<BookMyDiaryShowPreview> createState() => _BookMyDiaryShowPreviewState();
}

class _BookMyDiaryShowPreviewState extends State<BookMyDiaryShowPreview> {
  // 도서 일지 상세 데이터
  Map<String, dynamic>? diary;

  // 서버를 사용하는 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book My Diary Show Preview initState 시작");
    super.initState();
    diary = Get.arguments;

    print("diary : $diary");
  }

  @override
  void dispose() {
    print("Book My Diary Show Preview state 종료");
    super.dispose();
  }

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

                  // 일지 상세 보기 Text
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
                              "일지 상세 보기",
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

                  // 작성한 일지 목록
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 도서 제목, 일지 작성 날짜, 도서 일지 감상평, 도서 이미지
                              Row(
                                children: [
                                  // 도서 제목, 일지 작성 날짜, 도서 일지 감상평
                                  Column(
                                    children: [
                                      // 도서 제목
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                diary!["title"].toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // 일지 작성 날짜
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                diary!["date"],
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // 도서 일지 감상평
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          elevation: 5.0,
                                          color: Colors.blue[50],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: const SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: Center(
                                              child: Text(
                                                "도서 일지 감상평",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // 도서 이미지
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      diary!["book"]["coverSmallUrl"],
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                ],
                              ),

                              // 중간 공백
                              const SizedBox(height: 30),

                              // 일지 이미지
                              diary!["image"] != ""
                                  ? Container(
                                      padding: const EdgeInsets.all(.0),
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Image.file(
                                        File(diary!["image"]),
                                        width: 200,
                                        height: 200,
                                      ),
                                    )
                                  : const Visibility(
                                      visible: false,
                                      child: Text(
                                          "카메라 이미지를 추가하지 않았습니다. 따라서 이미지를 보여주지 않습니다."),
                                    ),

                              // 중간 공백
                              const SizedBox(height: 30),

                              // 일지 감상평
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  diary!["content"],
                                  style: const TextStyle(
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
                  ),

                  // 중간 공백
                  const SizedBox(height: 50),

                  // 삭제하기 버튼
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 삭제 다이어로그를 띄운다
                        Get.dialog(
                          AlertDialog(
                            title: const Text("일지 삭제"),
                            content: SizedBox(
                              width: 100,
                              height: 150,
                              child: Column(
                                children: [
                                  // 해당 일지를 삭제하시겠습니까?
                                  const Text("해당 일지를 삭제하시겠습니까?"),

                                  // 중간 공백
                                  const SizedBox(height: 50),

                                  // 일지 삭제
                                  TextButton(
                                    child: const Text("일지 삭제"),
                                    onPressed: () async {
                                      // 사용자가 작성한 일지 데이터를 가져온다
                                      try {
                                        final response = await dio.delete(
                                          "http://${IpAddress.hyunukIP}/journals/delete?id=${diary!["id"]}",
                                          options: Options(
                                            validateStatus: (_) => true,
                                            contentType:
                                                Headers.jsonContentType,
                                            responseType: ResponseType.json,
                                          ),
                                        );

                                        // 서버와 통신 성공
                                        // 회원 정보를 데이터베이스에 등록한다.
                                        if (response.statusCode == 200) {
                                          print("서버와 통신 성공");
                                          print(
                                              "서버에서 제공해주는 데이터 : ${response.data}");

                                          // 일지 삭제를 보여주는 다이어로그를 삭제한다.
                                          Get.back();

                                          // 일지 삭제 snackBar를 띄운다
                                          Get.snackbar(
                                            "일지 삭제 성공",
                                            "일지 삭제 반영이 성공하였습니다",
                                            duration:
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.TOP,
                                          );

                                          // 페이지 라우팅
                                          Get.off(() => BookFluidNavBar());
                                        }
                                        // 서버와 통신 실패
                                        else {
                                          print("서버와 통신 실패");
                                          print(
                                              "서버 통신 에러 코드 : ${response.statusCode}");
 
                                          // 일지 삭제를 보여주는 다이어로그를 삭제한다.
                                          Get.back();

                                          // 일지 삭제 실패 snackBar를 띄운다
                                          Get.snackbar(
                                            "일지 삭제 실패",
                                            "일지 삭제 반영이 실패하였습니다",
                                            duration:
                                                const Duration(seconds: 5),
                                            snackPosition: SnackPosition.TOP,
                                          );
                                        }
                                      }
                                      // DioError[unknown]: null이 메시지로 나타났을 떄
                                      // 즉 서버가 열리지 않았다는 뜻이다
                                      catch (e) {
                                        // 서버가 열리지 않음 snackBar를 띄운다
                                        Get.snackbar(
                                          "서버가 열리지 않음",
                                          "서버가 열리지 않음\n관리자에게 문의해주세요",
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
                          barrierDismissible: true,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text(
                            "삭제하기",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 중간 공백
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
