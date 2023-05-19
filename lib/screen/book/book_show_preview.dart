// 도서 상세 정보 페이지
import 'dart:ui' as ui;
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_search_recommend.dart';
import 'package:book_project/screen/book/book_show_preview_edit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookShowPreview extends StatefulWidget {
  BookShowPreview({Key? key}) : super(key: key);

  @override
  State<BookShowPreview> createState() => _BookShowPreviewState();
}

class _BookShowPreviewState extends State<BookShowPreview> {
  // 도서 데이터
  BookModel? bookModel;

  // 도서 분야
  Map<int, String> category = {
    101: "국내도서>소설",
    102: "국내도서>시/에세이",
    103: "국내도서>예술/대중문화",
    104: "국내도서>사회과학",
    105: "국내도서>역사와 문화",
    107: "국내도서>잡지",
    108: "국내도서>만화",
    109: "국내도서>유아",
    110: "국내도서>아동",
    111: "국내도서>가정과 생활",
    112: "국내도서>청소년",
    113: "국내도서>초등학습서",
    114: "국내도서>고등학습서",
    115: "국내도서>국어/외국어/사전",
    116: "국내도서>자연과 과학",
    117: "국내도서>경제경영",
    118: "국내도서>자기계발",
    119: "국내도서>인문",
    120: "국내도서>종교/역학",
    122: "국내도서>컴퓨터/인터넷",
    123: "국내도서>자격서/수험서",
    124: "국내도서>취미/레저",
    125: "국내도서>전공도서/대학교재",
    126: "국내도서>건강/뷰티",
    128: "국내도서/여행",
    129: "국내도서>중등학습서",
  };

  // 도서 상세 정보 페이지 UI으로 보여주기 위한 변수, 배열
  final double _borderRadius = 24;
  var items = [
    PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
        'Dubai · In BurJuman', '...'),
  ];

  // 서버와 통신
  var dio = Dio();

  @override
  void initState() {
    print("Book Show Preview InitState 시작");
    super.initState();

    bookModel = Get.arguments;
    print("도서 작가 : ${bookModel!.author}");
    print("도서 분야 : ${bookModel!.categoryId}");
  }

  @override
  void dispose() {
    print("Book Show Preview state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("도서 분야 : ${bookModel!.categoryId}");
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                const SizedBox(height: 20),

                // 도서 상세 정보 Text
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
                            "도서 상세 정보",
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

                // 도서 상세 정보 UI
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      print("도서 구입 링크로 이동");
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 280,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                gradient: LinearGradient(
                                  colors: [
                                    items[1].startColor,
                                    items[1].endColor
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: items[1].endColor,
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                            ),

                            // Positioned(
                            //   right: 0,
                            //   bottom: 0,
                            //   top: 0,
                            //   child: CustomPaint(
                            //     size: const Size(100, 150),
                            //     painter: CustomCardShapePainter(
                            //       _borderRadius,
                            //       items[1].startColor,
                            //       items[1].endColor,
                            //     ),
                            //   ),
                            // ),
                            Positioned.fill(
                              child: Row(
                                children: [
                                  // 중간 공백
                                  const SizedBox(width: 10),
                                  // 도서 이미지
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      bookModel!.coverSmallUrl,
                                      width: 500,
                                      height: 300,
                                    ),
                                  ),

                                  // 중간 공백
                                  const SizedBox(width: 10),

                                  Expanded(
                                    flex: 2,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 도서 제목
                                            Text(
                                              bookModel!.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            // 중간 공백
                                            const SizedBox(height: 5),

                                            // 도서 작가 이름
                                            bookModel!.author != ""
                                                ? Text(
                                                    "${bookModel!.author} 작가",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Avenir',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(
                                                      "작가 이름이 없는 관계로 보여주지 않습니다.",
                                                    ),
                                                  ),

                                            // 중간 공백
                                            const SizedBox(height: 5),

                                            // 도서 분야
                                            bookModel!.categoryId != 0
                                                ? Text(
                                                    category[bookModel!
                                                            .categoryId]
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Avenir',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : const Visibility(
                                                    visible: false,
                                                    child: Text(
                                                      "도서 카테코리 번호가 없어서 보여주지 않습니다.",
                                                    ),
                                                  ),

                                            // 중간 공백
                                            const SizedBox(height: 5),

                                            // 도서 출판사
                                            Text(
                                              "${bookModel!.publisher} 출판사",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            // 중간 공백
                                            const SizedBox(height: 5),

                                            // 도서 출판일
                                            Text(
                                              "출판일 ${bookModel!.pubDate}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            // 중간 공백
                                            const SizedBox(height: 5),

                                            // 도서 가격
                                            Text(
                                              "${bookModel!.priceStandard}원",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                            // 중간 공백
                                            const SizedBox(height: 20),

                                            // 도서 설명
                                            Text(
                                              bookModel!.description,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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

                // 중간 공백
                const SizedBox(height: 10),

                // 찜하기, 도서 읽기 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 찜하기 버튼
                    ElevatedButton(
                      onPressed: () {
                        // 다이어로그
                        Get.dialog(
                          AlertDialog(
                            title: const Text("읽고 싶은 도서 추가"),
                            content: SizedBox(
                              width: 100,
                              height: 150,
                              child: Column(
                                children: [
                                  const Text("읽고 싶은 도서로 추가하시겠습니까?"),

                                  // 중간 공백
                                  const SizedBox(height: 50),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // 예
                                      TextButton(
                                        child: const Text("추가"),
                                        onPressed: () async {
                                          try {
                                            // 서버와 통신
                                            // 읽고 싶은 책 추가
                                            final response = await dio.put(
                                              "http://${IpAddress.hyunukIP}/bookshelves/addLike?memberId=${UserInfo.userValue}&bookId=${bookModel!.itemId}",
                                              options: Options(
                                                validateStatus: (_) => true,
                                                contentType:
                                                    Headers.jsonContentType,
                                                responseType: ResponseType.json,
                                              ),
                                            );

                                            if (response.statusCode == 200) {
                                              print("서버와 통신 성공");
                                              print(
                                                "찜하기를 통해 받은 데이터 : ${response.data}",
                                              );

                                              Get.snackbar(
                                                "찜하기 성공",
                                                "읽고 싶은 도서로 추가하였습니다",
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );

                                              //  다이어로그를 삭제한다.
                                              Get.back();

                                              // 도서 검색, 추천 페이지로 이동
                                              Get.off(() => BookFluidNavBar());
                                            }
                                            //
                                            else {
                                              print("서버와 통신 실패");
                                              print(
                                                  "서버 통신 에러 코드 : ${response.statusCode}");

                                              Get.snackbar(
                                                "찜하기 실패",
                                                "읽고 싶은 도서로 추가하지 못했습니다\n다시 한번 시도해주세요",
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                            }
                                          }
                                          // DioError[unknown]: null이 메시지로 나타났을 떄
                                          // 즉 서버가 열리지 않았다는 뜻이다
                                          catch (e) {
                                            Get.snackbar(
                                              "서버 열리지 않음",
                                              "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        },
                                      ),

                                      // 아니오
                                      TextButton(
                                        child: const Text("추가하지 않음"),
                                        onPressed: () {
                                          // 다이어로그를 삭제한다.
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "찜하기",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(width: 20),

                    // 도서 읽기 버튼
                    ElevatedButton(
                      onPressed: () {
                        // 다이어로그
                        Get.dialog(
                          AlertDialog(
                            title: const Text("읽고 있는 도서 추가"),
                            content: SizedBox(
                              width: 100,
                              height: 150,
                              child: Column(
                                children: [
                                  const Text("읽고 있는 도서로 추가하시겠습니까?"),

                                  // 중간 공백
                                  const SizedBox(height: 50),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // 예
                                      TextButton(
                                        child: const Text("추가"),
                                        onPressed: () async {
                                          try {
                                            // 서버와 통신
                                            // 사용자의 읽고 있는 책에 도서 추가
                                            final response = await dio.put(
                                              // totalPage는 자신이 직접 설정해야 한다. 도서의 페이지 수를 결정한다.
                                              "http://${IpAddress.hyunukIP}/bookshelves/addReading?memberId=${UserInfo.userValue}&bookId=${bookModel!.itemId}&totalPage=100",
                                              options: Options(
                                                validateStatus: (_) => true,
                                                contentType:
                                                    Headers.jsonContentType,
                                                responseType: ResponseType.json,
                                              ),
                                            );

                                            if (response.statusCode == 200) {
                                              print("서버와 통신 성공");
                                              print(
                                                  "읽고 있는 도서를 통해 받은 데이터 : ${response.data}");

                                              Get.snackbar(
                                                "읽고 있는 도서 성공",
                                                "읽고 있는도서로 추가하였습니다",
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );

                                              //  다이어로그를 삭제한다.
                                              Get.back();

                                              // 도서 검색, 추천 페이지로 이동 (라우팅)
                                              Get.off(() => BookFluidNavBar());
                                            }
                                            //
                                            else {
                                              print("서버와 통신 실패");
                                              print(
                                                  "서버 통신 에러 코드 : ${response.statusCode}");

                                              Get.snackbar(
                                                "읽고 있는 도서 추가 실패",
                                                "읽고 있는 도서로 추가하지 못했습니다\n다시 한번 시도해주세요",
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                            }
                                          }
                                          // DioError[unknown]: null이 메시지로 나타났을 떄
                                          // 즉 서버가 열리지 않았다는 뜻이다
                                          catch (e) {
                                            Get.snackbar(
                                              "서버 열리지 않음",
                                              "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        },
                                      ),

                                      // 아니오
                                      TextButton(
                                        child: const Text("추가하지 않음"),
                                        onPressed: () {
                                          // 다이어로그를 삭제한다.
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "도서 읽기",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),

                // 중간 공백
                const SizedBox(height: 20),

                // 도서 상세 정보 수정(관리자 권한)
                UserInfo.identity == UserManagerCheck.manager
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // 도서 정보를 수정할 수 있도록 제공한다.
                            Get.off(() => BookShowPreviewEdit());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 20,
                            ),
                          ),
                          child: const Text(
                            "정보 수정하기 (관리자 권한)",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                    : const Visibility(
                        visible: false,
                        child: Text("버튼이 보이지 않습니다."),
                      ),

                // 중간 공백
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 도서 상세 정보 페이지 UI으로 보여주기 위한 클래스 1
class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

// 도서 상세 정보 페이지 UI으로 보여주기 위한 클래스 2
class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// 도서 상세 정보 페이지 UI으로 보여주기 위한 클래스 3
class RatingBar extends StatelessWidget {
  final double rating;

  const RatingBar({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rating.floor(), (index) {
        return const Icon(
          Icons.star,
          color: Colors.white,
          size: 16,
        );
      }),
    );
  }
}
