abstract class Library_states{}

class Library_init_state extends Library_states{}

class Add_Cover_state extends Library_states{}

class Loading_Add_Book extends Library_states{}

class Success_Add_Book extends Library_states{}

class Error_Add_Book extends Library_states{
  String error;
  Error_Add_Book(this.error);
}

class Loading_Delete_Book extends Library_states{}

class Success_Delete_Book extends Library_states{}

class Error_Delete_Book extends Library_states{
  String error;
  Error_Delete_Book(this.error);
}


class Loading_Book_List extends Library_states{}

class Success_Book_List extends Library_states{}

class Error_Book_List extends Library_states{
  String error;
  Error_Book_List(this.error);
}


class Loading_Confirm extends Library_states{}

class Success_Confirm extends Library_states{}

class Error_Confirm extends Library_states{
  String error;
  Error_Confirm(this.error);
}

class Loading_DisConfirm extends Library_states{}

class Success_DisConfirm extends Library_states{}

class Error_DisConfirm extends Library_states{
  String error;
  Error_DisConfirm(this.error);
}

