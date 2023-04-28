// 사용자 정보를 관리하는 컨트롤러(controller)
import 'package:book_project/screen/auth/user_manager_check.dart';

class UserInfo {
  // 사용자인지 관리자인지에 대한 변수
  static UserManagerCheck? identity = UserManagerCheck.manager;
}
