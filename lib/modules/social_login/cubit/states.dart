abstract class LoginStates{}
class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates {
  String error;
  LoginErrorState(this.error);


}
class ChangePasswordVisibilityState extends LoginStates {}