import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/models/social_app/social_user_model.dart';
import 'package:first_flutter_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).user.length > 0,
          builder: (context) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildChatUser(SocialCubit.get(context).user[index] ,context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).user.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatUser(SocialUserModel model ,context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                '${model.name}',
                style:
                    Theme.of(context).textTheme.subtitle1.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
