import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = cubit.userModel.name;
        phoneController.text = cubit.userModel.phone;
        bioController.text = cubit.userModel.bio;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', action: [
            TextButton(
              onPressed: () {
                cubit.updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text);
              },
              child: Text('UPDATE'),
            ),
          ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
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
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${cubit.userModel.cover}')
                                        : FileImage(coverImage),
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
                            if (SocialCubit.get(context).coverImage != null)
                              IconButton(
                              onPressed: () {
                                cubit.uploadCoverImage(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,

                                );
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  Icons.check,
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
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${cubit.userModel.image}')
                                    : FileImage(profileImage),
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
                            if (SocialCubit.get(context).profileImage != null)
                              IconButton(
                                onPressed: () {
                                  cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,

                                  );
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.check,
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
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultTextField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      preFix: IconBroken.Call,
                      label: 'Phone',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Phone number must not be empty';
                        }
                        return null;
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
