
class AdminsModel {
  bool? status;
  String? message;
  AdminsListModel? data;

  AdminsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    data = json['data'] != null ? AdminsListModel.fromJson(json['data']) : null;
  }
}

class AdminsListModel {
  int? lastPageNumber;
  List<AdminData>? adminsList;

  AdminsListModel.fromJson(Map<String, dynamic> json) {
    lastPageNumber = json['lastPageNumber'];

    if (json['data'] != null) {
      adminsList = [];
      json['data'].forEach((element) {
        adminsList!.add(AdminData.fromJson(element));
      });
    }
  }
}

class AdminData {
  int? admin_id;
  String? name;
  String? role;
  String? email;

  AdminData.fromJson(Map<String, dynamic> json) {
    admin_id = json['id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
  }
}


class Admins {

  final name;
  final phone;
  final role;
  //final email;
  //final gender;

  const Admins({required this.name,required this.phone,required this.role,});

}

final adminsList = <Admins>[
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),
  Admins(name: 'moallem', phone: '+932437534728', role: 'Ameen mostaodaa'),


];