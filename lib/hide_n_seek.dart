import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidenseekdrawer/constants.dart';

class HideNSeek extends StatefulWidget {
  const HideNSeek({this.hideWidth = 60, this.seekWidth = 300});
  final double hideWidth;
  final double seekWidth;

  @override
  _HideNSeekState createState() => _HideNSeekState();
}

class _HideNSeekState extends State<HideNSeek> with TickerProviderStateMixin {
  double hideWidth, seekWidth;

  AnimationController _controller;
  AnimationController _controller2;
  Animation width, padding, avatar, topspace;
  bool isHided = true;
  @override
  void initState() {
    super.initState();
    hideWidth = widget.hideWidth;
    seekWidth = widget.seekWidth;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    width =
        Tween<double>(begin: hideWidth, end: seekWidth).animate(_controller);
    padding = Tween<double>(begin: 9, end: 20).animate(_controller);
    avatar = Tween<double>(begin: 20, end: 50).animate(_controller2);
    topspace = Tween<double>(begin: 0, end: 20).animate(_controller2);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    DragStartDetails dragStartDetails;
    DragUpdateDetails dragUpdateDetails;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => GestureDetector(
        onHorizontalDragStart: (detail) {
          dragStartDetails = detail;
        },
        onHorizontalDragUpdate: (detail) {
          dragUpdateDetails = detail;
        },
        onHorizontalDragEnd: (detail) {
          double horizontalSwipe = dragUpdateDetails.globalPosition.dx -
              dragStartDetails.globalPosition.dx;
          if (horizontalSwipe < 0) horizontalSwipe = -horizontalSwipe;
          double velocity = detail.primaryVelocity;
          if (horizontalSwipe > 10) {
            if (velocity > 50 && width.value == hideWidth) {
              //LtoR swipe
              setState(() {
                isHided = false;
              });
              _controller.forward();
              _controller2.forward();
              print('L to R swipe');
            } else if (velocity < -50 && width.value == seekWidth) {
              //RtoL swipe
              setState(() {
                isHided = true;
              });
              _controller.reverse();
              _controller2.reverse();
              print('R to L swipe');
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          color: kGreyColor,
          width: width.value,
          height: height,
          child: Padding(
            padding: EdgeInsets.only(left: padding.value, top: 9),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: topspace.value,
                ),
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: avatar.value,
                      backgroundColor: kWhiteColor,
                      backgroundImage: AssetImage('images/shashi.jpg'),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Hello'),
                          SizedBox(
                            height: 25,
                          ),
                          Text('Shashidhar N.'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
