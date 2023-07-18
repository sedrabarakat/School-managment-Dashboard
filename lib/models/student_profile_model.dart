class Student_profile_model {
  bool? status;
  Data? data;

  Student_profile_model({this.status, this.data});

  Student_profile_model.fromJson(Map<String, dynamic> json) {
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
  StudentData? studentData;
  int? absenceRate;
  int? marksRate;

  Data({this.studentData, this.absenceRate, this.marksRate});

  Data.fromJson(Map<String, dynamic> json) {
    studentData = json['student_data'] != null
        ? new StudentData.fromJson(json['student_data'])
        : null;
    absenceRate = json['absence_rate'];
    marksRate = json['marks_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentData != null) {
      data['student_data'] = this.studentData!.toJson();
    }
    data['absence_rate'] = this.absenceRate;
    data['marks_rate'] = this.marksRate;
    return data;
  }
}

class StudentData {
  int? id;
  String? name;
  String? birthDate;
  String? gender;
  String? email;
  String? img;
  String? address;
  String? phoneNumber;
  int? leftForQusat;
  int? isInBus;
  int? leftForBus;
  int? grade;
  int? sectionNumber;

  StudentData(
      {this.id,
        this.name,
        this.birthDate,
        this.gender,
        this.email,
        this.img,
        this.address,
        this.phoneNumber,
        this.leftForQusat,
        this.isInBus,
        this.leftForBus,
        this.grade,
        this.sectionNumber});

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    email = json['email'];
    img = json['img'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    leftForQusat = json['left_for_qusat'];
    isInBus = json['is_in_bus'];
    leftForBus = json['left_for_bus'];
    grade = json['grade'];
    sectionNumber = json['section_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['img'] = this.img;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['left_for_qusat'] = this.leftForQusat;
    data['is_in_bus'] = this.isInBus;
    data['left_for_bus'] = this.leftForBus;
    data['grade'] = this.grade;
    data['section_number'] = this.sectionNumber;
    return data;
  }
}