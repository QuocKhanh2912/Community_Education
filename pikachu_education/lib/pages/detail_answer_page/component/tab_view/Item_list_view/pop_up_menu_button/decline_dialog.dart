import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class DeclineDialogComment extends StatelessWidget {
  const DeclineDialogComment({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('You do\'nt have permission to edit this post',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:  ManagementColor.yellow),
              child: const Center(
                child: Text('OK',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ManagementColor.white,
                    fontSize: 25)),
              ),
            ))
      ],
    );
  }
}
