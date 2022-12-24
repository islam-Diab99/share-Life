

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/message_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/addpost/add_post_screen.dart';
import 'package:shop_app/modules/chats/chat_screen.dart';
import 'package:shop_app/modules/feeds/feeds_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/modules/users/users_screen.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import '../constants.dart';
import '../models/post_model.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
UserModel? model;
void getUserData()
{
  uId =CacheHelper.getData(key: 'uId');

  emit(AppGetUserLoadingState());

  FirebaseFirestore.instance.collection('users').doc(uId).get().
  then((value) {
print(value.data()!);
    model=UserModel.fromJson(value.data()!);
    emit(AppGetUserSuccessState());
  }
  ).catchError((error){
    print(error.toString());
emit(AppGetUserErrorState(error.toString()));
  });
}

int currentIndex=0;
List<Widget> screens=[
  FeedsScreen(),
  ChatScreen(),
  NewPostScreen(),
  UsersScreen(),
  SettingsScreen()
];
List titles=[
  'Home',
  'Chats',
  'Add post' ,
  'Users',
  'settings'
];
void changeBottomNav(index){
  if(index==1)
 getUsers();
  if(index==2)
    emit(NewPostScreenState());
  else{
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }

}



  File?  profileImage;
  File?  coverImage;
  var picker=ImagePicker();
  Future<void> getProfileImage()async {
    final XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!=null){
      profileImage =File(pickedFile.path) ;



    }
    else print('no image selected');
    emit(PickProfileImageSuccessState());
  }

  Future<void> getCoverImage()async {
    final XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!=null){
      coverImage =File(pickedFile.path) ;


    }
    else print('no image selected');
    emit(PickCoverImageSuccessState());
  }

String profileImageUrl='';
  void uploadProfileImage(
      { required String name,
        required String phone,
        required String bio,}
      ){

    firebase_storage.FirebaseStorage.instance.ref().child(
        'users/${Uri.file(
            profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value){

              value.ref.getDownloadURL().then((value) {
                profileImageUrl=value;
                profileImage =null;
                emit(UploadProfileImageSuccessState());
                print(value);
                updateUser(name: name, phone: phone, bio: bio,image: value);


              }).catchError((error){
                emit(UploadProfileImageErrorState());
              });
    }).catchError((onError){
      emit(UploadProfileImageErrorState());
    });
  }
  String coverImageUrl='';
  void uploadCoverImage({ required String name,
    required String phone,
    required String bio,}
      ){

    firebase_storage.FirebaseStorage.instance.ref().child(
        'users/${Uri.file(
            coverImage!.path).pathSegments.last}').putFile(coverImage!).then((value){

      value.ref.getDownloadURL().then((value) {
        coverImage=null;
        emit(UploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);


      }).catchError((error){
        print(error.toString());
        emit(UploadCoverImageErrorState());

      });
    }).catchError((onError){
      emit(UploadCoverImageErrorState());
    });
  }
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }){


    UserModel userModel =UserModel(

        name: name,
        phone: phone,
        bio: bio,
        image:image??model!.image,
        cover: cover??model!.image,
        uId: model!.uId,
      email: model!.email,
        isEmailVerified: false

    );

    FirebaseFirestore.instance.collection('users').doc(model!.uId).update(userModel.toMap()).then((value) => getUserData()).
    catchError((error){});
  }



  void uploadPostImage({ String? name,
    String? uId,
    required String text,
    required String dateTime,
     String? image,


  }
      ){
emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child(
        'posts/${Uri.file(
            postImage!.path).pathSegments.last}').putFile(postImage!).then((value){

      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime,postImage: value);

        postImage=null;
        emit(UploadPostImageSuccessState());


      }).catchError((error){
        print(error.toString());
        emit(UploadPostImageErrorState());

      });
    }).catchError((onError){
      emit(UploadPostImageErrorState());
    });
  }


File? postImage;
  Future<void> getPostImage()async {
    final XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!=null){
      postImage =File(pickedFile.path) ;


    }
    else print('no image selected');
    emit(UploadPostImageSuccessState());
  }



  void createPost({


    required String dateTime,
    required String text,

    String? postImage,
  }){

emit(CreatePostLoadingState());
    PostModel postModel =PostModel(
        name: model?.name,
        image: model?.image,
        text: text,
        dateTime: dateTime,
      uId:model?.uId,
      postImage:postImage??''

    );


    FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then((value) =>emit(CreatePostSuccessState()) ).
    catchError((error){
      emit(CreatePostErrorState());
    });
  }

  void removePostImage(){
postImage=null;
emit(RemovePostImageState());
  }

  List<PostModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];
  void getPosts(){
FirebaseFirestore.instance.
collection('posts').get().then((value) {
  value.docs.forEach((element)
  {
    element.reference.collection('likes').get().then((
        value){
      likes.add(value.docs.length);
      postsId.add(element.id);
      posts.add(PostModel.fromJson(element.data()));
      emit(AppGetPostsSuccessState());
    }).catchError((error){});
    });

  print(posts);

}).catchError((error){
  emit(AppGetPostsErrorState(error.toString()));
  print(error.toString());
});

  }
void likePost(String postId)
{
  FirebaseFirestore.instance.collection(
      'posts').doc(postId).collection('likes').doc(
    model?.uId
  ).set({
    'like':true,
  }).
  then((value) {

    emit(AppLikePostsSuccessState());
  }).
  catchError((error){AppLikePostsErrorState(error.toString());});

}


List<UserModel>users=[];
  void getUsers(){
users=[];
    FirebaseFirestore.instance.
    collection('users').get().then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId']!=model?.uId)
        users.add(UserModel.fromJson(element.data()));
        emit(AppGetAllUserSuccessState());

      });
      }).catchError((error){emit(AppGetAllUserErrorState(error));});
  }


  void sendMessage({
  required String receiverId,
  required String dateTime,
    required String text,
}){
    MessageModel messageModel=MessageModel(
        text: text, dateTime: dateTime,
        receiverId: receiverId,
        senderId: model?.uId,
    );
    FirebaseFirestore.instance.collection('users').doc(model?.uId).
    collection('chats').doc(receiverId).collection('messages').add(messageModel.toMap()).
    then((value) => (){
      emit(SendMessageSuccessState());
    }).
    catchError((error){
      emit(SendMessageErrorState(error));
    });


    FirebaseFirestore.instance.collection('users').doc(receiverId ).
    collection('chats').doc(model?.uId).collection('messages').add(messageModel.toMap()).
    then((value) => (){
      emit(SendMessageSuccessState());
    }).
    catchError((error){
      emit(SendMessageErrorState(error));
    });

  }



  List<MessageModel>messages=[];
  getMessages(
  {
    required String receiverId,
}
      ){

    FirebaseFirestore.instance.collection('users').doc(model?.uId).collection('chats').doc(
      receiverId).collection('messages').orderBy('dateTime').snapshots().
    listen((event) {
      messages=[];
      event.docs.forEach((element) {

messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessageSuccessState());
    });
  }
}