import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidenseekdrawer/constants.dart';
import 'package:hidenseekdrawer/widgets/list_item.dart';

class HideNSeek extends StatefulWidget {
  const HideNSeek({this.hideWidth = 55, this.seekWidth = 300});
  final double hideWidth;
  final double seekWidth;

  @override
  _HideNSeekState createState() => _HideNSeekState();
}

class _HideNSeekState extends State<HideNSeek> with TickerProviderStateMixin {
  double hideWidth, seekWidth;

  AnimationController _controller;
  AnimationController _controller2;
  Animation width,
      padding,
      avatar,
      topHeadSpace,
      bottomHeadSpace,
      rotate,
      translate;
  bool isHided = true;
  @override
  void initState() {
    super.initState();
    hideWidth = widget.hideWidth;
    seekWidth = widget.seekWidth;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    width =
        Tween<double>(begin: hideWidth, end: seekWidth).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    ));
    padding = Tween<double>(begin: 9, end: 20).animate(_controller);
    rotate = Tween<double>(begin: 0, end: pi * 2).animate(_controller);
    avatar = Tween<double>(begin: 16, end: 30).animate(_controller2);
    topHeadSpace = Tween<double>(begin: 0, end: 30).animate(_controller2);
    bottomHeadSpace = Tween<double>(begin: 15, end: 50).animate(_controller2);
    translate =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(seekWidth - 55, -100))
            .animate(_controller);
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
//          alignment: Alignment.center,
          color: kGreyColor,
          width: width.value,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: topHeadSpace.value,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding.value, top: 10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: avatar.value,
                              backgroundColor: kWhiteColor,
                              backgroundImage: AssetImage('images/shashi.jpg'),
                            ),
                            Visibility(
                              visible: !isHided && seekWidth == width.value
                                  ? true
                                  : false,
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            Visibility(
                              visible: !isHided && seekWidth == width.value
                                  ? true
                                  : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Hello',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  Text(
                                    'Shashidhar N',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            !isHided && seekWidth == width.value ? true : false,
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding.value),
                        child: Visibility(
                          visible: !isHided && seekWidth == width.value
                              ? true
                              : false,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '234',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGreyAccentColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '1,024',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGreyAccentColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isHided,
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding.value),
                        child: Row(
                          children: <Widget>[
                            Transform.translate(
                              offset: translate.value,
                              child: Transform.rotate(
                                angle: rotate.value / 4,
                                child: Icon(
                                  Icons.more_horiz,
                                  size: 30,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            !isHided && seekWidth == width.value ? true : false,
                        child: Divider(
                          color: Colors.white30,
                          height: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding.value),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              icon: Icons.bookmark,
                              title: 'Saved',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              icon: Icons.history,
                              title: 'History',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              icon: Icons.person_add,
                              title: 'Discover People',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              icon: Icons.favorite_border,
                              title: 'Favorites',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            !isHided && seekWidth == width.value ? true : false,
                        child: Divider(
                          color: Colors.white30,
                          height: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: padding.value),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              title: 'About',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomItem(
                              isHided: isHided,
                              seekWidth: seekWidth,
                              animation: width,
                              onTap: () {},
                              title: 'Help Centre',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !isHided && seekWidth == width.value ? true : false,
                  child: Divider(
                    color: Colors.white30,
                    height: 0,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: padding.value, top: 10, bottom: 10),
                  child: Transform.rotate(
                    angle: rotate.value,
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: kWhiteColor,
                    ),
                  ),
                )
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
