class QuotesDao {
  String message;

  QuotesDao({this.message});

  QuotesDao.fromJson(Map<String, dynamic> json) {
    message = json['affirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affirmation'] = this.message;
    return data;
  }
}