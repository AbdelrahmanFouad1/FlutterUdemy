import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/models/social_app/post_model.dart';
import 'package:first_flutter_app/shared/style/colors.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 ,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 8.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage('https://image.freepik.com/free-photo/portrait-happy-amazed-young-beautiful-lady-with-curly-dark-hair-heard-cool-news-broadly-smiling-looking-camera-pointing-with-finger-copy-space-isolated-pink-background_295783-3092.jpg'),
                          height: 200.0,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem (SocialCubit.get(context).posts[index], context),
                    separatorBuilder: ( context, int ) => SizedBox(height: 8.0,),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildPostItem (PostModel model, context) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 8.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0,),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              height: 1.4
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption.copyWith(height: 1.4,),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0,),
              IconButton(
                onPressed: (){},
                icon: Icon(
                  IconBroken.More_Square,
                  size: 18.0,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0,),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Container(
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6.0,),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 1.0,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               '#Software',
          //               style: Theme.of(context).textTheme.caption.copyWith(
          //                 color: defaultColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 6.0,),
          //         child: Container(
          //           height: 20.0,
          //           child: MaterialButton(
          //             onPressed: (){},
          //             minWidth: 1.0,
          //             padding: EdgeInsets.zero,
          //             child: Text(
          //               '#Flutter',
          //               style: Theme.of(context).textTheme.caption.copyWith(
          //                 color: defaultColor,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.only(
              bottom: 5.0, top: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 140.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 18.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 18.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0,),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel.image}'
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5.0,),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: (){},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
