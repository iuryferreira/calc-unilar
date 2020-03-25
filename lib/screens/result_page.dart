import 'package:brasil_fields/brasil_fields.dart';
import 'package:calc_unilar/components/readonly_input.dart';
import 'package:calc_unilar/screens/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../calculator.dart';
import '../components/reusable_card.dart';
import '../components/bottom_button.dart';
import '../constants.dart';

class ResultPage extends StatelessWidget {
  ResultPage({@required this.interpretation, @required this.venda});

  final Venda venda;

  final String interpretation;

  verificaValor(value) {
    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  bool isInCash() {
    return venda.selectedPaymentMethod == PaymentMethod.money ? true : false;
  }

  bool isWithoutEntrance() {
    return venda.selectedPaymentMethod == PaymentMethod.downPayment
        ? true
        : false;
  }

  bool isEntrance() {
    return venda.selectedPaymentMethod == PaymentMethod.withEntrance
        ? true
        : false;
  }

  String getPaymentMethod() {
    if (venda.selectedPaymentMethod == PaymentMethod.money) {
      return "À Vista";
    } else if (venda.selectedPaymentMethod == PaymentMethod.downPayment) {
      return "Crediário S/Entrada";
    } else {
      return "Crediário C/Entrada";
    }
  }

  MoneyMaskedTextController valuesController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora - Rede Unilar"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                            child: Image.asset(
                          'assets/logo_hs.png',
                          width: 300,
                          alignment: Alignment.center,
                        )),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Opa! Deu certo. Aqui estão os dados da sua venda, e os valores calculados.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ReadOnlyInput(
                          value: isInCash()
                              ? venda.productFinalPrice.toString()
                              : venda.installmentValue.toString(),
                          label: isInCash()
                              ? "Valor com Desconto"
                              : "Valor da Parcela",
                          fontSize: 30,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ReadOnlyInput(
                                value: venda.productPrice.toString(),
                                label: "Preço Inicial",
                              ),
                            ),
                            Visibility(
                                visible: !isInCash(),
                                child: SizedBox(
                                  width: 20,
                                )),
                            Visibility(
                                visible: !isInCash(),
                                child: Expanded(
                                  child: ReadOnlyInput(
                                    value:
                                        verificaValor(venda.productFinalPrice)
                                            .toString(),
                                    label: "Valor Com Juros",
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                            visible: isInCash() ? false : true,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: ReadOnlyTextInput(
                                    value: verificaValor(venda.qtdInstallment)
                                        .toString(),
                                    label: "Q. Parcelas",
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: ReadOnlyTextInput(
                                    label: "Juros",
                                    value: (verificaValor(venda.interest) * 100)
                                            .toStringAsPrecision(5) +
                                        " %",
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ReadOnlyInput(
                                    value: isWithoutEntrance()
                                        ? verificaValor(venda.profit).toString()
                                        : verificaValor(venda.entranceValue)
                                            .toString(),
                                    label: isWithoutEntrance()
                                        ? "Lucro"
                                        : "Entrada",
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Visibility(
                                  visible: isInCash() || isWithoutEntrance()
                                      ? false
                                      : true,
                                  child: Expanded(
                                    child: ReadOnlyInput(
                                      value: verificaValor(venda.profit)
                                          .toString(),
                                      label: "Lucro",
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Visibility(
                                    visible: true,
                                    child: ReadOnlyTextInput(
                                      value: getPaymentMethod(),
                                      label: "Pagamento",
                                    ),
                                  )),
                              Visibility(
                                  visible: isInCash() || isWithoutEntrance()
                                      ? true
                                      : false,
                                  child: SizedBox(
                                    width: 20,
                                  ))
                            ],
                          ),
                        ),
                      ]),
                ),
              )),
              BottomButton(
                buttonTitle: 'Novo cálculo',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
  }
}
