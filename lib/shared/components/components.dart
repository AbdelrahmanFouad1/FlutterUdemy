import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/shared/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  @required String text,
  @required Function function,
  double width = double.infinity,
  Color color = Colors.blue,
  bool isUpperCase = true,
  double borderRadius = 10.0,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        color: color,
      ),
    );

Widget defaultTextField({

  @required TextEditingController controller,
  @required TextInputType textInputType,
  @required IconData preFix,
  @required String label,
  IconData suffix,
  @required Function validator,
  bool isPassword = false,
  Function suffixPressed,
  Function onTap,
}) =>
    TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          preFix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:  Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
              '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(width: 20.0,),
  
        Expanded(
  
          child: Column(
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            mainAxisSize: MainAxisSize.min,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              SizedBox(height: 5.0,),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(width: 20.0,),
  
        IconButton(
  
            icon: Icon(
  
              Icons.check_box,
  
              color: Colors.green,
  
            ),
  
            onPressed: (){
  
              AppCubit.get(context).updateData(
  
                status: 'done',
  
                id: model['id'],
  
              );
  
            },
  
            ),
  
        IconButton(
  
          icon: Icon(
  
            Icons.archive,
  
            color: Colors.black45,
  
          ),
  
          onPressed: (){
  
            AppCubit.get(context).updateData(
  
              status: 'archive',
  
              id: model['id'],
  
            );
  
          },
  
        ),

      ],
  
    ),
  
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder ({
  @required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) {
    return ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length);
  },
  fallback: (context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please add Some Tasks',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  },
);
