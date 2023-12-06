import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({super.key, required this.title, required this.code});
  final String title;
  final String code;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(title,textAlign:TextAlign.right,),
        content:Text(code,textAlign:TextAlign.right,) ,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final data=ClipboardData(text:code);
              Clipboard.setData(data);
              Navigator.pop(context, 'copy');
            } ,
            child: const Text('copy'),
          ),
        ],
      ),
    );
  }
}
