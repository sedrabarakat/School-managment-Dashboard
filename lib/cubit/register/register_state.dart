import 'package:meta/meta.dart';

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