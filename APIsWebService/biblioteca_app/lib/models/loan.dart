class Loan {
  final String? id;
  final String userId;
  final String bookId;
  final String startDate;
  final String dueDate;
  final bool returned;

  Loan({this.id, required this.userId, required this.bookId, required this.startDate, required this.dueDate, required this.returned});

  factory Loan.fromJson(Map<String,dynamic> json){
    return Loan(
      id: json["id"] ?? "0",
      userId: json["userId"] ?? "0",
      bookId: json["bookId"] ?? "0",
      startDate: json["startDate"] ?? "00-00-0000",
      dueDate: json["dueDate"] ?? "00-00-0000",
      returned: json["returned"] ?? false
    );       
  }

}