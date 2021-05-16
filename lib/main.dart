import 'package:bloc/bloc.dart';
import 'package:first_flutter_app/layout/todo_app/todo_layout.dart';
import 'package:first_flutter_app/modules/bmi/bmi_screen.dart';
import 'package:first_flutter_app/modules/bmi/bmi_screen.dart';
import 'package:first_flutter_app/modules/counter/counter_screen.dart';
import 'package:first_flutter_app/modules/login/login_screen.dart';
import 'package:first_flutter_app/shared/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'layout/news_app/news_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
//jlj

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          elevation: 20.0,
        )
      ),
      home: NewsLayout(),
    );
  }

  }

