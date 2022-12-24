import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/icon_broken.dart';
import 'package:shop_app/models/message_model.dart';

import '../../models/user_model.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel userModel;

  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> with TickerProviderStateMixin{


  late AnimationController controller =
  AnimationController(duration: const Duration(seconds: 2), vsync: this);


  var messageController = TextEditingController();

  var scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: widget.userModel.uId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.userModel.image!),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.userModel.name!)
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          reverse: true,

                        controller: scrollController,
                        physics:BouncingScrollPhysics()  ,
                          itemBuilder: (context,index){
                            var message=AppCubit.get(context).messages.reversed.toList()[index];
                            if(AppCubit.get(context).model?.uId==message.senderId)
                             return buildMyMessage(message);

                          return  buildMessage(message);
                          },
                          separatorBuilder:(context,index){
                            return SizedBox();
                          },
                          itemCount: AppCubit.get(context).messages.length),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type message...'),
                          ),
                        ),
                        MaterialButton(
                            height: 50,
                            child: Icon(IconBroken.Send),
                            onPressed: () {
                              AppCubit.get(context).sendMessage(
                                  receiverId: widget.userModel.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text);

                              messageController.clear();
                              scrollController.animateTo(
                                  scrollController.position.minScrollExtent,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds:600));

                            })
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child: Text(message.text!),
      ),
    );
  }

  Widget buildMyMessage(MessageModel message) {
    return Align(
      alignment: Alignment.centerRight,
      child:
            Container(

              margin:EdgeInsets.all(5) ,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                  )),
              child: Text(message.text!),
            )




    );
  }
}
