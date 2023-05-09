// 도서 검색어를 통한 결과물을 보여주는 페이지
import 'dart:ui' as ui;
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookSearchResult extends StatefulWidget {
  const BookSearchResult({Key? key}) : super(key: key);

  @override
  State<BookSearchResult> createState() => _BookSearchResultState();
}

class _BookSearchResultState extends State<BookSearchResult> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();
  String text = "";

  // 이전 페이지에서 검색어를 통해 서버로부터 도서 데이터를 받는지
  // 현재 페이지에서 검색어를 통해 서버로부터 도서 데이터를 받는지 판별하는 변수
  String discrimition = Get.arguments;

  // 검색어를 요청해서 서버로부터 받은 데이터가 존재하는지 안하는지 판별하는 변수
  bool isBookData = true;

  // 검색어를 요청해서 서버로부터 받은 도서 데이터
  List<BookModel> bookModels = [];

  // 서버와 통신
  var dio = Dio();

  // 검색어를 통한 결과값이 존재하면, UI으로 보여주기 위한 변수, 배열
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
    print("Book Search Result InitState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book Search Result state 종료");
    super.dispose();
  }

  // 검색어를 요청해서 서버로부터 인터파크 책검색 API 데이터를 받는다.
  Future<void> getBookDatas() async {
    // bookModels를 clear 한다.
    bookModels.clear();

    // 접속하려는 서버 url를 설정한다.
    String url =
        "http://49.161.110.41:8080/${discrimition != "" ? discrimition : text}";

    // 이전 페이지에서 검색어를 요청해서 서버로부터 도서 데이터를 받을 경우에 대한 로직 처리
    if (discrimition != "") {
      discrimition = "";
      print("discrimition : $discrimition");
    }

    print(url);

    await Future.delayed(Duration(seconds: 5));

    // 서버와 통신 - 서버에 접속해서 인터파크 도서 검색 API 데이터를 받는다.
    // final response = await dio.get(
    //   url,
    //   options: Options(
    //     validateStatus: (_) => true,
    //     contentType: Headers.jsonContentType,
    //     responseType: ResponseType.json,
    //   ),
    // );

    // response.data에 도서 데이터가 있느냐 없느냐에 따라 다른 로직 구현

    //  // response.data가 있으면, 객체로 변환하여 저장하고, isBookData를 true로 저장한다.

    //  // response.data가 없으면 그냥 isBookData를 false로 저장한다.
  }

  @override
  Widget build(BuildContext context) {
    print("Book Search Result build 시작");
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getBookDatas(),
          builder: (context, snapshot) {
            // getBookDatas()를 실행하는 동안만 실행
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: MediaQuery.of(context).size.width,
                // 배경 이미지
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/imgs/background_book1.jpg"),
                    fit: BoxFit.fill,
                    opacity: 0.3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // 프로그래스바
                    CircularProgressIndicator(),

                    // 중간 공백
                    SizedBox(height: 40),

                    // 도서 데이터들을 가져오고 있습니다.
                    Text(
                      "도서 데이터를 가져오고 있습니다",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }
            // getBookDatas()를 다 실행했으면....
            else {
              return Container(
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
                      // 이전 페이지 아이콘, search bar
                      Row(
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

                          const SizedBox(width: 10),

                          // search bar
                          AnimSearchBar(
                            width: 300,
                            textController: searchTextController,
                            helpText: "책 또는 저자를 입력",
                            suffixIcon: const Icon(Icons.arrow_back),
                            onSuffixTap: () {
                              searchTextController.clear();
                            },
                            onSubmitted: (String value) {
                              if (searchTextController.text.isNotEmpty) {
                                text = value;
                                setState(() {});
                              } else {
                                Get.snackbar(
                                  "이상 메시지",
                                  "책 또는 저자를 입력해주세요",
                                  duration: const Duration(seconds: 5),
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            },
                          ),
                        ],
                      ),

                      // 중간 공백
                      const SizedBox(height: 5),

                      // 도서 Text
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
                                  "도서",
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

                      // 책 결과물 -> 없으면 결과가 없다는 text를 화면에 보여주고, 있으면 책들을 보여준다.
                      isBookData == true
                          ? Expanded(
                              flex: 1,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // 도서 상세 페이지로 라우팅
                                          Get.off(() => BookShowPreview());
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  _borderRadius,
                                                ),
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
                                                  // 도서 이미지
                                                  Expanded(
                                                    child: Image.asset(
                                                      'assets/imgs/icon.png',
                                                      height: 64,
                                                      width: 64,
                                                    ),
                                                    flex: 2,
                                                  ),
                                                  // 도서 정보들
                                                  Expanded(
                                                    flex: 4,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        // 도서 정보
                                                        Text(
                                                          items[index].name,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Avenir',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        // 도서 정보
                                                        Text(
                                                          items[index].category,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Avenir',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        Row(
                                                          children: <Widget>[
                                                            // 아이콘
                                                            const Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            // 도서 정보
                                                            Flexible(
                                                              child: Text(
                                                                items[index]
                                                                    .location,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Avenir',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // 별점
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                          items[index]
                                                              .rating
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Avenir',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        RatingBar(
                                                          rating: items[index]
                                                              .rating,
                                                        ),
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
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 400,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 중간 공백
                                  const SizedBox(height: 100),

                                  // 데이터가 존재하지 않는 아이콘
                                  Image.asset(
                                    "assets/imgs/sad.png",
                                    width: 100,
                                    height: 100,
                                  ),

                                  // 중간 공백
                                  const SizedBox(height: 40),

                                  // 데이터가 존재하지 않습니다 Text
                                  Text(
                                    "데이터가 존재하지 않습니다.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                      // 중간 공백
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// 검색어를 통한 결과값이 존재하면, UI으로 보여주기 위한 클래스 1
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

// 검색어를 통한 결과값이 존재하면, UI으로 보여주기 위한 클래스 2
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

// 검색어를 통한 결과값이 존재하면, UI으로 보여주기 위한 클래스 3
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
