// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _currentSliderValue = 0;
  final _formKey = GlobalKey<FormState>();

  TextEditingController totalBill = TextEditingController();
  TextEditingController qtdPersons = TextEditingController();

  void rachaConta() {
    int totalBillInt = int.parse(totalBill.text);
    int qtdPersonsInt = int.parse(qtdPersons.text);
    double billWithTip =
        ((_currentSliderValue / 100) * totalBillInt) + totalBillInt;
    double tipValue = billWithTip - totalBillInt;
    setState(() {
      double result =
          (((_currentSliderValue / 100) * totalBillInt) + totalBillInt) /
              qtdPersonsInt;
      print(result);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            actionsAlignment: MainAxisAlignment.end,
            title: const Text('Total a pagar por pessoa'),
            content: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                children: [
                  Image.asset('assets/credit card.png', width: 80, height: 80,),
                  SizedBox(height: 10,),
                  Text('Total da conta: R\$ $billWithTip'),
                  Text('Taxa do garçom: R\$ $tipValue'),
                  Text('Total por pessoa: R\$ ${result.toStringAsFixed(2)}'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 102, 0), onPrimary: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Racha Conta',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFF6600),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Image.asset(
                      'assets/pay.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  TextFormField(
                    controller: totalBill,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Total da conta',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 102, 0), fontSize: 20),
                    ),
                    validator: (valor){
                      if(valor!.isEmpty) return 'Insira o valor da conta';
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        'Taxa de Serviço $_currentSliderValue%:',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: _currentSliderValue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: "$_currentSliderValue",
                        activeColor: Color(0xffFF6600),
                        inactiveColor: Color.fromARGB(255, 255, 255, 255),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                            print('value: $_currentSliderValue');
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  TextFormField(
                    controller: qtdPersons,
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    maxLength: 2,
                    smartQuotesType: SmartQuotesType.disabled,
                    obscuringCharacter: '*',
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade de pessoas',
                      labelStyle:
                          TextStyle(color: Color(0xffFF6600), fontSize: 20),
                    ),
                    validator: (valor){
                      if(valor!.isEmpty) return 'Insira o valor da conta';
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 500,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          rachaConta();
                        }
                      },
                      child: Text('Calcular'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFF6600),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
