import 'dart:developer';
import 'dart:io';

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/models/error_model.dart';
import 'package:school_dashboard/models/teacher_register.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterCubitInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ErrorModel? errorModel;

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibility());
  }

  String? selectedValue;
  selectdropdown(value) {
    selectedValue = value;

    print(value);
    emit(Selectdropdown());
  }

  updatdropdown() {
    emit(Selectdropdown());
  }

  updatscreen() {
    emit(ResetDataState());
  }

  Icon? icongender = Icon(Icons.arrow_drop_down);
  //Color genderdropcolor = Colors.grey;
  // void changeSelectgender() {
  //   icongender = Icon(Icons.arrow_drop_up_outlined);
  //   //  genderdropcolor = Colors.blue;
  //   emit(Selectdropdown());
  // }

  bool myerror = false;
  changeStateSelect(value) {
    value == true ? myerror = true : myerror = false;
    print(value);

    emit(Selectdropdown());
  }

  Color buttonColor = Colors.lightBlue;
  Color buttonReset = Colors.lightBlue;
  FontWeight textbuttonweightcreat = FontWeight.w300;
  FontWeight textbuttonweightreset = FontWeight.w300;
  // TextStyle buttontextstyle(width) {
  //   return TextStyle(
  //       color: Colors.white,
  //       fontWeight: FontWeight.w500,
  //       fontSize: width * 0.015);
  // }

  void onexitc_creat(PointerEvent details) {
    buttonColor = Colors.lightBlue;
    textbuttonweightcreat = FontWeight.w400;
    print('onExit');

    emit(Selectdropdown());
  }

  void onenter_creat(PointerEvent details) {
    buttonColor = shadow;
    textbuttonweightcreat = FontWeight.w900;
    print('onHover');
    emit(Selectdropdown());
  }

  void onexitc_reset(PointerEvent details) {
    buttonReset = Colors.lightBlue;
    textbuttonweightreset = FontWeight.w400;
    print('onExit');

    emit(Selectdropdown());
  }

  void onenter_reset(PointerEvent details) {
    buttonReset = Color.fromARGB(175, 177, 20, 9);
    textbuttonweightreset = FontWeight.w900;
    print('onHover');
    emit(Selectdropdown());
  }

  var listTecherLength = 1;
  void plusteacherlist() {
    listTecherLength = listTecherLength + 1;
    subjects.add([]);
    // valueClassTeacher.add([]);
    emit(updatedlengthteacherlist());
  }

  void minteacherlist() {
    if (listTecherLength > 1) listTecherLength = listTecherLength - 1;
    emit(updatedlengthteacherlist());
  }

  registerteacher? registerteachermodel;
  Future<void> RegisterTeacher(
      phone, name, email, password, gender, salary) async {
    String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
    print('apiiiiii liat $ListSubjectSendApi');
    DioHelper.postData(
      url: 'registerTeacher',
      data: {
        'phone_number': phone,
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
        'salary': salary,
        'subjects': ListSubjectSendApi,
      },
      token: token,
    ).then((value) {
      registerteachermodel = registerteacher.fromJson(value.data);
      if (registerteachermodel!.status == "true")
        sendimage(registerteachermodel!.id);
      print(value.data);
    }).catchError((error) {
      print(error.response.data);
      print('error');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorRegisterTeacher(errorModel!));
      print(error.toString());
    });
  }

  Future<void> sendimage(id) async {
    if (webimageteacher == null) {
      print('No image selected');

      String assetImage = 'assets/images/profile.png';
      ByteData byteData = await rootBundle.load(assetImage);
      Uint8List bytes = byteData.buffer.asUint8List();

      webimageteacher = bytes;
    }

    String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
    DioHelper.postDataImage(
      url: 'registerTeacherPhoto',
      data: FormData.fromMap({
        'id': id,
        'img': await MultipartFile.fromBytes(
          webimageteacher!,
          filename: filename,
          // contentType: MediaType('image', 'png'),
        ),
      }),
      token: token,
    );
  }

  void RegisterParents(phone, name, email, password, gender) {
    print('RegisterParents');
    DioHelper.postData(url: 'registerParent', data: {
      'phone_number': phone,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
    },token: token,).then((value) {
      print(value.data);
    }).catchError((error) {
      print(error.response.data);
      print('error');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorRegisterParent(errorModel!));
      print(error.toString());
    });
  }

  void RegisterAdmin(phone, name, email, password, gender, role) {
    DioHelper.postData(url: 'registerParent', data: {
      'phone_number': phone,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'role': role
    },token: token,).then((value) {
      print(value.data);
    }).catchError((error) {
      print(error.response.data);
      print('error');
      errorModel = ErrorModel.fromJson(error.response.data);

      emit(ErrorRegisterAdmin(errorModel!));

      print(error.toString());
    });
  }

  late List<dynamic> dataclass;
  void getClassesRegister() {
    DioHelper.getData(url: 'getClassesRegister',token: token,).then((value) {
      classStudent = [];
      dataclass = [];

      value.data['data'].forEach((v) {
        //print(v['grade']);
        classStudent.add(v['grade'].toString());
      });
      value.data['data'].forEach((v) {
        //print(v['grade']);
        dataclass.add(v);
      });
      // classstud = value.data['data'][1]['grade'];
      print(classStudent);
      print("dataclass iss $dataclass");
      emit(updatedropdown());
    }).catchError(onError);
  }

  late List<dynamic> datasection;
  void getSectionsRegister({required int classid}) {
    DioHelper.postData(url: 'getSectionsRegister', data: {
      'class_id': classid,
    },token: token,).then((value) {
      section = [];
      datasection = [];
      value.data['data'].forEach((v) {
        //print(v['grade']);
        section.add(v['number'].toString());
      });
      value.data['data'].forEach((v) {
        datasection.add(v);
      });
      // classstud = value.data['data'][1]['grade'];
      print(section);
      emit(updatedropdown());
    }).catchError(onError);
  }

  Uint8List? webimage;
  Uint8List? webimageteacher;
  //Uint8List webimage = Uint8List(8);
  Future<dynamic> mypickImage(bool isteacher) async {
    try {
      final XImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (XImage == null) return;

      //For Web
      if (isteacher)
        webimageteacher = await XImage.readAsBytes();
      else
        webimage = await XImage.readAsBytes();
    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());
  }

  Future<void> RegisterStudents(
      phone,
      name,
      email,
      password,
      gender,
      is_in_bus,
      left_for_bus,
      left_for_qusat,
      parent_id,
      section_id,
      address,
      birth_date) async {
    // emit(Loading());
    print(parent_id);
    print(email);
    if (webimage == null) {
      print('No image selected');

      String assetImage = 'assets/profile.png';
      ByteData byteData = await rootBundle.load(assetImage);
      Uint8List bytes = byteData.buffer.asUint8List();

      webimage = bytes;

      String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
      print(filename);
      DioHelper.postDataImage(
        url: 'registerStudent',
        data: FormData.fromMap({
          'phone_number': phone,
          'name': name,
          'email': email,
          'password': password,
          'gender': gender,
          'is_in_bus': is_in_bus,
          'left_for_bus': left_for_bus,
          'left_for_qusat': left_for_qusat,
          'parent_id': parent_id,
          'section_id': section_id,
          'address': address,
          'birth_date': birth_date,
          'img': await MultipartFile.fromBytes(
            webimage!,
            filename: filename,
            // contentType: MediaType('image', 'png'),
          ),
        },),token: token,
      ).then((value) {
        // emit(Success());
      }).catchError((error) {
        print(error.response.data);
        // emit(Error());
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(ErrorRegisterStudent(errorModel!));
        print(error.toString());
      });
    } else {
      String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
      print(filename);
      DioHelper.postDataImage(
        url: 'registerStudent',
        data: FormData.fromMap({
          'phone_number': phone,
          'name': name,
          'email': email,
          'password': password,
          'gender': gender,
          'is_in_bus': is_in_bus,
          'left_for_bus': left_for_bus,
          'left_for_qusat': left_for_qusat,
          'parent_id': parent_id,
          'section_id': section_id,
          'address': address,
          'birth_date': birth_date,
          'img': await MultipartFile.fromBytes(
            webimage!,
            filename: filename,
            // contentType: MediaType('image', 'png'),
          ),
        },),token: token,
      ).then((value) {
        print(value.data);
        //emit(Success());
      }).catchError((error) {
        errorModel = ErrorModel.fromJson(error.response.data);

        emit(ErrorRegisterStudent(errorModel!));

        print(error.response.data);
        // emit(Error());
        print(error.toString());
      });
    }
  }

  List<subject_teschermodelAPi> ListSubjectSendApi = [
    // subject_teschermodelAPi(
    //   class_student: 1,
    //   subject: 1,
    // )
  ];

  void addsubjectteatcher(class_student, subject) {
    print('cc $class_student ss $subject');
    ListSubjectSendApi.add(subject_teschermodelAPi(
        class_student: class_student, subject: subject));
  }

  String? valueclassStudent;
  String? valuesubject;

  List<String> itemlistsubjects = [];

  List<int> itemlistsubjectsid = [];

  late List<List<String>> subjects = [[]];
  //late List<String> valueClassTeacher = ['a', 'z'];

  late List<List<int>> subjectsid = [];

  void SubjectsRegister(id, index) {
    DioHelper.postData(url: 'getSubjectsRegister', data: {'id': id},token: token,)
        .then((value) {
      itemlistsubjects = [];
      itemlistsubjectsid = [];
      // subjects = [];
      // subjectsid = [];
      value.data['data'].forEach((v) {
        //print(v['grade']);

        itemlistsubjects.add(v['name'].toString());
        itemlistsubjectsid.add(v['id']);
      });
      subjects[index] = itemlistsubjects;
      // subjects.add(itemlistsubjects);
      subjectsid.add(itemlistsubjectsid);
      emit(updatedteacherlistview());
      print(itemlistsubjects);
      print(subjects);
      print(subjects[0]);
      // if (subjects.length == 2)
      //print(subjects[2]);
      print(subjectsid);

      // print(value.data);
      // ListSubjectStudent.add(value.data['data'].forEach((v) {
      //   //print(v['grade']);
      //   subjects.add(v['name'].toString());
      // }));
    }).catchError((error) {
      print(error.response.data);
      print('error');
      print(error.toString());
    });
  }
}

class subject_teschermodelAPi {
  final int? class_student;
  final int? subject;

  subject_teschermodelAPi({
    @required this.class_student,
    @required this.subject,
  });
  Map<dynamic, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saf_id'] = this.class_student;
    data['id'] = this.subject;

    return data;
  }
}
