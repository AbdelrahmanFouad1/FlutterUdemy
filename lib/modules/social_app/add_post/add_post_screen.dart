import 'package:first_flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/social_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/colors.dart';
import 'package:first_flutter_app/shared/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return  Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
            action: [
              defaultTextButton(
              function: (){
                var now = DateTime.now();

                if (SocialCubit.get(context).postImage == null)
                {
                  SocialCubit.get(context).createPost(
                    dateTime: now.toString(),
                    text: textController.text,
                  );
                } else
                {
                  SocialCubit.get(context).uploadPostImage(
                    dateTime: now.toString(),
                    text: textController.text,
                  );
                }
              },
              text: 'post',
          ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://image.freepik.com/free-photo/young-man-trendy-denim-shirt-looks-inspired-holds-his-index-finger-upwards-looking-front_295783-1649.jpg'),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Abdelrahman Fouad',
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
                          Row(
                            children: [
                            Text(
                            'Public',
                            style: Theme.of(context).textTheme.caption.copyWith(height: 1.4,),
                          ),
                              SizedBox(width: 5.0,),
                              Icon(
                                Icons.public,
                                color: Colors.grey[500],
                                size: 16.0,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(cubit.postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0,),
                        image: DecorationImage(
                          image: FileImage(cubit.postImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(width: 5.0,),
                              Text(
                                'add photo'
                              ),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Text(
                                  '# tag'
                              ),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
