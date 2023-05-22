// 도서 일지 작성 페이지
import 'dart:io';

import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/bookModel.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BookMyDiaryWrite extends StatefulWidget {
  const BookMyDiaryWrite({super.key});

  @override
  State<BookMyDiaryWrite> createState() => _BookMyDiaryWriteState();
}

class _BookMyDiaryWriteState extends State<BookMyDiaryWrite> {
  // // 읽고 있는 도서 목록
  // final List<String> readNowBooks = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];
  // // 선택한 읽고 있는 도서
  // String? selectedValue;

  // 읽고 있는 도서, 읽은 도서 배열
  List<BookModel> books = [];
  // 선택한 읽고 있는 도서, 읽은 도서
  BookModel? selectedBook;
  // 서버 호출 플래그
  bool callServer = true;

  // 카메라
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;

  // 일지 제목 Text
  final diaryTitleController = TextEditingController();

  // 감상평 Text
  final diaryContentController = TextEditingController();

  // 서버를 사용하는 변수
  var dio = Dio();

  @override
  void initState() {
    print("Book My Diary Write initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book My Diary Write state 종료");
    super.dispose();
  }

  // 읽고 있는 도서, 읽은 도서를 가져오는 함수
  Future<void> getBookDatas() async {
    // callServer가 true일 떄
    if (callServer == true) {
      try {
        // 읽고 있는 도서를 서버에서 가져온다.
        final response5 = await dio.get(
          "http://${IpAddress.hyunukIP}/bookshelves/getReadingBooks?memberId=${UserInfo.userValue}",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response5.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 받은 읽고 있는 도서 데이터: ${response5.data}");

          for (var data in response5.data as List<dynamic>) {
            books.add(BookModel.fromJson(data["book"] as Map<String, dynamic>));
          }
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response5.statusCode}");
        }
      }
      // DioError[unknown]: null이 메시지로 나타났을 떄
      // 즉 서버가 열리지 않았다는 뜻이다
      catch (e) {
        print("서버 5가 열리지 않음");
      }

      try {
        // 읽은 도서를 서버에서 가져온다.
        final response6 = await dio.get(
          "http://${IpAddress.hyunukIP}/bookshelves/getFinishedBooks?memberId=${UserInfo.userValue}",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );

        if (response6.statusCode == 200) {
          print("서버와 통신 성공");
          print("서버에서 받은 읽은 도서 데이터: ${response6.data}");

          for (var data in response6.data as List<dynamic>) {
            books.add(BookModel.fromJson(data["book"] as Map<String, dynamic>));
          }

          print("books : $books");
        }
        //
        else {
          print("서버와 통신 실패");
          print("서버 통신 에러 코드 : ${response6.statusCode}");
        }
      }
      // DioError[unknown]: null이 메시지로 나타났을 떄
      // 즉 서버가 열리지 않았다는 뜻이다
      catch (e) {
        print("서버 6이 열리지 않음");
      }

      // books가 있으면, books[0]를 selectedBook으로 설정한다
      if (books.isNotEmpty) {
        selectedBook = books[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBookDatas(),
      builder: (context, snapshot) {
        // getBookDatas()를 실행하는 도중 ....
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
              body: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // 프로그래스바
                    CircularProgressIndicator(),

                    // 중간 공백
                    SizedBox(height: 40),

                    // 읽고 있는 도서, 읽은 도서 데이터를 가져오고 있습니다
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "읽고 있는 도서, 읽은 도서\n 데이터를 가져오고 있습니다",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // getBookDatas()를 실행한 후...
        else {
          return SafeArea(
            child: Scaffold(
              body: Container(
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

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
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

                        // 새 일지 작성 Text
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
                                    "새 일지 작성",
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
                        const SizedBox(height: 40),

                        // 읽고 있는 도서, 읽은 도서가 있는지 없는지에 따라 다른 로직 구현
                        books.isNotEmpty
                            ? Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '읽고 있는/ 읽은 도서 검색',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: selectedBook!.title,
                                    items: books
                                        .map(
                                          (BookModel bookModel) =>
                                              DropdownMenuItem<String>(
                                            value: bookModel.title,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  // 읽고 있는 / 읽은 도서 이미지
                                                  Image.network(
                                                    bookModel.coverSmallUrl,
                                                    width: 50,
                                                    height: 50,
                                                  ),

                                                  // 중간 공백
                                                  const SizedBox(width: 10),

                                                  // 읽고 있는 / 읽은 도서 제목
                                                  Text(
                                                    bookModel.title,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),

                                                  // 중간 공백
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? bookName) {
                                      // 서버를 호출하지 않겠다.
                                      callServer = false;
                                      setState(() {
                                        print("bookName : $bookName");
                                        selectedBook = books.firstWhere(
                                          (BookModel book) =>
                                              book.title == bookName,
                                        );
                                        print("selectedBook : $selectedBook");
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 250,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.purple,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                      ),
                                      iconSize: 14,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 300,
                                      padding: null,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.purple,
                                      ),
                                      elevation: 8,
                                      offset: const Offset(-20, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 80,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
                                        Icon(
                                          Icons.list,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '읽고 있는 / 읽은 도서가 없습니다',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: [],
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 250,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.purple,
                                      ),
                                      elevation: 2,
                                    ),
                                  ),
                                ),
                              ),

                        // 중간 공백
                        const SizedBox(height: 40),

                        // 카메라 사진
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              // 사용자의 카메라를 작동시켜 사진을 찍는다.
                              // Capture a photo.
                              final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera,
                              );

                              if (photo != null) {
                                print("photo_path : ${photo.path}");
                                print(
                                    "photo_path의 데이터 타입 : ${photo.path.runtimeType}");
                                setState(() {
                                  // 서버를 호출하지 않겠다
                                  callServer = false;
                                  _photo = photo;
                                });
                              }
                            },
                            child: Card(
                              elevation: 10.0,
                              color: Colors.white.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                // 이미지가 있냐, 없냐에 따라 다른 로직 구현
                                child: _photo == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          // + 아이콘
                                          Icon(
                                            Icons.add,
                                            size: 40,
                                          ),

                                          SizedBox(height: 20),

                                          // 이미지 추가
                                          Text(
                                            "이미지를 추가하세요",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Image.file(
                                        File(_photo!.path),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 40),

                        // 일지 제목
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: TextField(
                            controller: diaryTitleController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              labelText: '리뷰 제목',
                            ),
                          ),
                        ),

                        // 일지 감상평
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: diaryContentController,
                            keyboardType: TextInputType.multiline,
                            minLines: 2,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.purple),
                              ),
                              labelText: '감상평',
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 40),

                        // 작성 완료 버튼
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                // 검증
                                if (diaryTitleController.text != "" &&
                                    diaryContentController.text != "") {
                                  // 일지 작성 완료를 시도한다
                                  try {
                                    final response = await dio.post(
                                      "http://${IpAddress.hyunukIP}/journals/save",
                                      data: {
                                        "memberId": UserInfo.userValue,
                                        "itemId": selectedBook!.itemId,
                                        "title": diaryTitleController.text,
                                        "content": diaryContentController.text,
                                        "image": _photo == null
                                            ? ""
                                            : _photo!.path,
                                      },
                                      options: Options(
                                        validateStatus: (_) => true,
                                        contentType: Headers.jsonContentType,
                                        responseType: ResponseType.json,
                                      ),
                                    );

                                    if (response.statusCode == 200) {
                                      print("서버와 통신 성공");
                                      print("서버에서 받아온 데이터 : ${response.data}");

                                      // 일지 작성 완료 snackBar를 띄운다
                                      Get.snackbar(
                                        "일지 작성 완료",
                                        "일지 작성 반영이 완료되었습니다",
                                        duration: const Duration(seconds: 5),
                                        snackPosition: SnackPosition.TOP,
                                      );

                                      // 라우팅
                                      Get.off(() => BookFluidNavBar());
                                    }
                                    //
                                    else {
                                      print("서버와 통신 실패");
                                      print(
                                          "서버 통신 에러 코드 : ${response.statusCode}");

                                      // 일지 작성 반영 실패 snackBar를 띄운다
                                      Get.snackbar(
                                        "일지 작성 실패",
                                        "일지 작성 반영이 실패되었습니다",
                                        duration: const Duration(seconds: 5),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    }
                                  }
                                  // DioError[unknown]: null이 메시지로 나타났을 떄
                                  // 즉 서버가 열리지 않았다는 뜻이다
                                  catch (e) {
                                    print("서버가 열리지 않음");

                                    // 서버가 열리지 않았음을 snackBar를 띄운다
                                    Get.snackbar(
                                      "서버가 열리지 않음",
                                      "서버가 열리지 않았습니다",
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                }
                                //
                                else {
                                  // 클라언트에서 이상 입력값을 줬다는 snackBar를 띄운다
                                  Get.snackbar(
                                    "이상 메시지",
                                    "정규표현식에 적합하지 않거나 체크하지 않은 부분이 존재함",
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.purple,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 20,
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.create_outlined,
                                    size: 30,
                                  ),
                                  SizedBox(width: 40),
                                  Text(
                                    "작성 완료",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 중간 공백
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
