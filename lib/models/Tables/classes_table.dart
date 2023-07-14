
class  ClassesModel {
  bool? status;
  String? message;
  List<ClassData>? classesList;

  ClassesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    if (json['data'] != null) {
      classesList = [];
      json['data'].forEach((element) {
        classesList!.add(ClassData.fromJson(element));
      });
    }
  }
}


class ClassData {
  int? class_id;
  int? grade;
  int? sections;
  int? students;
  int? teachers;
  int? subjects;

  ClassData.fromJson(Map<String, dynamic> json) {
    class_id = json['id'];
    grade = json['grade'];
    sections = json['sectionSize'];
    students = json['studentSize'];
    teachers = json['teacherSize'];
    subjects = json['subjectSize'];
  }
}

class Classes {

  final grade;
  final sections;
  final students;
  final teachers;
  final subjects;

  const Classes({required this.grade,required this.sections,required this.students,required this.teachers, required this.subjects,});

}

final classesList = <Classes>[
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),
  Classes(grade: '4', sections: '5', students: '12', teachers: '2', subjects: '7',),


];