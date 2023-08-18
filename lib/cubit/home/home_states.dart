abstract class Home_State{}

class init_Home extends Home_State{}


class Loading_Get_Home extends Home_State{}

class Success_Get_Home extends Home_State{}

class Error_Get_Home extends Home_State{
  String error;
  Error_Get_Home(this.error);
}