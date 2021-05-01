import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ReadOnlyInput extends StatelessWidget {
  ReadOnlyInput(
      {@required this.value,
      this.label,
      this.fontSize,
      this.visibility = true});

  final String value;
  final String label;
  final double fontSize;
  final bool visibility;
  @override
  Widget build(BuildContext context) {
    return TextField(
      showCursor: false,
      keyboardType: TextInputType.number,
      readOnly: true,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      controller: MoneyMaskedTextController(
          decimalSeparator: ',',
          thousandSeparator: '.',
          initialValue: double.parse(value)),
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          hintText: "0,00",
          border: OutlineInputBorder(),
          isDense: true),
    );
  }
}

class ReadOnlyTextInput extends StatelessWidget {
  ReadOnlyTextInput(
      {@required this.value,
      this.label,
      this.fontSize,
      this.visibility = true});

  final String value;
  final String label;
  final double fontSize;
  final bool visibility;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      readOnly: true,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      controller: TextEditingController(text: value),
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          hintText: "0,00",
          border: OutlineInputBorder(),
          isDense: true),
    );
  }
}
