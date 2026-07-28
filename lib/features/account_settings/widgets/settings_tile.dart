import 'package:flutter/material.dart';


class SettingsTile extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;


  const SettingsTile({

    super.key,

    required this.icon,

    required this.title,

    required this.subtitle,

    required this.onTap,

  });



  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Icon(
        icon,
        color: Colors.white,
      ),


      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),


      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),


      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.white,
      ),


      onTap: onTap,

    );

  }

}