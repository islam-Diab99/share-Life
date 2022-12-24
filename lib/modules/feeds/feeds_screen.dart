

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/icon_broken.dart';
import 'package:shop_app/models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

        BlocConsumer<AppCubit,AppStates>(
          listener: (context,index){},
          builder: (context,index){
            return
              AppCubit.get(context).posts.length>0?
              SingleChildScrollView(
              physics: BouncingScrollPhysics(),

              child:
              Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 1,
                    margin: EdgeInsets.all(10),
                    child:
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-vector/social-media-network_74855-4575.jpg?t=st=1656665789~exp=1656666389~hmac=90dbfb0bae3699a2311e4cd8c3ed56910eefd5a6fe9a0e2ca08f06f79769fd24&w=1060'),

                        ),
                        // Text('communicate with friends',
                        //   style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black),),
                      ],
                    ),

                  ),
                  ListView.separated(

                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder:
                        (context,index)=>buildPostItem(AppCubit.get(context).posts[index],context,index), itemCount: AppCubit.get(context).posts.length,
                    separatorBuilder: (BuildContext context, int index) {return SizedBox(height: 10,);  },
                  )






                ],
              ),
            ):Center(child: CircularProgressIndicator());
          },


        );



  }
}

Widget buildPostItem(PostModel model,context, int index)=>Card(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  elevation: 5,
  margin: EdgeInsets.all(0),
  child:
  Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,

              backgroundImage: NetworkImage(
                "${model.image}"
                  ),


            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("${model.name}",style: TextStyle(height: 1.3),),
                    Icon(Icons.check_circle,color: Colors.blue,size: 14,)
                  ],
                ),
                Text("${model.dateTime}",style: Theme.of(context).textTheme.caption?.copyWith(
                    height:1.3
                ),
                )
              ],
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(

            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Text(
            "${model.text}"
        ),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Wrap(


            children: [

              Padding(

                padding: EdgeInsetsDirectional.only(
                    end: 5
                ),
                child: Container(
                  height: 14,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      minWidth: 0,
                      height: 25,
                      onPressed: (){}, child: Text('#software',style: TextStyle(color: Colors.blue))),
                ),
              ),
              Padding(

                padding: EdgeInsetsDirectional.only(
                    end: 1
                ),
                child: Container(
                  height: 14,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      minWidth: 0,
                      height: 25,
                      onPressed: (){}, child: Text('#software',style: TextStyle(color: Colors.blue))),
                ),
              ),


            ],
          ),
        ),
if(model.postImage!='')
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(

            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                  NetworkImage("${model.postImage}"),

                )
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(


                onTap: (){
                  AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Heart,color:AppCubit.get(context).likes[index]==0? Colors.grey:Colors.red,size: 20,),

                        Text('${AppCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,)

                      ],
                    ),
                  ),
                ),

              ),
            ),

            Expanded(
              child: InkWell(


                onTap: (){},
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Chat,color: Colors.grey,size: 20,),

                        Text('0',style: Theme.of(context).textTheme.caption,)

                      ],
                    ),
                  ),
                ),

              ),
            ),
            Expanded(
              child: InkWell(


                onTap: (){},
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Arrow___Up_Square,color: Colors.grey,size: 20,),


                        Text('0',style: Theme.of(context).textTheme.caption,)

                      ],
                    ),
                  ),
                ),

              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(

            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 15,

              backgroundImage: NetworkImage(
                  "${AppCubit.get(context).model?.image}"
                  ),


            ),
            SizedBox(width: 10,),
            Text('write a comment...',style: Theme.of(context).textTheme.caption?.copyWith(
                height:1.3
            ),
            ),
          ],
        ),

      ],
    ),
  ),


);