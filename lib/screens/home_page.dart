import 'package:flutter/material.dart';
import 'package:hidenseekdrawer/constants.dart';
import 'package:hidenseekdrawer/hide_n_seek.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double hideWidth = 55;
const double seekWidth = 300;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      ///if drawer is to be used in scaffold, =>
      ///1. adjust the width of positionWidget below,
      ///2. pop the context before navigating (inside HideNSeek drawer) to new screen.
//      drawer: HideNSeek(
//        hideWidth: hideWidth,
//        seekWidth: seekWidth,
//      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HideNSeek(
            hideWidth: hideWidth,
            seekWidth: seekWidth,
          ),

          ///main page for the application
          Expanded(
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Positioned(
                  ///remove hideWidth if drawer is used in scaffold
                  width: size.width - hideWidth,
                  height: size.height,
                  child: Center(
                    child: Text(
                      'Container',
                      style: TextStyle(
                        color: kGreyColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
