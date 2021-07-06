import 'package:first_flutter_app/layout/shop_app/cubit/states.dart';
import 'package:first_flutter_app/models/shop_app/categories_model.dart';
import 'package:first_flutter_app/models/shop_app/change_favorites_model.dart';
import 'package:first_flutter_app/models/shop_app/favorites_model.dart';
import 'package:first_flutter_app/models/shop_app/home_model.dart';
import 'package:first_flutter_app/models/shop_app/login_model.dart';
import 'package:first_flutter_app/modules/shop_app/categories/categories_screen.dart';
import 'package:first_flutter_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:first_flutter_app/modules/shop_app/products/products_screen.dart';
import 'package:first_flutter_app/modules/shop_app/settings/settings_screen.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:first_flutter_app/shared/network/end_point.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.apps,
        ),
        label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favourites'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Setting'),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeStates());
    }).catchError((error) {
      print(error);
      emit(ShopErrorHomeStates());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJason(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print(error);
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      }else{
        getFavoritesData();
      }

      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataStates(userModel));
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetUserDataStates());
    });
  }
}
