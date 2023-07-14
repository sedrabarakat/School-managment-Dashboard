
class StudentsModel {
  bool? status;
  String? message;
  StudentsListModel? data;

  StudentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? StudentsListModel.fromJson(json['data']) : null;
  }
}

class StudentsListModel {
  int? lastPageNumber;
  List<StudentData>? studentsList;

  StudentsListModel.fromJson(Map<String, dynamic> json) {
    lastPageNumber = json['lastPageNumber'];

    if (json['data'] != null) {
      studentsList = [];
      json['data'].forEach((element) {
        studentsList!.add(StudentData.fromJson(element));
      });
    }
  }
}

class StudentData {
  int? student_id;
  String? name;
  int? grade;
  int? section;
  String? gender;
  String? parent_name;
  int? payment;

  StudentData.fromJson(Map<String, dynamic> json) {
    student_id = json['student_id'];
    name = json['name'];
    grade = json['grade'];
    section = json['number'];
    gender = json['gender'];
    parent_name = json['parent_name'];
    payment = json['left_for_qusat'];
  }
}


class Students {

  final name;
  final gender;
  final classes;
  final section;
  final parent;
  final payment;

  const Students({required this.name,required this.gender,required this.classes,required this.section, required this.parent, required this.payment});

}

final studentsList = <Students>[
  Students(name: '4', gender: 'Male', classes: '12', section: '2', parent: 'Jack',payment: 100),
  Students(name: '3', gender: 'Female', classes: '43', section: '12', parent: 'yoyo',payment: 200),
  Students(name: '2', gender: 'Female', classes: '1', section: '1', parent: 'wilson',payment: 250),
  Students(name: '6', gender: 'Female', classes: '12', section: '2', parent: 'Jack',payment: 100),
  Students(name: '4', gender: 'Male', classes: '43', section: '12', parent: 'yoyo',payment: 100),
  Students(name: '5', gender: 'Male', classes: '1', section: '1', parent: 'wilson',payment: 100),
  Students(name: '6', gender: 'Female', classes: '12', section: '2', parent: 'Jack',payment: 100),
  Students(name: '5', gender: 'Male', classes: '43', section: '12', parent: 'yoyo',payment: 100),
  Students(name: '1', gender: 'Male', classes: '1', section: '1', parent: 'wilson',payment: 100),
  Students(name: '1', gender: 'Female', classes: '12', section: '2', parent: 'Jack',payment: 100),
  Students(name: '3', gender: 'Female', classes: '43', section: '12', parent: 'yoyo',payment: 100),
  Students(name: '9', gender: 'Male', classes: '1', section: '1', parent: 'wilson',payment: 100),
];
