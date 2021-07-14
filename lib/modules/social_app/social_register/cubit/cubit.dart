import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/models/social_app/social_user_model.dart';
import 'package:first_flutter_app/modules/social_app/social_register/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String phone,
    @required String password,
  }) {
    emit(SocialRegisterLoadingStates());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(name: name, email: email, phone: phone, uId: value.user.uid);
      // emit(SocialRegisterSuccessStates());
    }).catchError((error) {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }

  SocialUserModel model;

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,
  }) {
    model = SocialUserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        image: 'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
        cover: 'https://image.freepik.com/free-photo/shocked-bearded-adult-male-office-worker-looks-with-excitement-sits-desktop-with-blueprints-papers-prepares-engineering-project-surprised-have-deadline-designing-concept_273609-50129.jpg',
        bio: 'write you bio ...',
        isEmailVerify: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangeRegisterPasswordVisibilityState());
  }
}
