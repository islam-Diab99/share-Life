import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/social_register/cubit/states.dart';



class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
   required String name,
    required String email,
    required String password,
    required String phone,
  }){

    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {

     userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
     print(value.user!.uid);


    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
  required String name,
  required String email,
    required String phone,
    required String uId,


}){
    UserModel userModel =UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
      isEmailVerified: false,
        image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1656772722~exp=1656773322~hmac=dd30b2f430147736455ac06aee7b942f1125a6fa098ea63270e92eee447f0357&w=900',
        cover: 'https://img.freepik.com/free-vector/group-young-people-posing-photo_52683-18823.jpg?t=st=1656979975~exp=1656980575~hmac=f862ad85e3bfd9d218f0d12d5f8ee72ec4e87ba5db8f9c05b6be049535ad39a6&w=740',
        bio: 'write bio here...'
    );
    FirebaseFirestore.instance.collection('users').add(userModel.toMap()).
    then((value){
      emit(CreateUserSuccessState());
    }).catchError((error)  {emit(CreateUserErrorState());},);

}

}