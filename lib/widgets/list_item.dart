import 'package:flutter/material.dart';
import 'package:hidenseekdrawer/constants.dart';

class CustomItem extends StatelessWidget {
  const CustomItem({
    Key key,
    @required this.isHided,
    @required this.seekWidth,
    @required this.animation,
    @required this.onTap,
    this.title,
    this.icon,
  }) : super(key: key);

  final bool isHided;
  final double seekWidth;
  final Animation animation;
  final Function onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Visibility(
            visible: icon == null ? false : true,
            child: Icon(
              icon,
              color: kWhiteColor,
              size: 30,
            ),
          ),
          Visibility(
            visible: !isHided && seekWidth == animation.value && icon != null
                ? true
                : false,
            child: SizedBox(
              width: 15,
            ),
          ),
          Visibility(
            visible: !isHided && seekWidth == animation.value && title != ''
                ? true
                : false,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                title != null ? title : '',
                style: TextStyle(
                    color: Color(0xffDEDEDE),
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
