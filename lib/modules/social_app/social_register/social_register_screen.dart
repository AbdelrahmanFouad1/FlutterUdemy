import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/shop_app/shop_layout.dart';
import 'package:first_flutter_app/layout/social_app/social_layout.dart';
import 'package:first_flutter_app/modules/social_app/social_register/cubit/cubit.dart';
import 'package:first_flutter_app/modules/social_app/social_register/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialCreateSuccessStates){
            navigateFinish(context, SocialLayout());
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to communicate with friends',
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
                          controller: nameController,
                          textInputType: TextInputType.name,
                          preFix: Icons.person,
                          label: 'Name',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your Name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
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
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          preFix: Icons.phone,
                          label: 'Phone Number',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
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
                          condition: state is! SocialRegisterLoadingStates,
                          builder: (context) =>
                              defaultButton(
                                text: 'Register',
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
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
