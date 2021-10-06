import "package:flutter/material.dart";
import "dart:math";

class CalcEMI extends StatefulWidget {
  @override
  CalcEMIState createState() => CalcEMIState();
}

class CalcEMIState extends State<CalcEMI> {
  List _tenureTypes = ['Month(s)', 'Year(s)'];
  String _tenureType = "Year(s)";
  String _emiResult = "";

  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("EMI Calculator"),
          centerTitle: true,
          backgroundColor: Color(0xff442243),
        ),
        body: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(5, 75, 5, 25),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _principalAmount,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Enter Principal Amount"),
                          keyboardType: TextInputType.number,
                        )),
                    Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _interestRate,
                          decoration: InputDecoration(
                            hintText: "Interest Rate",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          keyboardType: TextInputType.number,
                        )),
                    Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: TextField(
                                  controller: _tenure,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      hintText: "Tenure"),
                                  keyboardType: TextInputType.number,
                                )),
                            Flexible(
                                flex: 1,
                                child: Column(children: [
                                  Text(_tenureType,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Switch(
                                      activeColor: Color(0xff442243),
                                      value: _switchValue,
                                      onChanged: (bool value) {
                                        print(value);

                                        if (value) {
                                          _tenureType = _tenureTypes[1];
                                        } else {
                                          _tenureType = _tenureTypes[0];
                                        }

                                        setState(() {
                                          _switchValue = value;
                                        });
                                      })
                                ]))
                          ],
                        )),
                    Padding(padding: EdgeInsets.fromLTRB(5, 25, 5, 25)),
                    Flexible(
                        fit: FlexFit.loose,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: _handleCalculation,
                            child: Text("Calculate",
                                style: TextStyle(fontSize: 20)),
                            color: Color(0xff442243),
                            textColor: Colors.white,
                            padding: EdgeInsets.only(
                                top: 10.0,
                                bottom: 10.0,
                                left: 24.0,
                                right: 24.0))),
                    emiResultsWidget(_emiResult)
                  ],
                ))));
  }

  void _handleCalculation() {
    //  Amortization
    //  A = Payemtn amount per period
    //  P = Initial Printical (loan amount)
    //  r = interest rate
    //  n = total number of payments or periods

    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)"
        ? int.parse(_tenure.text) * 12
        : int.parse(_tenure.text);

    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));

    _emiResult = A.toStringAsFixed(2);

    setState(() {});
  }

  Widget emiResultsWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;

    if (_emiResult.length > 0) {
      canShow = true;
    }
    return Container(
        margin: EdgeInsets.only(top: 40.0),
        child: canShow
            ? Column(children: [
                Text("Your Monthly EMI is",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff442243))),
                Container(
                    child: Text(_emiResult,
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff442243))))
              ])
            : Container());
  }
}
