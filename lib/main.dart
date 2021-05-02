import 'package:bloc/bloc.dart';
import 'package:first_flutter_app/layout/home_layout.dart';
import 'package:first_flutter_app/modules/bmi/bmi_screen.dart';
import 'package:first_flutter_app/modules/bmi/bmi_screen.dart';
import 'package:first_flutter_app/modules/counter/counter_screen.dart';
import 'package:first_flutter_app/modules/login/login_screen.dart';
import 'package:first_flutter_app/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }

  }

