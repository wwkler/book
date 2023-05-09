// 도서 상세 정보 페이지
import 'dart:ui' as ui;
import 'package:book_project/model/user_info.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_search_recommend.dart';
import 'package:book_project/screen/book/book_show_preview_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookShowPreview extends StatefulWidget {
  // 하단에 버튼을 유동적으로 배치해야 한다.

  // case 1. 사용자가 읽고 싶은 도서 목록에 있는 도서를 클릭해서 온 경우 -> 읽고 싶은 도서에서 삭제하기, 도서 읽기 버튼을 제공해야 한다.

  // case 2. 사용자가 읽고 있는 도서 목록에 있는 도서를 클릭해서 온 경우 -> 읽고 있는 도서임을 알리고 진행도만 알려준다.

  // case 3. 사용자가 읽은 도서 목록에 있는 도서를 클릭해서 온 경우 -> 읽은 도서였음을 알린다.

  // case 4. 사용자가 검색을 통해 도서를 클릭해서 온 경우, 추천 도서를 클릭해서 온 경우, 리뷰에 대한 도서를 클릭해서 온 경우
  //  -> 도서가 읽고 싶은 책에 있는 경우 -> case 1 처럼 읽고 싶은 도서에서 삭제하기, 도서 읽기 버튼을 제공해야 한다.
  // -> 해당 도서가 읽고 있는 책에 있는 경우 -> case 2 처럼 읽고 있는 도서임을 알리고 진행도만 알려준다.
  // -> 해당 도서가 읽은 책에 있는 경우 -> case 3 처럼 읽은 도서이었음을 알린다.
  // -> 아무 것도 아닌 경우 -> 찜하기, 도서 읽기 버튼을 제공한다.

  BookShowPreview({Key? key}) : super(key: key);

  @override
  State<BookShowPreview> createState() => _BookShowPreviewState();
}

class _BookShowPreviewState extends State<BookShowPreview> {
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

  @override
  void initState() {
    print("Book Show Preview InitState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book Show Preview state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 300,
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
                          Positioned(
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: CustomPaint(
                              size: const Size(100, 150),
                              painter: CustomCardShapePainter(
                                _borderRadius,
                                items[1].startColor,
                                items[1].endColor,
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    'assets/imgs/icon.png',
                                    height: 64,
                                    width: 64,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        items[0].name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        items[0].category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Avenir',
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Flexible(
                                            child: Text(
                                              items[0].location,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        items[0].rating.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      RatingBar(rating: items[0].rating),
                                    ],
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

                // 중간 공백
                const SizedBox(height: 40),

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
                                          // 서버와 통신
                                          // 읽고 싶은 책 추가

                                          //  다이어로그를 삭제한다.
                                          Get.back();

                                          // 도서 검색, 추천 페이지로 이동
                                          Get.off(() => BookFluidNavBar());
                                        },
                                      ),

                                      // 아니오
                                      TextButton(
                                        child: const Text("추가하지 않음"),
                                        onPressed: () {
                                          // 서버와 통신
                                          // 읽고 싶은 책 추가

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
                                          // 서버와 통신
                                          // 사용자의 읽고 있는 책에 도서 추가

                                          //  다이어로그를 삭제한다.
                                          Get.back();

                                          // 도서 검색, 추천 페이지로 이동
                                          Get.off(() => BookFluidNavBar());
                                        },
                                      ),

                                      // 아니오
                                      TextButton(
                                        child: const Text("추가하지 않음"),
                                        onPressed: () {
                                          // 서버와 통신
                                          // 읽고 싶은 책 추가

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
                const SizedBox(height: 40),

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
