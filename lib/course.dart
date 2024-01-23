class Course {
  final int id;
  final String title;
  final String detail;
  final String date;
  final int view;
  final String picture;
  
 Course(this.id, this.title, this.detail, this.date, this.view, this.picture);
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      json['id'],
      json['title'],
      json['detail'],
      json['date'],
      json['view'],
      json['picture'],
 );
 }
}