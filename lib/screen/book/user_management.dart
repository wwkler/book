// 사용자 관리하는 페이지
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:book_project/const/ipAddress.dart';
import 'package:book_project/model/user_info.dart';
import 'package:book_project/model/user_model.dart';
import 'package:book_project/screen/book/book_fluid_nav_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserManagement extends StatefulWidget {
  UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => UserManagementState();
}

class UserManagementState extends State<UserManagement> {
  // 검색어를 받기 위한 변수
  TextEditingController searchTextController = TextEditingController();

  // 사용자 정지 일수를 정하기 위한 변수
  TextEditingController setBanTimeController = TextEditingController();

  // 회원 데이터
  List<UserModel> memberList = [];

  // 서버와 통신
  var dio = Dio();

  // 회원 데이터를 모두 가져오는 함수
  Future<dynamic> getMemberList() async {
    // 서버와 통신 - 회원 데이터를 모두 가져온다.
    try {
      final response = await dio.get(
        "http://${IpAddress.hyunukIP}/getMemberList",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            "Authorization": "Bearer ${UserInfo.token}",
          },
        ),
      );

      return response.data;
    }
    // DioError[unknown]: null이 메시지로 나타났을 떄
    // 즉 서버가 열리지 않았다는 뜻이다
    catch (e) {
      print("서버가 열리지 않음");
    }
  }

  // snapshot.data를 가지고 memberList에 추가하는 함수
  void setMemberList(List<dynamic> members) {
    memberList.clear();

    memberList = members.map(
      (dynamic e) {
        return UserModel.fromJson(e as Map<String, dynamic>);
      },
    ).toList();
  }

  @override
  void initState() {
    print("User Management initState 시작");
    super.initState();
  }

  @override
  void dispose() {
    print("User Management State 종료");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getMemberList(),
            builder: (context, snapshot) {
              // getMemberList()를 실행하고 return 값이 안왔었다면?
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
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

                      // 회원 데이터들을 가져오고 있습니다.
                      Text(
                        "회원 데이터를 가져오고 있습니다",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              }
              //  getMemberList()를 실행하고 return 값이 왔었다면?
              else {
                // snapshot.data를 가지고 하나씩 객체로 변환하여 memberList에 추가한다.
                setMemberList(snapshot.data);

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

                        // 사용자 관리 Text
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
                                    "사용자 관리",
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
                        const SizedBox(height: 10),

                        // 사용자 이름 혹은 아이디로 검색
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimSearchBar(
                            width: 300,
                            textController: searchTextController,
                            helpText: "사용자 이름 또는 아이디 검색",
                            suffixIcon: const Icon(Icons.arrow_back),
                            onSuffixTap: () {
                              // 값이 비어있는 상태로 검색
                              setState(() {
                                searchTextController.clear();
                              });
                            },
                            onSubmitted: (String value) {
                              // 사용자 이름 또는 아이디로 검색헸으면?
                              setState(() {});
                            },
                          ),
                        ),

                        // 사용자 계정 목록
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Card(
                              elevation: 10.0,
                              color: Colors.white,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: SizedBox(
                                width: 450,
                                height: 400,
                                child: Column(
                                  children: [
                                    // 고유값, 이름, 아이디, 이메일, 성별, 나이, 관리
                                    SizedBox(
                                      width: 450,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: const [
                                              // 사용자 고유값
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "고유값",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 사용자명
                                              SizedBox(
                                                width: 80,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "이름",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 아이디
                                              SizedBox(
                                                width: 100,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "아이디",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 중간 공백

                                              // 이메일
                                              SizedBox(
                                                width: 100,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "이메일",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 성별
                                              SizedBox(
                                                width: 100,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "성별",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 나이
                                              SizedBox(
                                                width: 100,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "나이",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // 관리
                                              SizedBox(
                                                width: 100,
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "관리",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // 중간 공백
                                    const SizedBox(height: 10),

                                    // 일지 리스트
                                    memberList.isNotEmpty
                                        ? Expanded(
                                            flex: 1,
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: memberList.length,
                                              itemBuilder: (context, index) =>
                                                  GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  color: Colors.yellow[50],
                                                  width: 200,
                                                  height: 100,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        // 사용자 고유값
                                                        SizedBox(
                                                          width: 50,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .id
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),

                                                        // 사용자명
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .name,
                                                            ),
                                                          ),
                                                        ),

                                                        // 아이디
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .account,
                                                            ),
                                                          ),
                                                        ),

                                                        // 이메일
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .email,
                                                            ),
                                                          ),
                                                        ),

                                                        // 성별
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .gender,
                                                            ),
                                                          ),
                                                        ),

                                                        // 나이
                                                        SizedBox(
                                                          width: 100,
                                                          height: 100,
                                                          child: Center(
                                                            child: Text(
                                                              memberList[index]
                                                                  .age
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),

                                                        // 중간 공백
                                                        const SizedBox(
                                                            width: 20),

                                                        // 관리 - 정지
                                                        SizedBox(
                                                          width: 200,
                                                          height: 100,
                                                          child: Row(
                                                            children: [
                                                              // 정지 버튼
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  // ban 시간을 정할 수 있는 다이어로그
                                                                  Get.dialog(
                                                                    AlertDialog(
                                                                      title:
                                                                          const Text(
                                                                        "사용자 정지 일수 설정",
                                                                      ),
                                                                      content:
                                                                          SizedBox(
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            // 중간 공백
                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),

                                                                            // 아이디를 보여주는 문구
                                                                            const Text(
                                                                              "사용자 정지 일수를 설정해주세요",
                                                                            ),

                                                                            // 중간 공백
                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),

                                                                            // 정지 일수를 입력하는 곳
                                                                            // 총 페이지 수 설정
                                                                            Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(16.0),
                                                                                child: SizedBox(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  child: TextField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    controller: setBanTimeController,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),

                                                                            // 정지시키기 버튼
                                                                            TextButton(
                                                                              child: const Text(
                                                                                "정지시키기",
                                                                              ),
                                                                              onPressed: () async {
                                                                                // print(
                                                                                //     "setBanTimeController.text : ${setBanTimeController.text}");
                                                                                // 서버와 통신
                                                                                // 사용자 계정을 정지한다.
                                                                                try {
                                                                                  final response = await dio.post(
                                                                                    "http://${IpAddress.hyunukIP}/admin/banMember",
                                                                                    data: {
                                                                                      "id": memberList[index].id,
                                                                                      "bantime": int.parse(setBanTimeController.text),
                                                                                    },
                                                                                    options: Options(
                                                                                      headers: {
                                                                                        "Authorization": "Bearer ${UserInfo.token}",
                                                                                      },
                                                                                      validateStatus: (_) => true,
                                                                                      contentType: Headers.jsonContentType,
                                                                                      responseType: ResponseType.json,
                                                                                    ),
                                                                                  );

                                                                                  // setBanTimeController.text를 빈칸으로 만든다.
                                                                                  setBanTimeController.text = "";

                                                                                  if (response.statusCode == 200) {
                                                                                    print("서버와 통신 성공");
                                                                                    print("서버에서 받은 데이터 : ${response.data}");

                                                                                    Get.snackbar(
                                                                                      "사용자 정지시키기 성공",
                                                                                      "해당 사용자가 정지되었습니다",
                                                                                      duration: const Duration(
                                                                                        seconds: 5,
                                                                                      ),
                                                                                      snackPosition: SnackPosition.TOP,
                                                                                    );

                                                                                    // 사용자 정지 일수를 설정하는 다이어로그를 삭제한다
                                                                                    Get.back();

                                                                                    // 라우팅
                                                                                    Get.off(
                                                                                      () => BookFluidNavBar(),
                                                                                    );
                                                                                  }
                                                                                  //
                                                                                  else {
                                                                                    print("서버와 통신 실패");
                                                                                    print("서버 통신 에러 코드 : ${response.statusCode}");

                                                                                    print("에러 메시지: ${response.data}");

                                                                                    Get.snackbar(
                                                                                      "사용자 정지시키기 실패",
                                                                                      "해당 사용자 정지가 반영되지 않았습니다",
                                                                                      duration: const Duration(
                                                                                        seconds: 5,
                                                                                      ),
                                                                                      snackPosition: SnackPosition.TOP,
                                                                                    );
                                                                                  }
                                                                                }
                                                                                // DioError[unknown]: null이 메시지로 나타났을 떄
                                                                                // 즉 서버가 열리지 않았다는 뜻이다
                                                                                catch (e) {
                                                                                  // 서버가 열리지 않았다는 snackBar를 띄운다
                                                                                  Get.snackbar(
                                                                                    "서버 열리지 않음",
                                                                                    "서버가 열리지 않았습니다\n관리자에게 문의해주세요",
                                                                                    duration: const Duration(
                                                                                      seconds: 5,
                                                                                    ),
                                                                                    snackPosition: SnackPosition.TOP,
                                                                                  );
                                                                                }
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10.0,
                                                                    ),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .purple,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        15,
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  "정지",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),

                                                              // 중간 공백
                                                              const SizedBox(
                                                                width: 10,
                                                              ),

                                                              // 탈퇴 버튼
                                                              // ElevatedButton(
                                                              //   onPressed: () {
                                                              //     // 서버와 통신
                                                              //     // 사용자 계정을 탈퇴한다.
                                                              //   },
                                                              //   style: ElevatedButton
                                                              //       .styleFrom(
                                                              //     shape:
                                                              //         RoundedRectangleBorder(
                                                              //       borderRadius:
                                                              //           BorderRadius
                                                              //               .circular(
                                                              //         10.0,
                                                              //       ),
                                                              //     ),
                                                              //     backgroundColor:
                                                              //         Colors.purple,
                                                              //     padding:
                                                              //         const EdgeInsets
                                                              //             .symmetric(
                                                              //       horizontal: 10,
                                                              //       vertical: 15,
                                                              //     ),
                                                              //   ),
                                                              //   child: const Text(
                                                              //     "탈퇴",
                                                              //     style: TextStyle(
                                                              //       fontSize: 12,
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.yellow[50],
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              child: const Center(
                                                child: Text("사용자 데이터가 없습니다"),
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
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
