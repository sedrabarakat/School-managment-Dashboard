class teacher_profile_model {
  bool? status;
  Data? data;

  teacher_profile_model({this.status, this.data});

  teacher_profile_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  TeacherInfo? teacherInfo;
  List<Subjects>? subjects;

  Data({this.teacherInfo, this.subjects});

  Data.fromJson(Map<String, dynamic> json) {
    teacherInfo = json['teacherInfo'] != null
        ? new TeacherInfo.fromJson(json['teacherInfo'])
        : null;
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teacherInfo != null) {
      data['teacherInfo'] = this.teacherInfo!.toJson();
    }
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherInfo {
  int? id;
  String? name;
  Null? img;
  String? phoneNumber;
  int? salary;
  String? gender;
  String? email;

  TeacherInfo(
      {this.id,
        this.name,
        this.img,
        this.phoneNumber,
        this.salary,
        this.gender,
        this.email});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    phoneNumber = json['phone_number'];
    salary = json['salary'];
    gender = json['gender'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['phone_number'] = this.phoneNumber;
    data['salary'] = this.salary;
    data['gender'] = this.gender;
    data['email'] = this.email;
    return data;
  }
}

class Subjects {
  int? id;
  String? name;

  Subjects({this.id, this.name});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}