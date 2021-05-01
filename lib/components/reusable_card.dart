import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final boxShadow;

  ReusableCard(
      {@required this.color,
      this.cardChild,
      this.onPress,
      this.heightCard = 100,
      this.width,
      this.boxShadow,
      this.visibility = true});

  final Color color;
  final Widget cardChild;
  final Function onPress;
  final bool visibility;
  final double heightCard;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: visibility,
          child: Container(
            height: heightCard,
            width: width,
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration( 
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                
              ],
            ),
            child: cardChild,
          ),
        ));
  }
}
