class User {
  final int? id;
  final String title;
  final String note;

  User({this.id, required this.title, required this.note});

 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      title: map['title'],
      note: map['note'],
    );
  }
}
