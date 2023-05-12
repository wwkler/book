// 도서 데이터를 생성하는 클래스
// 서버로부터 받아온 검색 도서, 추천 도서, 베스트셀러 도서, 신간 도서를 받아 객체로 변환하는 역할을 한다.

class BookModel {
  // 도서 제목
  final String title;

  // 도서 작가 이름
  final String author;

  // 도서 분야 번호(ex. 국내도서/소설의 번호 101)
  // 서버가 열리지 않고 인터파크 오픈 api로 검색했을 떄는 categoryId가 String이여서 데이터타입을 String으로 바꿔야 함
  final int categoryId;

  // 도서 출판사
  final String publisher;

  // 도서 출판일
  final String pubDate;

  // 도서 설명
  final String description;

  // 도서 구입 링크
  final String link;

  // 도서 이미지
  final String coverSmallUrl;

  // 판매중
  final String saleStatus;

  // 가격
  final int priceStandard;

  // 생성자
  BookModel(
    this.title,
    this.author,
    this.categoryId,
    this.publisher,
    this.pubDate,
    this.description,
    this.link,
    this.coverSmallUrl,
    this.saleStatus,
    this.priceStandard,
  );

  // json 데이터를 객체로 만들어주는 함수
  BookModel.fromJson(dynamic json)
      // json["title"], json["author"].... 등이 null이 있는 경우가 존재해서 null일 떄 빈값을 저장하도록 처리한다.
      : title = json["title"] ?? "",
        author = json["author"] ?? "",
        categoryId = json["categoryId"] ?? 0,
        publisher = json["publisher"] ?? "",
        pubDate = json["pubDate"] ?? "",
        description = json["description"] ?? "",
        link = json["link"] ?? "",
        coverSmallUrl = json["coverSmallUrl"] ?? "",
        saleStatus = json["saleStatus"] ?? "",
        priceStandard = json["priceStandard"] ?? 0;
}
