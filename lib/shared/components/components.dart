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
        suffixIcon: suffix != null ? IconButton(
          onPressed: suffixPressed,
            icon: Icon(
          suffix,
        )
      ) : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model) => Padding(
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
      Column(
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
    ],
  ),
);
