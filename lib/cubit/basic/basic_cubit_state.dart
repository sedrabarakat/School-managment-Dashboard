part of 'basic_cubit.dart';

@immutable
abstract class Basic_State {}

class HomeInitial extends Basic_State {}

class Change_Route extends Basic_State {
  String route;
  Change_Route(this.route);
}

class ShowButtonScroll extends Basic_State {}


class LogoutLoadingState extends Basic_State{}
class LogoutSuccessState extends Basic_State{
  final LogoutModel logoutModel;

  LogoutSuccessState(this.logoutModel);
}
class LogoutErrorState extends Basic_State {
  final ErrorModel errorModel;

  LogoutErrorState(this.errorModel);
}