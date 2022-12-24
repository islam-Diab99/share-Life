

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/modules/editProfile/edit_profile_screen.dart';

import '../../cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state){
          var userModel=AppCubit.get(context).model;
          return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(

                      child: Container(

                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft:  Radius.circular(4),
                                topRight: Radius.circular(4)
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              NetworkImage('${userModel?.cover}')
                            )
                        ),
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
                        child: CircleAvatar(
                          radius: 60,

                          backgroundImage: NetworkImage('${userModel?.image}')

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Text('${userModel?.name}',style: Theme.of(context).textTheme.bodyText1),
              SizedBox(height: 5,),
              Text(
                  '${userModel?.bio}',style: Theme.of(context).textTheme.caption),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(''
                              '100',style: Theme.of(context).textTheme.subtitle2),
                          Text(''
                              'posts',style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(''
                              '100',style: Theme.of(context).textTheme.subtitle2),
                          Text(''
                              'posts',style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(''
                              '100',style: Theme.of(context).textTheme.subtitle2),
                          Text(''
                              'posts',style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(''
                              '100',style: Theme.of(context).textTheme.subtitle2),
                          Text(''
                              'posts',style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),

                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(child: DefaultButton(
                    title: 'Edit Profile',
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    height:45,
                    colour: Colors.blue,
                    width: double.infinity,)),

                ],
              )

            ],

          ),
        );} ,

      );
  }
}

