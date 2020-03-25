import 'dart:math';

import 'package:calc_unilar/screens/calc_screen.dart';

class Venda {
  final PaymentMethod selectedPaymentMethod;

  final double productPrice;
  final double productFinalPrice;

  final double interest;

  final double installmentValue;
  final int qtdInstallment;

  final double entranceValue;

  final double profit;

  Venda(this.productPrice, this.productFinalPrice, this.selectedPaymentMethod,
      {this.interest,
      this.installmentValue,
      this.qtdInstallment,
      this.entranceValue,
      this.profit});
}

class Calculator {
  Calculator(this.price, this.selectedPaymentMethod,
      {this.qtdInstallment, this.entrance});

  final double price;
  final int qtdInstallment;
  final double entrance;
  final PaymentMethod selectedPaymentMethod;

  final interest = {
    3: 0.39945,
    4: 0.30835,
    5: 0.25382,
    6: 0.21759,
    7: 0.19181,
    8: 0.17257,
    9: 0.15768,
    10: 0.14584,
    11: 0.13622,
    12: 0.12823,
    13: 0.12151,
    14: 0.11577,
    15: 0.11083
  };

  final interestWithEntrance = {
    3: 0.37642,
    4: 0.29056,
    5: 0.23918,
    6: 0.20504,
    7: 0.18075,
    8: 0.16262,
    9: 0.14858,
    10: 0.13742,
    11: 0.12837,
    12: 0.12086,
    13: 0.11454,
    14: 0.10915,
    15: 0.10451
  };

  double result;
  double discountInCash = 0.1;

  Venda calculateInCash() {
    var finalPrice = price - (price * discountInCash);
    return Venda(price, finalPrice, selectedPaymentMethod);
  }

  Venda calculateWithInstallment() {
    var installmentValue = price * interest[qtdInstallment];
    var finalPrice = installmentValue * qtdInstallment;

    return Venda(price, finalPrice, selectedPaymentMethod,
        interest: interest[qtdInstallment],
        installmentValue: installmentValue,
        qtdInstallment: qtdInstallment,
        profit: finalPrice - price);
  }

  Venda calculateWithEntrance() {
    var finalPrice =
        ((price * interest[qtdInstallment]) * qtdInstallment) - entrance;
    var installmentValue = finalPrice / (qtdInstallment - 1);

    return Venda(price, finalPrice, selectedPaymentMethod,
        interest: interest[qtdInstallment],
        installmentValue: installmentValue,
        qtdInstallment: qtdInstallment,
        entranceValue: entrance,
        profit: finalPrice - price);
  }

  String getInterpretation() {
    return "";
  }
}
