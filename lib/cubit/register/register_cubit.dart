import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
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

  Uint8List? webImageStudent;
  Uint8List? webImageTeacher;

  Future<dynamic> myPickImage(bool isteacher) async {
    try {
      final XImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (XImage == null) return;

      //For Web
      if (isteacher) {
        webImageTeacher = await XImage.readAsBytes();
      } else {
        webImageStudent = await XImage.readAsBytes();
      }
    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());
  }

////////////////////////////////////////////////////////////////////////////////

  //Parent

  var nameParentController = TextEditingController();
  var emailParentController = TextEditingController();
  var passwordParentController = TextEditingController();
  var genderParentController = TextEditingController();
  var phoneParentController = TextEditingController();
  String? valueGenderParent;

  void clearParentControllers() {
    nameParentController.clear();

    emailParentController.clear();

    passwordParentController.clear();

    genderParentController.clear();

    phoneParentController.clear();

    valueGenderParent = null;

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

  var nameAdminController = TextEditingController();
  var emailAdminController = TextEditingController();
  var passwordAdminController = TextEditingController();
  var genderAdminController = TextEditingController();
  var phoneAdminController = TextEditingController();

  String? valueGenderAdmin;
  String? valueRoleAdmin;

  void clearAdminControllers() {
    nameAdminController.clear();

    emailAdminController.clear();

    passwordAdminController.clear();

    genderAdminController.clear();

    phoneAdminController.clear();

    valueGenderAdmin = null;

    valueRoleAdmin = null;

    emit(ResetDataState());
  }

  void registerAdmin(phone, name, email, password, gender, role) async {
    isLoading = true;
    emit(LoadingRegister());
    DioHelper.postData(
      url: 'registerAdmin',
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
  String? valueGenderStudent;
  String? valueInBus;
  String? valueClassStudent;
  String? valueSectionStudent;
  String? valueDateTimeStudent;
  int? classId;
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

    webImageStudent = null;

    valueGenderStudent = null;
    valueInBus = null;
    valueClassStudent = null;
    valueSectionStudent = null;
    iserrorgender = false;
    iserrorinbus = false;
    iserrorsection = false;
    iserrorclassStudent = false;
    sectionId = null;
    valueDateTimeStudent = null;
    section = [];

    emit(ResetDataState());
  }

  List<dynamic> datasectionst = [];

  void getSectionsRegisterForStudent({required int classId}) {
    print("Calling getSectionsRegisterForStudent...");
    DioHelper.postData(url: 'getSectionsRegister', data: {
      'class_id': classId,
    },token: token,).then((value) {
      section = [];
      datasectionst = [];
      value.data['data'].forEach((v) {
        section.add(v['number'].toString());
      });
      value.data['data'].forEach((v) {
        datasectionst.add(v);
      });
      emit(UpdateDropdown());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      print(error.toString());
    });

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
    if (left_for_bus == null ||
        left_for_bus == '' ||
        int.parse(left_for_bus) <= 0) {
      in_in_bus = 0;
      leftybusy = 0;
    } else {
      in_in_bus = 1;
      leftybusy = left_for_bus;
    }
    isLoading = true;
    emit(LoadingRegister());
    if (webImageStudent == null) {
      print('No image selected');
      String assetImage = 'assets/images/user.png';
      ByteData byteData = await rootBundle.load(assetImage);
      Uint8List bytes = byteData.buffer.asUint8List();
      webImageStudent = bytes;
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
              webImageStudent!,
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
              webImageStudent!,
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
  //Teacher

  var nameTeacherController = TextEditingController();
  var emailTeacherController = TextEditingController();
  var passwordTeacherController = TextEditingController();
  var genderTeacherController = TextEditingController();
  var phoneTeacherController = TextEditingController();
  var salaryTeacherController = TextEditingController();
  String? valueGenderTeacher;

///////////
  // init
  String? valueClassTeacher;
  String? valueSubjectTeacher;


  //Lists
  List<dynamic> valueClassTeacherList = [];
  List<dynamic> valueSubjectTeacherList = [];
  List<List<String>> subjects = [];

  //Value List to Send
  List<int> classesIds = [];
  List<int> subjectsIds = [];

///////////
  //Array of Objects
  List<SubjectTeacherModelAPi> safsToTeach = [];

  void clearTeachersControllers() {

    webImageTeacher = null;

    nameTeacherController.clear();

    emailTeacherController.clear();

    passwordTeacherController.clear();

    genderTeacherController.clear();

    phoneTeacherController.clear();

    salaryTeacherController.clear();

    valueGenderTeacher = null;

    valueClassTeacherList.clear();
    valueSubjectTeacherList.clear();

    subjects.clear();

    classesIds.clear();
    subjectsIds.clear();

    safsToTeach.clear();

    listTeacherLength = 0;

    emit(ResetDataState());
  }

  void addOneObject(
    dynamic safsId,
    dynamic subjectId,
  ) {
    safsToTeach.add(SubjectTeacherModelAPi(
      safId: safsId,
      subjectId: subjectId,
    ));
  }

  void addAllObjects() {
    print('adding objects...');
    for (int i = 0; i < subjectsIds.length; i++) {
      if (subjectsIds[i] != 0) {
        addOneObject(
          classesIds[i],
          subjectsIds[i],
        );
      }
    }
  }

//////////////////////////////
  var listTeacherLength = 0;

  void plusTeacherList() {
    subjects.add([]);
    listTeacherLength = listTeacherLength + 1;

    print(listTeacherLength);
    emit(UpdatedLengthTeacherList());
  }

  void minTeacherList() {
    if (listTeacherLength > 0){
      listTeacherLength = listTeacherLength - 1;
      print(listTeacherLength);
      //
      if (valueClassTeacherList.length > listTeacherLength) {
        valueClassTeacherList.removeLast();
      }
      if (valueSubjectTeacherList.length > listTeacherLength) {
        valueSubjectTeacherList.removeLast();
      }
      //
      if (classesIds.length > listTeacherLength) {
        classesIds.removeLast();
      }
      if (subjectsIds.length > listTeacherLength) {
        subjectsIds.removeLast();
      }
      //
      if (safsToTeach.length > listTeacherLength) {
        safsToTeach.removeLast();
      }

      print('classesIds=');
      print(classesIds);
      print('subjectsIds=');
      print(subjectsIds);

      emit(UpdatedLengthTeacherList());
    }
  }

/////////////////////////////

  registerteacher? registerTeacherModel;

  Future<void> registerTeacher(
      phone, name, email, password, gender, salary) async {
    addAllObjects();
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
        'subjects': safsToTeach,
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

///////
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
        })).then((value) {
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

  //////////////////////////////////////////////////////////////////////////////

  // Get classes and sections and adding subjects

  List<dynamic> dataclass = [];

  void getClassesRegister() {
    classStudent = [];
    DioHelper.getData(
      url: 'getClassesRegister',
      token: token,
    ).then((value) {
      value.data['data'].forEach((v) {
        classStudent.add(v['grade'].toString());
      });
////
      dataclass = [];
      value.data['data'].forEach((v) {
        dataclass.add(v);
      });
      print('classStudent=$classStudent');
      print('dataclass=$dataclass');
      emit(UpdateDropdown());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      print(error.toString());
    });
  }

  List<dynamic> dataSubject = [];

  void getSubjectsRegister(id,index) {
    if (classesIds.length == index) {
      classesIds.add(0);
    }
    classesIds[index] = id;
    DioHelper.postData(
      url: 'getSubjectsRegister',
      data: {'id': id},
      token: token,
    ).then((value) {
      List<String> subject = [];
      value.data['data'].forEach((v) {
        subject.add(v['name'].toString());
      });

      if (subjects.length == index) {
        subjects.add([]);
      }
      subjects[index] = subject;
      print('sub=$subject');


      if (subjectsIds.length == index) {
        subjectsIds.add(0);
      }
      subjectsIds[index] = 0;

//
//
      dataSubject = [];
      value.data['data'].forEach((v) {
        dataSubject.add(v);
      });


      print('subjects=$subjects');
      print('dataSubject=$dataSubject');

      print('classesIds=');
      print(classesIds);
      print('subjectsIds=');
      print(subjectsIds);
      emit(UpdatedTeacherListview());
    }).catchError((error) {
      print(error.response.data);
      print('error');
      print(error.toString());
    });
  }
}

class SubjectTeacherModelAPi {
  final int? safId;
  final int? subjectId;

  SubjectTeacherModelAPi({
    required this.safId,
    required this.subjectId,
  });

  Map<dynamic, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saf_id'] = safId;
    data['id'] = subjectId;

    return data;
  }
}
