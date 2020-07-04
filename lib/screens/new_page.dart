import 'package:flutter/material.dart';
import 'package:hidenseekdrawer/constants.dart';

class NewPage extends StatefulWidget {
  const NewPage({@required this.title});
  final String title;
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            color: kGreyColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
