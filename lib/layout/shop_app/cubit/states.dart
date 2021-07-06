import 'package:first_flutter_app/models/shop_app/change_favorites_model.dart';
import 'package:first_flutter_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}

class ShopChangeBottomNavStates extends ShopStates{}

class ShopLoadingHomeStates extends ShopStates{}

class ShopSuccessHomeStates extends ShopStates{}

class ShopErrorHomeStates extends ShopStates{}

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErrorCategoriesStates extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates{}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopErrorGetFavoritesStates extends ShopStates{}

class ShopLoadingGetUserDataStates extends ShopStates{}

class ShopSuccessGetUserDataStates extends ShopStates{
  final ShopLoginModel userModel;

  ShopSuccessGetUserDataStates(this.userModel);
}

class ShopErrorGetUserDataStates extends ShopStates{}
