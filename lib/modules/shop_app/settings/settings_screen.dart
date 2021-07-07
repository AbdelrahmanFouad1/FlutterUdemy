import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        nameController.text = cubit.userModel.data.name;
        emailController.text = cubit.userModel.data.email;
        phoneController.text = cubit.userModel.data.phone;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserDataStates)
                        LinearProgressIndicator(),
                      SizedBox(height: 30.0,),
                      defaultTextField(
                        controller: nameController,
                        textInputType: TextInputType.name,
                        preFix: Icons.person,
                        label: 'Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextField(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        preFix: Icons.email,
                        label: 'Email',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextField(
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                        preFix: Icons.phone,
                        label: 'Phone',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                        },
                        text: 'Update',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );

      },
    );
  }
}
