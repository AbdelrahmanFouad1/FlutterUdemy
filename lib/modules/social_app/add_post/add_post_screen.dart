import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
          context: context,
          title: 'Add Post'
      ),
    );
  }
}
