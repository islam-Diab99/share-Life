import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/social_login/cubit/states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


    void userLogin({
      required String email,
      required String password,
    }){
      emit(LoginLoadingState());
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password).then((value) {

            emit(LoginSuccessState(value.user!.uid));

      }).catchError((error){
        print(error.toString());
        emit(LoginErrorState(error.toString()));});

    }

  }

