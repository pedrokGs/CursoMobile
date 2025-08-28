class Book {
  final String? id;
  final String title;
  final String author;
  final bool available;
  final String imageUrl;
  final String summary;
  final bool isFavorite;

  Book({this.id, required this.title, required this.author, required this.available, required this.imageUrl, required this.summary, required this.isFavorite});

  factory Book.fromJson(Map<String,dynamic> json){
    return Book(
      id: json["id"] ?? "0",
      title: json["title"] ?? "",
      author: json["author"] ?? "",
      available: json["available"] == true ? true : false,
      imageUrl: json["imageUrl"] ?? "",
      summary: json["summary"] ?? "",
      isFavorite: json["isFavorite"]  == true ? true : false,
    );       
  }

  Map<String, dynamic> toJson() {
    final data = {
      "title": title,
      "author": author,
      "available": available,
      "imageUrl": imageUrl,
      "summary": summary,
      "isFavorite": isFavorite
    };

    if (id != null) {
      data["id"] = id!;
    }

    return data;
  }
  

   copyWith({String? id, String? title, String? author, bool? available, String? imageUrl, String? summary, bool? isFavorite}){
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      available: available ?? this.available,
      imageUrl: imageUrl ?? this.imageUrl,
      summary: summary ?? this.summary,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}