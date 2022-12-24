
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {
        if (state is CreatePostSuccessState)
          {
            Navigator.pop(context);
            showToast('Post has been added successfully');

          }
      },
      builder: (BuildContext context, Object? state) {

        return
          Scaffold(
            appBar:
            defaultAppBar(title: 'Create post',context: context
                ,
                actions: [defaultTextButton(function: (){
                  if(AppCubit.get(context).postImage==null){
                    AppCubit.get(context).createPost(dateTime: DateTime.now().toString(), text: textController.text);
                  }
                  else{
                    AppCubit.get(context).uploadPostImage(dateTime: DateTime.now().toString(), text: textController.text,);

                  }
                }, text:'post')]
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(AppCubit.get(context).model!.image!
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Text(
                          AppCubit.get(context).model!.name!,
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: 'what is in your mind',
                        border: InputBorder.none

                      ),
                    ),
                  ),
                  if(AppCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0,),
                            image: DecorationImage(
                              image: FileImage(AppCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: ()
                          {
AppCubit.get(context).removePostImage();
                          },
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(onPressed: (){
                          AppCubit.get(context).getPostImage();
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                           Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text('Add Photo')
                          ],
                        )),
                      ),
                      Expanded(child: TextButton(onPressed: (){}, child: Text('#Tags')))
                    ],
                  )
                ],
              ),
            ),

          );
      },

    );
  }
}
