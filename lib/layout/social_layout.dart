
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/addpost/add_post_screen.dart';



import '../icon_broken.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(

      listener: (BuildContext context, Object? state) {
        if(state is NewPostScreenState){
          navigateTo(context, NewPostScreen());
        }

      },
      builder: (BuildContext context, state) {

        var cubit=AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification,color: Colors.grey,)
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Search,color: Colors.grey,)
              )
            ],
            title: Text(
              cubit.titles[cubit.currentIndex],style: TextStyle(
              color: Colors.black
            ),),
          ),
          body:cubit.screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },

            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home
                  ),
                  label: 'home'

              ),
        BottomNavigationBarItem(
        icon: Icon(
        IconBroken.Activity

        ),
            label: 'chats'
        ),
              BottomNavigationBarItem(
                  icon: Icon(
                      IconBroken.Edit
                  ),
                  label: 'Post'

              ),
              BottomNavigationBarItem(
                icon: Icon(
                    IconBroken.Add_User

                ),
                label: 'users'
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    IconBroken.Setting
                ),
                  label: 'settings'
              )
            ],),






        );
      },

    );
  }
}
