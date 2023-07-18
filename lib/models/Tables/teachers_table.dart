
class TeachersModel {
  bool? status;
  String? message;
  TeachersListModel? data;

  TeachersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? TeachersListModel.fromJson(json['data']) : null;
  }
}

class TeachersListModel {
  int? lastPageNumber;
  List<TeacherData>? teachersList;

  TeachersListModel.fromJson(Map<String, dynamic> json) {
    lastPageNumber = json['lastPageNumber'];

    if (json['data'] != null) {
      teachersList = [];
      json['data'].forEach((element) {
        teachersList!.add(TeacherData.fromJson(element));
      });
    }
  }
}

class TeacherData {
  int? teacher_id;
  String? name;
  String? gender;
  int? salary;
  String? phone_number;

  TeacherData.fromJson(Map<String, dynamic> json) {
    teacher_id = json['id'];
    name = json['name'];
    gender = json['gender'];
    salary = json['salary'];
    phone_number = json['phone_number'];

  }
}


class Teachers {

  final name;
  final gender;
  final salary;
  final phone;
  //final number_of_hasses;

  const Teachers({required this.name,required this.gender,required this.salary,required this.phone});

}

final teachersList = <Teachers>[
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),
  Teachers(name: 'Mike', gender: 'Male', salary: '2000000', phone: '09234234435345'),


];