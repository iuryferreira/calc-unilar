import 'package:brasil_fields/brasil_fields.dart';
import 'package:calc_unilar/utils/calculator.dart';
import 'package:calc_unilar/validators/money_input.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';
import '../components/bottom_button.dart';
import '../components/round_icon_button.dart';
import '../utils/constants.dart';
import 'result_page.dart';

enum PaymentMethod { money, downPayment, withEntrance }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  PaymentMethod selectedPaymentMethod;

  double productValue = 0;
  double valueEntrance = 0.0;
  int installment = 3;

  bool installmentVisible = false;
  bool cardIsDefault = true;

  Venda venda;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController txtValorProduto = TextEditingController();
  TextEditingController txtValorEntrada = TextEditingController();

  defaultFlipCard() {
    if (cardIsDefault == false) {
      cardKey.currentState.toggleCard();
      cardIsDefault = true;
    }
  }

  focusCard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  generatorCalc() {
    if (selectedPaymentMethod == PaymentMethod.money) {
      return Calculator(productValue, selectedPaymentMethod);
    } else if (selectedPaymentMethod == PaymentMethod.downPayment) {
      return Calculator(productValue, selectedPaymentMethod,
          qtdInstallment: installment);
    } else {
      return Calculator(productValue, selectedPaymentMethod,
          qtdInstallment: installment, entrance: valueEntrance);
    }
  }

  generateVenda() {
    Calculator calc = generatorCalc();

    if (selectedPaymentMethod == PaymentMethod.money) {
      return calc.calculateInCash();
    } else if (selectedPaymentMethod == PaymentMethod.downPayment) {
      return calc.calculateWithInstallment();
    } else {
      return calc.calculateWithEntrance();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Calculadora - Rede Unilar'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/logo_hs.png',
            width: 200,
            alignment: Alignment.topLeft,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      focusCard();
                      txtValorProduto.text = "";
                      txtValorEntrada.text = "";
                      setState(() {
                        selectedPaymentMethod = PaymentMethod.money;
                        installmentVisible = false;
                        defaultFlipCard();
                      });
                    },
                    color: selectedPaymentMethod == PaymentMethod.money
                        ? kActiveCardColor
                        : kInactiveCardcolor,
                    cardChild: IconContent(
                        icon: FontAwesomeIcons.dollarSign,
                        label: "A Vista",
                        styleLabel: selectedPaymentMethod == PaymentMethod.money
                            ? kLabelTextStyleSelected
                            : kLabelTextStyle,
                        color: selectedPaymentMethod == PaymentMethod.money
                            ? kIconSelected
                            : kFontColorDefault),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      focusCard();
                      txtValorProduto.text = "";
                      txtValorEntrada.text = "";
                      setState(() {
                        selectedPaymentMethod = PaymentMethod.downPayment;
                        installmentVisible = true;
                        print(cardIsDefault);
                        defaultFlipCard();
                      });
                    },
                    color: selectedPaymentMethod == PaymentMethod.downPayment
                        ? kActiveCardColor
                        : kInactiveCardcolor,
                    cardChild: IconContent(
                        icon: FontAwesomeIcons.fileInvoiceDollar,
                        label: "S/Entrada",
                        styleLabel:
                            selectedPaymentMethod == PaymentMethod.downPayment
                                ? kLabelTextStyleSelected
                                : kLabelTextStyle,
                        color:
                            selectedPaymentMethod == PaymentMethod.downPayment
                                ? kIconSelected
                                : kFontColorDefault),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      focusCard();
                      txtValorProduto.text = "";
                      txtValorEntrada.text = "";
                      setState(() {
                        selectedPaymentMethod = PaymentMethod.withEntrance;
                        installmentVisible = true;
                      });
                    },
                    color: selectedPaymentMethod == PaymentMethod.withEntrance
                        ? kActiveCardColor
                        : kInactiveCardcolor,
                    cardChild: IconContent(
                        icon: FontAwesomeIcons.handHoldingUsd,
                        label: "C/Entrada",
                        styleLabel:
                            selectedPaymentMethod == PaymentMethod.withEntrance
                                ? kLabelTextStyleSelected
                                : kLabelTextStyle,
                        color:
                            selectedPaymentMethod == PaymentMethod.withEntrance
                                ? kIconSelected
                                : kFontColorDefault),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Form(
                  key: formkey,
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    key: cardKey,
                    flipOnTouch: false,
                    front: ReusableCard(
                      color: kCardcolor,
                      onPress: () {
                        focusCard();
                      },
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Valor do Produto",
                            style: kLabelTextStyle,
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.only(left: 60, right: 60),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                                RealInputFormatter(centavos: true),
                              ],
                              controller: txtValorProduto,
                              style: kNumberTextStyleInputSelected,
                              decoration: InputDecoration(
                                hintText: "0,00",
                              ),
                              textAlign: TextAlign.center,
                              validator: (value) =>
                                  MoneyInputValidator.validate(value),
                              onChanged: (String value) {
                                value = value.replaceAll(".", '');
                                value = value.replaceAll(",", '.');
                                productValue = double.parse(value);
                                print(productValue);
                              },
                              onEditingComplete: () {
                                focusCard();
                                if (selectedPaymentMethod ==
                                    PaymentMethod.withEntrance) {
                                  cardKey.currentState.toggleCard();
                                  setState(() {
                                    cardIsDefault = !cardIsDefault;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: ReusableCard(
                      onPress: () {
                        focusCard();
                      },
                      color: kCardcolor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Valor da Entrada",
                            style: kLabelTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  RealInputFormatter(centavos: true),
                                ],
                                controller: txtValorEntrada,
                                style: kNumberTextStyleInputSelected,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: "0,00", isDense: true),
                                onChanged: (String value) {
                                  value = value.replaceAll(".", '');
                                  value = value.replaceAll(",", '.');
                                  valueEntrance = double.parse(value);
                                },
                                validator: (value) {
                                  value = value.replaceAll(".", '');
                                  value = value.replaceAll(",", '.');
                                  if (double.parse(value) == 0.0) {
                                    return "O valor não pode ser zero.";
                                  } else if (double.parse(value) >
                                      productValue) {
                                    return "O valor da entrada não pode ser maior que o produto.";
                                  }
                                },
                                onEditingComplete: () {
                                  cardKey.currentState.toggleCard();
                                  cardIsDefault = !cardIsDefault;
                                  focusCard();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ))),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    heightCard: 130,
                    onPress: () {
                      focusCard();
                    },
                    visibility: installmentVisible,
                    color: kInactiveCardcolor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Parcelas",
                          style: kLabelTextStyle,
                        ),
                        Text(
                          installment.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(() {
                                  if (installment <= 15 && installment > 3) {
                                    installment--;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  if (installment < 15 && installment >= 3) {
                                    installment++;
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          BottomButton(
            onTap: () {
              if (selectedPaymentMethod == PaymentMethod.withEntrance &&
                  !formkey.currentState.validate()) {
                return;
              } else {
                venda = generateVenda();
                print(venda.productFinalPrice);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      venda: venda,
                    ),
                  ),
                );
              }

              txtValorEntrada.text = "";
              txtValorProduto.text = "";
            },
            buttonTitle: "Calcular",
          ),
        ],
      ),
    );
  }
}
