class Token {
  bool? success;
  void data;
  String? message;

  Token({this.success, this.data, this.message});

  Token.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'];
    data['message'] = message;
    return data;
  }
}
