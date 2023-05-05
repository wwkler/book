// 도서 데이터를 생성하는 클래스

class BookModel {
  // 도서 고유값
  final int id;

  // 도서 제목
  final String title;

  // 도서 작가 이름
  final String author;

  // 도서 분야 번호(ex. 국내도서/소설의 번호 101)
  final int categoryId;

  // 도서 출판사
  final String publisher;

  // 도서 출판일
  final DateTime pub_date;

  // 도서 이미지
  final String cover;

  // 도서 설명
  final String description;

  // 도서 구입 링크
  final String link;

  // 생성자
  BookModel(
    this.id,
    this.title,
    this.author,
    this.categoryId,
    this.publisher,
    this.pub_date,
    this.cover,
    this.description,
    this.link,
  );

  // json 데이터를 객체로 만들어주는 함수
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      json["id"],
      json["title"],
      json["author"],
      json["categoryId"],
      json["publisher"],
      json["pub_date"],
      json["cover"],
      json["description"],
      json["link"],
    );
  }
}
