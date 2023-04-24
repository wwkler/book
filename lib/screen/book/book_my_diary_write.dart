// 도서 일지 작성 페이지
import 'dart:io';

import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
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
  // 읽고 있는 도서 목록
  final List<String> readNowBooks = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  // 선택한 읽고 있는 도서
  String? selectedValue;

  // 카메라
  final ImagePicker _picker = ImagePicker();
  XFile? _photo = null;

  // 감상평 Text
  final reviewController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
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

                  // 읽고 있는 도서 검색
                  Center(
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
                                '읽고 있는 도서 검색',
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
                        items: readNowBooks
                            .map(
                              (String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: [
                                    // 읽고 있는 도서 이미지
                                    Image.asset(
                                      "assets/imgs/icon.png",
                                    ),

                                    // 중간 공백
                                    const SizedBox(width: 20),

                                    // 읽고 있는 도서 제목
                                    Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 250,
                          padding: const EdgeInsets.only(left: 14, right: 14),
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
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 80,
                          padding: EdgeInsets.only(left: 14, right: 14),
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
                          setState(() {
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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

                  // 감상평
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: reviewController,
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
                        onPressed: () {
                          // 서버와 통신
                          // 서버에 새 일지를 추가한다.
                          
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
