// 도서 나만의 일지 페이지
import 'package:book_project/screen/book/book_my_diary_list.dart';
import 'package:book_project/screen/book/book_my_diary_write.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:table_calendar/table_calendar.dart';

class BookMyDiary extends StatefulWidget {
  BookMyDiary({Key? key}) : super(key: key);

  @override
  State<BookMyDiary> createState() => _BookMyDiaryState();
}

class _BookMyDiaryState extends State<BookMyDiary> {
  // 도서 일지 히스토리를 기록하는 변수
  Map<DateTime, List<String>> events = {
    DateTime.utc(2023, 4, 5): ["Exist Book Diary History"],
    DateTime.utc(2023, 4, 9): ["Exist Book Diary History"],
  };

  // 현재 한국 시간 변수
  DateTime? currentTime;

  @override
  void initState() {
    print("Book My Diary initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("Book My Diary state 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Book My Diary build 시작");

    return FutureBuilder(
      // 한국 시간을 받기 위해 기다린다. 참고로 도서 일지 데이터도 서버에서 받아온다.
      future: getKoreanTime(),
      builder: (context, snapshot) {
        // if (currentTime == null) {
        //   // 로딩 화면
        //   return const SizedBox(
        //     child: Center(
        //       child: Text("기다려주세요"),
        //     ),
        //   );
        // }
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
                  "사용자 일지 데이터를 가져오고 있습니다",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }
        // 도서 일지 메인 화면
        else {
          return SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 중간 공백
                    const SizedBox(height: 20),

                    // 도서 일지 달력 요약 Text
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
                                "도서 일지 달력 요약",
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

                    // 일지 작성 요약 달력
                    TableCalendar(
                      locale: 'ko_KR',
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.utc(2023, 12, 31),
                      currentDay: currentTime!,
                      focusedDay: currentTime!,
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          color: Colors.purple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        headerPadding: EdgeInsets.symmetric(vertical: 4.0),
                        leftChevronIcon: Icon(
                          Icons.arrow_left,
                          size: 40.0,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_right,
                          size: 40.0,
                        ),
                      ),
                      calendarStyle: const CalendarStyle(
                        markerSize: 20.0,
                        markerDecoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/imgs/book.png"),
                          ),
                        ),
                      ),
                      eventLoader: _getEventsForDay,
                      onDaySelected:
                          (DateTime selectedDay, DateTime focusedDay) {
                        if (events.containsKey(selectedDay)) {
                          // Dialog를 띄워서 해당 날짜에 적은 일지를 요약해서 보여주기
                          final value = events[selectedDay];
                          print(value);
                        }
                      },
                    ),

                    // 중간 공백
                    const SizedBox(height: 50),

                    // 새 일지 작성 버튼
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // 새 일지 작성 페이지로 라우팅
                            Get.off(() => BookMyDiaryWrite());
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
                                "새 일지 작성",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 30),

                    // 일지 보기 작성 버튼
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // 일지 보기 페이지로 라우팅
                            Get.off(() => BookMyDiaryList());
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
                                Icons.menu_book_outlined,
                                size: 30,
                              ),
                              SizedBox(width: 40),
                              Text(
                                "일지 보기",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 중간 공백
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  // 달력에 사용자 도서 일지를 보여주기 위한 함수
  List<String> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  // 한국 시간을 얻기 위한 함수
  Future<void> getKoreanTime() async {
    // 한국 시간을 얻는다.
    currentTime = await NTP.now();
    currentTime = currentTime!.toUtc().add(const Duration(hours: 9));
    print(currentTime);

    await Future.delayed(const Duration(seconds: 10));
  }
}
