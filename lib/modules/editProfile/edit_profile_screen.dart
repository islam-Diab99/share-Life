
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/components.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var userModel=AppCubit.get(context).model;
        var nameController=TextEditingController();
        var bioController=TextEditingController();
        var phoneController=TextEditingController();
        nameController.text='${userModel?.name}';
        bioController.text='${userModel?.bio}';
        phoneController.text='${userModel?.phone}';
        var profileImage=AppCubit.get(context).profileImage;
        var coverImage=AppCubit.get(context).coverImage;


        return  Scaffold(
          appBar:
          defaultAppBar(title: 'Edit Profile',context:context,actions:[
            defaultTextButton(
                function: (){
                  AppCubit.get(context).updateUser(name:nameController.text, phone:phoneController.text, bio:bioController.text);
                }, text: 'Save')
          ]
          ),

              body:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
          children: [
            Container(
                height: 180,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(

                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(

                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft:  Radius.circular(4),
                                    topRight: Radius.circular(4)
                                ),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage!=null?FileImage(coverImage) as ImageProvider:
                                    NetworkImage('${userModel?.cover}')
                                )
                            ),
                          ),
                          IconButton(onPressed: (){
                            AppCubit.get(context).getCoverImage();
                          }, icon:CircleAvatar(
                            radius: 20,
                              child: Icon(IconBroken.Camera,color: Colors.white,)) )
                        ],
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).scaffoldBackgroundColor,


                      ),
                      child:
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                                radius: 60,

                                backgroundImage:profileImage!=null?FileImage(profileImage ) as ImageProvider: NetworkImage('${userModel?.image}')

                            ),
                        IconButton(onPressed: (){
                          AppCubit.get(context).getProfileImage();
                        }, icon:CircleAvatar(
                            radius: 20,
                            child: Icon(IconBroken.Camera,color: Colors.white,)))

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(height: 5,),
            if(AppCubit.get(context).profileImage!=null||AppCubit.get(context).coverImage!=null)
            Row(
              children: [
                if(AppCubit.get(context).profileImage!=null)
                Expanded(child: defaultTextButton(function: (){
                  AppCubit.get(context).uploadProfileImage(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                  );
                }, text:'upload profile')),
                if(AppCubit.get(context).coverImage!=null)
                Expanded(child: defaultTextButton(function: (){
                  AppCubit.get(context).uploadCoverImage(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                }, text: 'upload cover')),

              ],
            ),

            defaultFormField(
                controller: nameController,
                inputType: TextInputType.name,
                validate: (String? value)
                {
                  if(value!.isEmpty){
                    return 'name must not be Empty';

                  }
                  return null;
                },
              suffix: IconBroken.Profile
            ),
            SizedBox(height: 10,),

            defaultFormField(
                controller: bioController,
                inputType: TextInputType.name,
                validate: (String? value)
                {
                  if(value!.isEmpty){
                    return 'name must not be Empty';

                  }
                  return null;
                },
                suffix: IconBroken.Info_Circle
            ),
            SizedBox(height: 10,),

            defaultFormField(
                controller: phoneController,
                inputType: TextInputType.name,
                validate: (String? value)
                {
                  if(value!.isEmpty){
                    return 'phone must not be Empty';

                  }
                  return null;
                },
                suffix: IconBroken.Info_Circle
            ),



          ],
      ),
              ) ,
      );
        },

    );
  }
}
