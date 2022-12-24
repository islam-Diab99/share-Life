abstract class AppStates{}
class AppInitialState extends AppStates{}
class AppGetUserSuccessState extends AppStates{}
class AppGetUserLoadingState extends AppStates{}
class AppGetUserErrorState extends AppStates{
  String error;
  AppGetUserErrorState(this.error);

}




class AppGetAllUserSuccessState extends AppStates{}
class AppGetAllUserLoadingState extends AppStates{}
class AppGetAllUserErrorState extends AppStates{
  String error;
  AppGetAllUserErrorState(this.error);

}

class AppChangeBottomNavBarState extends AppStates{}
class NewPostScreenState extends AppStates{}
class PickProfileImageSuccessState extends AppStates{}
class PickCoverImageSuccessState extends AppStates{}
class UploadProfileImageErrorState extends AppStates{}
class UploadProfileImageSuccessState extends AppStates{}
class UploadCoverImageErrorState extends AppStates{}
class UploadCoverImageSuccessState extends AppStates{}

class CreatePostLoadingState extends AppStates{}
class CreatePostSuccessState extends AppStates{}
class CreatePostErrorState extends AppStates{}

class UploadPostImageSuccessState extends AppStates{}
class UploadPostImageErrorState extends AppStates{}
class RemovePostImageState extends AppStates{}


class AppGetPostsSuccessState extends AppStates{}
class AppGetPostsLoadingState extends AppStates{}
class AppGetPostsErrorState extends AppStates{
  String error;
  AppGetPostsErrorState(this.error);

}

class AppLikePostsSuccessState extends AppStates{}
class AppLikePostsLoadingState extends AppStates{}
class AppLikePostsErrorState extends AppStates{
  String error;
  AppLikePostsErrorState(this.error);

}

class SendMessageSuccessState extends AppStates{}

class SendMessageErrorState extends AppStates{
  String error;
  SendMessageErrorState(this.error);

}

class GetMessageSuccessState extends AppStates{}