import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cache_helper.dart';
import 'package:shop_app/shared/resources/theme_manager.dart';

import 'constants.dart';
import 'cubit/app_cubit.dart';
import 'cubit/states.dart';
import 'layout/social_layout.dart';
import 'modules/social_login/social_login_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Widget widget;
  uId=await CacheHelper.getData(key: 'uId');
  if(uId!=null)

    {
      widget=SocialLayout();
    }
  else {
    widget = LoginScreen();
  }


  BlocOverrides.runZoned(
        () {
      runApp(MyApp(startWidget: widget,),);
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({required this.startWidget});
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context)=>AppCubit()..getUserData()..getPosts()..getUsers(),
      child: BlocConsumer<AppCubit,AppStates>(

        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,




            home: startWidget,
          );
        },

      ),
    );
  }
}
