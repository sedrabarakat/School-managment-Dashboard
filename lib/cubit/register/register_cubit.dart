import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/cubit/teachers/teachers_list_cubit.dart';
import 'package:school_dashboard/models/error_model.dart';
import 'package:school_dashboard/models/teacher_register.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterCubitInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ErrorModel? errorModel;

  bool? isLoading = false;

  //////////////////////////////////////////////////////////////////////////////
  // Password

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibility());
  }

  //////////////////////////////////////////////////////////////////////////////
  // Dropdown

  String? selectedValue;

  selectDropdown(value) {
    selectedValue = value;
    emit(SelectDropdown());
  }

  updateDropdown() {
    emit(SelectDropdown());
  }

  //////////////////////////////////////////////////////////////////////////////
  // Buttons Animation

  Color buttonColor = Colors.lightBlue;
  Color buttonReset = Colors.lightBlue;
  FontWeight textButtonWeightCreate = FontWeight.w300;
  FontWeight textButtonWeightReset = FontWeight.w300;

  void onEnterCreate(PointerEvent details) {
    buttonColor = shadow;
    textButtonWeightCreate = FontWeight.w900;
    print('onHover');
    emit(SelectDropdown());
  }

  void onExitCreate(PointerEvent details) {
    buttonColor = Colors.lightBlue;
    textButtonWeightCreate = FontWeight.w400;
    print('onExit');
    emit(SelectDropdown());
  }

  void onEnterReset(PointerEvent details) {
    buttonReset = const Color.fromARGB(175, 177, 20, 9);
    textButtonWeightReset = FontWeight.w900;
    print('onHover');
    emit(SelectDropdown());
  }

  void onExitReset(PointerEvent details) {
    buttonReset = Colors.lightBlue;
    textButtonWeightReset = FontWeight.w400;
    print('onExit');
    emit(SelectDropdown());
  }


  //////////////////////////////////////////////////////////////////////////////
  // Pick Image

  Uint8List? webImage;
  Uint8List? webImageTeacher;

  Future<dynamic> myPickImage(bool isteacher) async {
    try {
      final XImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (XImage == null) return;

      //For Web
      if (isteacher) {
        webImageTeacher = await XImage.readAsBytes();
      } else {
        webImage = await XImage.readAsBytes();
      }
    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());
  }


  //////////////////////////////////////////////////////////////////////////////
  //Teacher

  var nameTeacherController = TextEditingController();
  var emailTeacherController = TextEditingController();
  var passwordTeacherController = TextEditingController();
  var genderTeacherController = TextEditingController();
  var phoneTeacherController = TextEditingController();
  var salaryTeacherController = TextEditingController();
  bool? valueGenderTeacher;
  String? teValueGender;
  String? teValueClassStudent;
  String? teValueSubject;

  void clearTeachersControllers() {
    nameTeacherController.clear();

    emailTeacherController.clear();

    passwordTeacherController.clear();

    genderTeacherController.clear();

    phoneTeacherController.clear();

    salaryTeacherController.clear();

    valueGenderTeacher = null;

    teValueGender = null;

    teValueClassStudent = null;

    teValueSubject = null;

    webImageTeacher = null;

    emit(ResetDataState());
  }

  var listTeacherLength = 1;

  void plusTeacherList() {
    listTeacherLength = listTeacherLength + 1;
    subjects.add([]);
    // valueClassTeacher.add([]);
    emit(UpdatedLengthTeacherList());
  }

  void minTeacherList() {
    if (listTeacherLength > 1) listTeacherLength = listTeacherLength - 1;
    emit(UpdatedLengthTeacherList());
  }

  registerteacher? registerTeacherModel;

  Future<void> registerTeacher(
      phone, name, email, password, gender, salary) async {
    isLoading = true;
    emit(LoadingRegister());
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
      registerTeacherModel = registerteacher.fromJson(value.data);
      if (value.data['status']) {
        print('hahaha');
        sendTeacherImage(registerTeacherModel!.id);
      }
      print(value.data);
    }).catchError((error) {
      print(error.response.data);
      print('error');
      isLoading = false;
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorRegisterTeacher(errorModel!));
      print(error.toString());
    });
  }

  Future<void> sendTeacherImage(id) async {
    if (webImageTeacher == null) {
      print('No image selected');
      String assetImage = 'assets/images/profile.png';
      ByteData byteData = await rootBundle.load(assetImage);
      Uint8List bytes = byteData.buffer.asUint8List();
      webImageTeacher = bytes;
    }
    String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
    DioHelper.postDataImage(
      url: 'registerTeacherPhoto',
      token: token,
      data: FormData.fromMap({
        'id': id,
        'img': await MultipartFile.fromBytes(
          webImageTeacher!,
          filename: filename,
          // contentType: MediaType('image', 'png'),
        ),
      })
    ).then((value) {
      print(value.data);
      isLoading = false;
      emit(SuccessRegisterTeacher());
    }).catchError((error) {
      print(error.response.data);
      print('error');
      isLoading = false;
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorRegisterTeacher(errorModel!));
      print(error.toString());
    });
  }

////////////////////////////////////////////////////////////////////////////////

  //Parent

  var nameParentController = TextEditingController();
  var emailParentController = TextEditingController();
  var passwordParentController = TextEditingController();
  var genderParentController = TextEditingController();
  var phoneParentController = TextEditingController();
  String? valueGender;

  void clearControllers() {
    nameParentController.clear();

    emailParentController.clear();

    passwordParentController.clear();

    genderParentController.clear();

    phoneParentController.clear();

    valueGender = null;

    emit(ResetDataState());
  }

  void registerParents(phone, name, email, password, gender) {
    print('RegisterParents');
    isLoading = true;
    emit(LoadingRegister());
    DioHelper.postData(
      url: 'registerParent',
      data: {
        'phone_number': phone,
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
      },
      token: token,
    ).then((value) {
      print(value.data);
      isLoading = false;
      emit(SuccessRegisterParent());
    }).catchError((error) {
      print(error.response.data);
      print('error');
      isLoading = false;
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorRegisterParent(errorModel!));
      print(error.toString());
    });
  }

////////////////////////////////////////////////////////////////////////////////

  //Admin
  void registerAdmin(phone, name, email, password, gender, role) async {
    isLoading = true;
    emit(LoadingRegister());
    DioHelper.postData(
      url: 'registerParent',
      data: {
        'phone_number': phone,
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
        'role': role
      },
      token: token,
    ).then((value) {
      print(value.data);
      isLoading = false;
      emit(SuccessRegisterAdmin());
    }).catchError((error) {
      print(error.response.data);
      print('error');
      errorModel = ErrorModel.fromJson(error.response.data);
      isLoading = false;
      emit(ErrorRegisterAdmin(errorModel!));

      print(error.toString());
    });
  }

  //////////////////////////////////////////////////////////////////////////////

  //Student
  var nameStudentController = TextEditingController();
  var emailStudentController = TextEditingController();
  var passwordStudentController = TextEditingController();
  var genderStudentController = TextEditingController();
  var phoneStudentController = TextEditingController();
  var addressStudentController = TextEditingController();
  var leftBusController = TextEditingController();
  var leftTuitionFeesController = TextEditingController();
  var birthDateController = TextEditingController();
  String? Valuegender;
  String? Valueinbus;
  String? valueclassStudent;
  String? valuesection;
  String? datetime;
  late int classId;
  int? sectionId;

  bool? iserrorgender = false;
  bool? iserrorinbus = false;
  bool? iserrorsection = false;
  bool? iserrorclassStudent = false;

  void clearStudentControllers() {
    nameStudentController.clear();

    emailStudentController.clear();

    passwordStudentController.clear();

    genderStudentController.clear();

    phoneStudentController.clear();

    addressStudentController.clear();

    leftBusController.clear();

    leftTuitionFeesController.clear();

    birthDateController.clear();

    webImage = null;

    Valuegender = null;
    Valueinbus = null;
    datetime = null;
    valueclassStudent = null;
    valuesection = null;
    iserrorgender = false;
    iserrorinbus = false;
    iserrorsection = false;
    iserrorclassStudent = false;
    datetime = null;
    sectionId = null;
    section = [];

    emit(ResetDataState());
  }

  Future<void> registerStudents(
      phone,
      name,
      email,
      password,
      gender,
      left_for_bus,
      left_for_qusat,
      parent_id,
      section_id,
      address,
      birth_date) async {
    int in_in_bus = 0;
    dynamic leftybusy = 0;
    if (left_for_bus == null || left_for_bus == '' || int.parse(left_for_bus) <= 0) {
      in_in_bus = 0;
      leftybusy= 0;
    }
    else {
      in_in_bus = 1;
      leftybusy = left_for_bus;
    }
    isLoading = true;
    emit(LoadingRegister());
    if (webImage == null) {
      print('No image selected');
      String assetImage = 'assets/images/user.png';
      ByteData byteData = await rootBundle.load(assetImage);
      Uint8List bytes = byteData.buffer.asUint8List();
      webImage = bytes;
      String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
      print(filename);
      DioHelper.postDataImage(
        url: 'registerStudent',
        data: FormData.fromMap(
          {
            'phone_number': phone,
            'name': name,
            'email': email,
            'password': password,
            'gender': gender,
            'is_in_bus': in_in_bus,
            'left_for_bus': leftybusy,
            'left_for_qusat': left_for_qusat,
            'parent_id': parent_id,
            'section_id': section_id,
            'address': address,
            'birth_date': birth_date,
            'img': await MultipartFile.fromBytes(
              webImage!,
              filename: filename,
              // contentType: MediaType('image', 'png'),
            ),
          },
        ),
        token: token,
      ).then((value) {
        isLoading = false;
        emit(SuccessRegisterStudent());
      }).catchError((error) {
        print(error.response.data);
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(ErrorRegisterStudent(errorModel!));
        isLoading = false;
        print(error.toString());
      });
    } else {
      String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
      print(filename);
      DioHelper.postDataImage(
        url: 'registerStudent',
        data: FormData.fromMap(
          {
            'phone_number': phone,
            'name': name,
            'email': email,
            'password': password,
            'gender': gender,
            'is_in_bus': in_in_bus,
            'left_for_bus': leftybusy,
            'left_for_qusat': left_for_qusat,
            'parent_id': parent_id,
            'section_id': section_id,
            'address': address,
            'birth_date': birth_date,
            'img': await MultipartFile.fromBytes(
              webImage!,
              filename: filename,
              // contentType: MediaType('image', 'png'),
            ),
          },
        ),
        token: token,
      ).then((value) {
        isLoading = false;
        print(value.data);
        emit(SuccessRegisterStudent());
      }).catchError((error) {
        isLoading = false;
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(ErrorRegisterStudent(errorModel!));
        print(error.response.data);
        print(error.toString());
      });
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  // Get classes and sections and adding subjects

  late List<dynamic> dataclass;

  void getClassesRegister() {
    DioHelper.getData(
      url: 'getClassesRegister',
      token: token,
    ).then((value) {
      classStudent = [];
      dataclass = [];
      value.data['data'].forEach((v) {
        classStudent.add(v['grade'].toString());
      });
      value.data['data'].forEach((v) {
        dataclass.add(v);
      });
      emit(updateDropdown());
    }).catchError(onError);
  }

  late List<dynamic> datasection;

  void getSectionsRegister({required int classid}) {
    DioHelper.postData(
      url: 'getSectionsRegister',
      data: {
        'class_id': classid,
      },
      token: token,
    ).then((value) {
      section = [];
      datasection = [];
      value.data['data'].forEach((v) {
        section.add(v['number'].toString());
      });
      value.data['data'].forEach((v) {
        datasection.add(v);
      });
      // classstud = value.data['data'][1]['grade'];
      print(section);
      emit(updateDropdown());
    }).catchError(onError);
  }

  List<SubjectTeacherModelAPi> ListSubjectSendApi = [];

  void addSubjectTeacher(class_student, subject) {
    print('cc $class_student ss $subject');
    ListSubjectSendApi.add(
        SubjectTeacherModelAPi(classStudent: class_student, subject: subject));
  }

  String? valueSubject;

  List<String> itemListSubjects = [];

  List<int> itemListSubjectsId = [];

  late List<List<String>> subjects = [[]];

  late List<List<int>> subjectsid = [];

  void subjectsRegister(id, index) {
    DioHelper.postData(
      url: 'getSubjectsRegister',
      data: {'id': id},
      token: token,
    ).then((value) {
      itemListSubjects = [];
      itemListSubjectsId = [];
      value.data['data'].forEach((v) {
        itemListSubjects.add(v['name'].toString());
        itemListSubjectsId.add(v['id']);
      });
      subjects[index] = itemListSubjects;
      subjectsid.add(itemListSubjectsId);
      emit(UpdatedTeacherListview());
      print(itemListSubjects);
      print(subjects);
      print(subjects[0]);
      print(subjectsid);
    }).catchError((error) {
      print(error.response.data);
      print('error');
      print(error.toString());
    });
  }
}

class SubjectTeacherModelAPi {
  final int? classStudent;
  final int? subject;

  SubjectTeacherModelAPi({
    required this.classStudent,
    required this.subject,
  });

  Map<dynamic, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saf_id'] = classStudent;
    data['id'] = subject;

    return data;
  }
}