// 사용자 모델
class UserModel {
  // 사용자 고유값
  final int id;

  // 사용자 계정 아이디
  final String account;

  // 사용자 이름
  final String name;

  // 사용자 선호 코드 
  final int prefer;

  // 사용자 이메일
  final String email;

  // 사용자 나이
  final int age;

  // 사용자 성
  final String gender;

  // 생성자
  UserModel(
    this.id,
    this.account,
    this.name,
    this.prefer,
    this.email,
    this.age,
    this.gender,
    // this.ban,
  );

  // Map를 객체로 변환하는 함수
  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        account = json["account"],
        name = json["name"],
        prefer = json["prefer"],
        email = json["email"],
        age = json["age"],
        gender = json["gender"];

  // @override
  // String toString() => "이 객체의 이름은 ${name} 입니다.";
}
