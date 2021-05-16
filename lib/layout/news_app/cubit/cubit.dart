import 'package:first_flutter_app/layout/news_app/cubit/states.dart';
import 'package:first_flutter_app/modules/business/business_screen.dart';
import 'package:first_flutter_app/modules/science/Science_screen.dart';
import 'package:first_flutter_app/modules/setting/Setting_screen.dart';
import 'package:first_flutter_app/modules/sports/sports_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<BottomNavigationBarItem> bottomsItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ), label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ), label: 'Science',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ), label: 'Setting',
    ),
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

}