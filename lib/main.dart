import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/shop_app/shop_layout.dart';
import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/social_layout.dart';
import 'package:first_flutter_app/modules/shop_app/login/shop_login_scree.dart';
import 'package:first_flutter_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:first_flutter_app/modules/social_app/social_login/social_login_scree.dart';
import 'package:first_flutter_app/shared/bloc_observer.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:first_flutter_app/shared/cubit/cubit.dart';
import 'package:first_flutter_app/shared/cubit/states.dart';
import 'package:first_flutter_app/shared/network/local/cache_helper.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:first_flutter_app/shared/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/news_app/news_layout.dart';

void main() async
{

  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');
  // print(token);

  // if(onBoarding != null){
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // }else{
  //   widget = OnBoardingScreen();
  // }

  if(uId != null ){
    widget = SocialLayout();
  }else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeTheme(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // AppCubit.get(context).darkMode? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

  }

