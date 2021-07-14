import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/modules/social_app/add_post/add_post_screen.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialAddPostState){
          navigateTo(context, AddPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                  label: 'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Setting'
              ),
            ],
          ),
        );
      },
    );
  }
}
