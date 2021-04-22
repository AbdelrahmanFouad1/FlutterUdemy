import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  onChanged: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    print(value);
                  },
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {},
                      child: Text('Register Now'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
