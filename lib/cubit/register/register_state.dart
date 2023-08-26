import 'package:meta/meta.dart';
import 'package:school_dashboard/models/error_model.dart';

@immutable
abstract class RegisterState {}

class RegisterCubitInitial extends RegisterState {}
class ChangePasswordVisibility extends RegisterState {}
class Selectdropdown extends RegisterState {}
class ResetDataState extends RegisterState {}
class PickImage  extends RegisterState {}
class updatedropdown extends RegisterState {}
class updatedlengthteacherlist extends RegisterState {}
class updatedteacherlistview extends RegisterState {}

class ErrorRegisterStudent extends RegisterState {
  ErrorModel? errorModel;

  ErrorRegisterStudent(this.errorModel);
}
class ErrorRegisterParent extends RegisterState {
  ErrorModel? errorModel;

  ErrorRegisterParent(this.errorModel);
}
class ErrorRegisterAdmin extends RegisterState {
  ErrorModel? errorModel;

  ErrorRegisterAdmin(this.errorModel);
}
class ErrorRegisterTeacher extends RegisterState {
  ErrorModel? errorModel;

  ErrorRegisterTeacher(this.errorModel);
}
