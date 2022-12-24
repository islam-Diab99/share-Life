import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/layout/social_layout.dart';
import 'package:shop_app/modules/social_register/register_screen.dart';
import 'package:shop_app/shared/cache_helper.dart';

import '../../components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
         if (state is LoginErrorState){
           showToast(state.error);
         }
         if (state is LoginSuccessState)
           {

             CacheHelper.saveData(
                 key: 'uId', value: state.uId).
             then((value) => navigateAndFinish(context, SocialLayout()));
             AppCubit.get(context).getUserData();

           }
        },
        builder: (context, state) {
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to browse our hot offer',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultFormField(
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                          },
                          labelText: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          // suffix: LoginCubit.get(context).suffix,
                          suffixPressed: () {
                            // LoginCubit.get(context).changePasswordVisibility();
                          },
                          // isPassword: LoginCubit.get(context).isPassword,
                          controller: passwordController,
                          inputType: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password is to short';
                            }
                          },
                          labelText: 'Password',
                          prefix: Icons.lock,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        state is! LoginLoadingState
                            ? DefaultButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          title: 'LOGIN',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
