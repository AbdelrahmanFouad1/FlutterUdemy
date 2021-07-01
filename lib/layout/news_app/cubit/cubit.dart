import 'package:first_flutter_app/layout/news_app/cubit/states.dart';
import 'package:first_flutter_app/modules/news_app/business/business_screen.dart';
import 'package:first_flutter_app/modules/news_app/science/Science_screen.dart';
import 'package:first_flutter_app/modules/news_app/sports/sports_screen.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
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
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness(){

    emit(NewsGetBusinessLoadingStates());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'b3c0fdb119c64ebd948a75828b9b9eb7',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetBusinessErrorStates(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports(){

    emit(NewsGetSportsLoadingStates());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'b3c0fdb119c64ebd948a75828b9b9eb7',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSportsSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetSportsErrorStates(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience(){

    emit(NewsGetScienceLoadingStates());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'science',
        'apiKey':'b3c0fdb119c64ebd948a75828b9b9eb7',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);

      emit(NewsGetScienceSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetScienceErrorStates(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value){

    emit(NewsGetSearchLoadingStates());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'b3c0fdb119c64ebd948a75828b9b9eb7',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessStates());
    }).catchError((error){
      print(error.toString());

      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }

}