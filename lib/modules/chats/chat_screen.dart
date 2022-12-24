

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/chatDetails/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){} ,
      builder:(context,state){
        return ListView.separated(

            itemBuilder: (context,index)=>buildChatItem(context,AppCubit.get(context).users[index]),
            separatorBuilder: (context,index){
              return SizedBox();
            },
            itemCount:AppCubit.get(context).users.length
        );
      } ,

    );
  }
}
Widget buildChatItem(context,UserModel user){
  return InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: user));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,

            backgroundImage: NetworkImage(
                user.image!
            ),


          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(user.name!,style: TextStyle(height: 1.3),),
                  Icon(Icons.check_circle,color: Colors.blue,size: 14,)
                ],
              ),

            ],
          ),
        ],
      ),
    ),
  );


}

