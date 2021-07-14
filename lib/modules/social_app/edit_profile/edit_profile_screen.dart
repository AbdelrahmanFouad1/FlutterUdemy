import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', action: [
            TextButton(
              onPressed: () {},
              child: Text('UPDATE'),
            ),
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 220.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            child: Container(
                              height: 160.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  topLeft: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null ? NetworkImage('${cubit.userModel.cover}') : FileImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getCoverImage();
                            },
                            icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: profileImage == null ? NetworkImage('${cubit.userModel.image}') : FileImage(profileImage),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cubit.getProfileImage();
                            },
                            icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultTextField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    preFix: IconBroken.Add_User,
                    label: 'Name',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10.0,
                ),
                defaultTextField(
                    controller: bioController,
                    textInputType: TextInputType.text,
                    preFix: IconBroken.Info_Circle,
                    label: 'Bio',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Bio must not be empty';
                      }
                      return null;
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
