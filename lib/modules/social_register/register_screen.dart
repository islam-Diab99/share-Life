
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/modules/social_login/cubit/states.dart';
import 'package:shop_app/shared/cache_helper.dart';


import '../../components.dart';
import '../../constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
         if(state is CreateUserSuccessState){

           navigateAndFinish(context, SocialLayout());

         }
         if (state is RegisterErrorState)
           {
             showToast(state.error.toString().split(']').last);
           }
         if (state is RegisterSuccessState)
         {
           uId=state.uId;
           CacheHelper.saveData(
               key: 'uId', value: state.uId).
           then((value) => navigateAndFinish(context, SocialLayout()));

         }


          }, builder: (context, state) {
        return Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(
                        'REGISTER',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        'Register now to browse our hot offer',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultFormField(
                        controller: nameController,
                        inputType: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                        labelText: 'User Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        labelText: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        inputType: TextInputType.visiblePassword,
                        // suffix: RegisterCubit.get(context).suffix,
                        onSubmit: (value) {},
                        // isPassword: ShopRegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          // ShopRegisterCubit.get(context)
                          //     .changePasswordVisibility();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        labelText: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          }
                        },
                        labelText: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      state is! RegisterLoadingState
                          ? DefaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        title: 'Register',
                        colour: Colors.teal,
                        width: double.infinity,
                        height: 50,
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
