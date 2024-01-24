import 'package:flutter/material.dart';

class ListCardWidget extends StatelessWidget {
  const ListCardWidget({super.key, required this.userList});

  final userList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userList.avatar),
        ),
        title: Text(userList.firstName),
        subtitle: Text(userList.email),
      ),
    );
  }
}
