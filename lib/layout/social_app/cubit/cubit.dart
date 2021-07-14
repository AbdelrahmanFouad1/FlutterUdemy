import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/models/social_app/social_user_model.dart';
import 'package:first_flutter_app/modules/social_app/add_post/add_post_screen.dart';
import 'package:first_flutter_app/modules/social_app/chats/chats_screen.dart';
import 'package:first_flutter_app/modules/social_app/feeds/feeds_screen.dart';
import 'package:first_flutter_app/modules/social_app/settings/settings_screen.dart';
import 'package:first_flutter_app/modules/social_app/users/Users_screen.dart';
import 'package:first_flutter_app/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      // print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));

    });
  }

  int currentIndex = 0;

  List<Widget> screen =[
    FeedsScreen(),
    ChatsScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> title =[
    'Feeds',
    'Chats',
    'Post',
    'User',
    'Setting',
  ];

  void changeBottomNav(int index){
    if(index == 2)
      emit(SocialAddPostState());
    else{
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

}