class StudentsForSessionModel {
  bool? status;
  List<Data>? data;

  StudentsForSessionModel({this.status, this.data});

  StudentsForSessionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? status;
  int? studentId;

  Data({this.name, this.status, this.studentId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['student_id'] = this.studentId;
    return data;
  }
}