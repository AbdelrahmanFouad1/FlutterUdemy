import 'package:first_flutter_app/models/shop_app/login_model.dart';
import 'package:first_flutter_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_flutter_app/shared/network/end_point.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingStates());

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopLoginSuccessStates(loginModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStates(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
