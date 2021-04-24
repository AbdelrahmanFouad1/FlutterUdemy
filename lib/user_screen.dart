import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.phone
  });
}

class UserScreen extends StatelessWidget {

  List<UserModel> users = [
    UserModel(id: 1, name: 'Abdelrahman Mohamed Fouad', phone: '+201555156821'),
    UserModel(id: 2, name: 'Mohamed Fouad', phone: '+20155515984'),
    UserModel(id: 3, name: 'Fouad', phone: '+2017842434'),
    UserModel(id: 4, name: 'Ali Fouad', phone: '+2012456866'),
    UserModel(id: 1, name: 'Abdelrahman Mohamed Fouad', phone: '+201555156821'),
    UserModel(id: 2, name: 'Mohamed Fouad', phone: '+20155515984'),
    UserModel(id: 3, name: 'Fouad', phone: '+2017842434'),
    UserModel(id: 4, name: 'Ali Fouad', phone: '+2012456866'),
    UserModel(id: 1, name: 'Abdelrahman Mohamed Fouad', phone: '+201555156821'),
    UserModel(id: 2, name: 'Mohamed Fouad', phone: '+20155515984'),
    UserModel(id: 3, name: 'Fouad', phone: '+2017842434'),
    UserModel(id: 4, name: 'Ali Fouad', phone: '+2012456866'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Users'
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserList(users[index]),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserList(UserModel user) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.blue,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${user.phone}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
