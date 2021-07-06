import 'package:first_flutter_app/models/shop_app/login_model.dart';
import 'package:first_flutter_app/modules/shop_app/login/cubit/states.dart';
import 'package:first_flutter_app/modules/shop_app/register/cubit/states.dart';
import 'package:first_flutter_app/shared/network/end_point.dart';
import 'package:first_flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    emit(ShopRegisterLoadingStates());

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(ShopRegisterSuccessStates(loginModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangeRegisterPasswordVisibilityState());
  }
}
