class registerteacher {
  int? id;
  String? message;
  bool? status;

  registerteacher({this.id, this.message, this.status});

  registerteacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}