abstract class inbox_states{}

class init_inbox_state extends inbox_states{}

class Loading_get_inbox extends inbox_states{}

class Success_get_inbox extends inbox_states{}

class Error_get_inbox extends inbox_states{
  String error;
  Error_get_inbox(this.error);
}