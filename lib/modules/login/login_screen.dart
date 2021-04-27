import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var validatorKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: validatorKey,
              child: Column(
                children: [
                  Text(
                    'login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultTextField(
                    label: 'Email Address',
                    controller: emailController,
                    preFix: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    validator: (String value) {
                      if(value.isEmpty){
                        return 'Email must not be Empty !';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextField(
                    label: 'password',
                    controller: passwordController,
                    preFix: Icons.lock,
                    textInputType: TextInputType.visiblePassword,
                    isPassword: isPassword,
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: (){
                      setState(() {
                        isPassword =! isPassword;
                      });
                    },
                    validator: (String value) {
                      if(value.isEmpty){
                        return 'Password is too short !';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Login',
                    function: () {
                      if(validatorKey.currentState.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                      text: "Register", isUpperCase: false, function: () {}),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have account?'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Sign Up'),
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
  }
}
