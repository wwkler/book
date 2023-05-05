// 사용자 정보를 저장한다.
import 'package:book_project/screen/auth/user_manager_check.dart';

class UserInfo {
  // 사용자인지 관리자인지에 대한 변수
  static UserManagerCheck? identity;

  // 사용자 고유값
  static String? userValue;

  // 사용자 아이디
  static String? id;

  // 사용자 비밀번호
  static String? password;

  // 사용자 이름
  static String? name;

  // 사용자 나이
  static int? age;

  // 선호 도서 장르 코드
  static int? selectedCode;

  // 이메일
  static String? email;
}
