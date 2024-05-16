import 'package:flutter/material.dart';

class InfomationWidget extends StatelessWidget {
  const InfomationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(Icons.person,color: Colors.white,),
      ),
      title: Text("Quoc",style: TextStyle(color: Colors.white),),
      subtitle: Text("User",style: TextStyle(color: Colors.white),),
    );
  }
}
