import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/models/social_app/message_model.dart';
import 'package:first_flutter_app/models/social_app/social_user_model.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/colors.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel userModel;

  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(
          receiverId: userModel.uId,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(IconBroken.Arrow___Left_2),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage: NetworkImage(
                          '${userModel.image}'
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '${userModel.name}',
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit
                    .get(context)
                    .message
                    .length > 0,
                builder: (context) =>
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message = SocialCubit
                                    .get(context)
                                    .message[index];

                                if (SocialCubit
                                    .get(context)
                                    .userModel
                                    .uId == message.senderId)
                                  return buildMyMessage(message);
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.0,),
                              itemCount: SocialCubit
                                  .get(context)
                                  .message
                                  .length,
                            ),
                          ),
                          buildSendMessageField(context),
                        ],
                      ),
                    ),
                fallback: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: Image(
                              image: NetworkImage('https://image.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg'),
                            ),
                        ),
                        buildSendMessageField(context)
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0,),
              topStart: Radius.circular(10.0,),
              topEnd: Radius.circular(10.0,),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text,
          ),
        ),
      );

  Widget buildMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.2,),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0,),
              topStart: Radius.circular(10.0,),
              topEnd: Radius.circular(10.0,),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            model.text,
          ),
        ),
      );

  Widget buildSendMessageField(context) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15.0,),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 2.0,),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'type your message here ...',
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              color: defaultColor,
              child: MaterialButton(
                onPressed: () {
                  SocialCubit.get(context).sendMessage(
                    receiverId: userModel.uId,
                    dateTime: DateTime.now().toString(),
                    text: messageController.text,
                  );
                  messageController.text = '';
                },
                minWidth: 1.0,
                child: Icon(
                  IconBroken.Send,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
