import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/modules/social_app/social_login/cubit/cubit.dart';
import 'package:first_flutter_app/modules/social_app/social_login/cubit/states.dart';
import 'package:first_flutter_app/modules/social_app/social_register/shop_register_screen.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorStates){
            showToast(
                message: state.error,
                state: ToastStates.ERROR
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          preFix: Icons.email_outlined,
                          label: 'Email Address',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          preFix: Icons.lock_outline,
                          suffix: cubit.suffix,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              // SocialLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
                          isPassword: cubit.isPassword,
                          label: 'Password',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingStates,
                          builder: (context) =>
                              defaultButton(
                                text: 'Login',
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                          fallback: (context) =>
                              Center(
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.blue,
                                      color: Colors.white,
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
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
