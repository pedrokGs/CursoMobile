class Book {
  final String? id;
  final String title;
  final String author;
  final bool available;
  final String imageUrl;
  final String summary;

  Book({this.id, required this.title, required this.author, required this.available, required this.imageUrl, required this.summary});

  factory Book.fromJson(Map<String,dynamic> json){
    return Book(
      id: json["id"] ?? "0",
      title: json["title"] ?? "",
      author: json["author"] ?? "",
      available: json["available"] ?? false,
      imageUrl: json["imageUrl"] ?? "",
      summary: json["summary"] ?? "",
    );       
  }
}