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
  @required String label,
  @required TextEditingController controller,
  @required IconData preFix,
  IconData suffix,
  @required TextInputType textInputType,
  bool isPassword = false,
  @required Function validator,
  Function suffixPressed,
}) =>
    TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: isPassword,
      validator: validator,
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
