// 도서 검색어를 통한 결과물을 보여주는 페이지
import 'dart:ui' as ui;
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/const/user_manager_check.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:book_project/screen/book/book_show_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // 검색어를 요청해서 서버로부터 받은 도서 데이터
  List<BookModel> searchBookModels = [];

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
  Future<void> getSearchBookDatas() async {
    // bookModels를 clear 한다.
    searchBookModels.clear();

    // 접속하려는 서버 url를 설정한다.
    String url =
        "http://${IpAddress.hyunukIP}/api/search?query=${discrimition != "" ? discrimition : text}";
    // "http://49.161.110.41:8080/api/search?query=${discrimition != "" ? discrimition : text}";
    // "http://book.interpark.com/api/search.api?key=91AC2ACAC3C7059705E426DABAF9315BCAA238BFAA0056F78D7379F42177E28A&query=${discrimition != "" ? discrimition : text}&output=json";

    print("url : $url");

    // 이전 페이지에서 검색어를 요청해서 서버로부터 도서 데이터를 받을 경우에 대한 로직 처리
    if (discrimition != "") {
      discrimition = "";
    }

    try {
      // 서버와 통신 - 서버에 접속해서 인터파크 도서 검색 API 데이터를 받는다.
      final response = await dio.get(
        url,
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        print("서버와 통신 성공");
        print("서버에서 받은 데이터 : ${response.data}");

        // response.data에 도서 데이터가 있느냐 없느냐에 따라 다른 로직 구현
        if ((response.data["item"] as List<dynamic>).isEmpty) {
          print("도서 데이터가 없다.");
        }
        //
        else {
          print("도서 데이터가 있다.");
          print((response.data["item"] as List<dynamic>).length);

          searchBookModels = (response.data["item"] as List<dynamic>).map(
            (dynamic e) {
              return BookModel.fromJson(e as Map<String, dynamic>);
            },
          ).toList();

          print("searchBookModels : $searchBookModels");
        }
      }
      //
      else {
        print("서버와 통신 실패");
        print("서버 통신 에러 코드 : ${response.statusCode}");
      }
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Book Search Result build 시작");
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getSearchBookDatas(),
          builder: (context, snapshot) {
            // getSearchBookDatas()를 실행하는 동안만 실행
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                  // 배경 이미지
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: UserInfo.identity == UserManagerCheck.user
                          ? const AssetImage("assets/imgs/background_book1.jpg")
                          : const AssetImage(
                              "assets/imgs/background_book2.jpg"),
                      fit: BoxFit.fill,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 프로그래스바
                      const CircularProgressIndicator(),

                      // 중간 공백
                      SizedBox(height: 40.h),

                      // 도서 데이터들을 가져오고 있습니다.
                      Text(
                        "도서 데이터를 가져오고 있습니다",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            // getSerachBookDatas()를 다 실행했으면....
            else {
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: MediaQuery.of(context).size.width.w,
                    height: MediaQuery.of(context).size.height.h,
                    // 배경 이미지
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: UserInfo.identity == UserManagerCheck.user
                            ? const AssetImage(
                                "assets/imgs/background_book1.jpg")
                            : const AssetImage(
                                "assets/imgs/background_book2.jpg"),
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

                              SizedBox(width: 10.h),

                              // search bar
                              AnimSearchBar(
                                width: 300.w,
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
                                  }
                                  //
                                  else {
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
                          SizedBox(height: 5.h),

                          // 도서 Text
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
                                      "도서",
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

                          // 검색 도서 결과물이 있으면 도서들을 보여주고, 없으면 없다는 메시지를 화면에 표시한다.
                          searchBookModels.isNotEmpty
                              ? Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchBookModels.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              // 도서 상세 페이지로 라우팅
                                              Get.off(
                                                () => BookShowPreview(),
                                                arguments:
                                                    searchBookModels[index],
                                              );
                                            },
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 150.h,
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
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            items[1].endColor,
                                                        blurRadius: 12.r,
                                                        offset:
                                                            const Offset(0, 6),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0.w,
                                                  bottom: 0.h,
                                                  top: 0.h,
                                                  child: CustomPaint(
                                                    size: Size(80.w, 50.h),
                                                    painter:
                                                        CustomCardShapePainter(
                                                      _borderRadius,
                                                      items[1].startColor,
                                                      items[1].endColor,
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: Row(
                                                    children: [
                                                      // 중간 공백
                                                      SizedBox(width: 10.w),

                                                      // 도서 이미지
                                                      Expanded(
                                                        flex: 1,
                                                        child: Image.network(
                                                          searchBookModels[
                                                                  index]
                                                              .coverSmallUrl,
                                                          width: 100.w,
                                                          height: 100.h,
                                                        ),
                                                      ),

                                                      // 중간 공백
                                                      SizedBox(width: 10.w),

                                                      // 도서 제목
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          searchBookModels[
                                                                  index]
                                                              .title,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Avenir',
                                                            fontSize: 17.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),

                                                      // 중간 공백
                                                      SizedBox(width: 20.w),

                                                      // 도서 번쨰 체크
                                                      Expanded(
                                                        flex: 1,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "도서 ${index + 1}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Avenir',
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
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
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 400.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // 중간 공백
                                      SizedBox(height: 100.h),

                                      // 데이터가 존재하지 않는 아이콘
                                      Image.asset(
                                        "assets/imgs/sad.png",
                                        width: 100.w,
                                        height: 100.h,
                                      ),

                                      // 중간 공백
                                      SizedBox(height: 40.h),

                                      // 데이터가 존재하지 않습니다 Text
                                      Text(
                                        "데이터가 존재하지 않습니다.",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                          // 중간 공백
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
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
