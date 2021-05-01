import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  final styleLabel;

  IconContent({this.icon, this.label, this.color, this.styleLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 40.0,
          color: color,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          style: styleLabel,
        ),
      ],
    );
  }
}