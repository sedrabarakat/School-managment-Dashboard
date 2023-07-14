
class ParentsModel {
  bool? status;
  String? message;
  ParentsListModel? data;

  ParentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? ParentsListModel.fromJson(json['data']) : null;
  }
}

class ParentsListModel {
  int? lastPageNumber;
  List<ParentData>? parentsList;

  ParentsListModel.fromJson(Map<String, dynamic> json) {
    lastPageNumber = json['lastPageNumber'];

    if (json['data'] != null) {
      parentsList = [];
      json['data'].forEach((element) {
        parentsList!.add(ParentData.fromJson(element));
      });
    }
  }
}

class ParentData {
  int? parent_id;
  String? name;
  String? gender;
  String? phone_number;

  ParentData.fromJson(Map<String, dynamic> json) {
    parent_id = json['id'];
    name = json['name'];
    gender = json['gender'];
    phone_number = json['phone_number'];
  }
}


class Parents {

  final name;
  final gender;
  final phone;
  //final work;

  const Parents({required this.name,required this.gender,required this.phone});

}

final parentsList = <Parents>[
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),
  Parents(name: 'Jack', gender: 'Male', phone: '094324532324234'),



];