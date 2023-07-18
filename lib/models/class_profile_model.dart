class class_profile_model {
  bool? status;
  Data? data;

  class_profile_model({this.status, this.data});

  class_profile_model.fromJson(Map<String, dynamic> json) {
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
  int? pupilsInClass;
  List<Subjects>? subjects;
  List<SectionsInClass>? sectionsInClass;

  Data({this.pupilsInClass, this.subjects, this.sectionsInClass});

  Data.fromJson(Map<String, dynamic> json) {
    pupilsInClass = json['pupilsInClass'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    if (json['sectionsInClass'] != null) {
      sectionsInClass = <SectionsInClass>[];
      json['sectionsInClass'].forEach((v) {
        sectionsInClass!.add(new SectionsInClass.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pupilsInClass'] = this.pupilsInClass;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    if (this.sectionsInClass != null) {
      data['sectionsInClass'] =
          this.sectionsInClass!.map((v) => v.toJson()).toList();
    }
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

class SectionsInClass {
  int? id;
  int? number;
  int? numberOfStudent;

  SectionsInClass({this.id, this.number, this.numberOfStudent});

  SectionsInClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    numberOfStudent = json['numberOfStudent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['numberOfStudent'] = this.numberOfStudent;
    return data;
  }
}