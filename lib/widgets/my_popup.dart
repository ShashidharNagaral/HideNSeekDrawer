import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('sxxs'),
        ),
      ],
    );
  }
}
