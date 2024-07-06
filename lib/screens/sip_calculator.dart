import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../app_assets_constants/AppColors.dart';
import '../utils/appTools.dart';

class SipCalculator extends StatelessWidget {
  const SipCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Investments Calculator',
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: hexToColor(AppColors.homeBG),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  padding: EdgeInsets.all(
                      9 * MediaQuery.of(context).size.width / 360),
                  decoration: BoxDecoration(
                      color: hexToColor(AppColors.switchTabColor),
                      borderRadius: BorderRadius.all(Radius.circular(
                          8 * MediaQuery.of(context).size.width / 360))),
                  child: Row(
                    children: [
                      Consumer<WealthProvider>(
                          builder: (context, sipProvider, child) {
                        return Expanded(
                            child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.resolveWith(
                                (state) => hexToColor(
                                    context.read<WealthProvider>().current == 0
                                        ? AppColors.whiteTextColor
                                        : AppColors.switchTabColor)),
                          ),
                          onPressed: () {
                            if (context.read<WealthProvider>().current == 1)
                              context.read<WealthProvider>().setMode(0);
                          },
                          child: const Text(
                            "SIP",
                          ),
                        ));
                      }),
                      SizedBox(
                        width: 15,
                      ),
                      Consumer<WealthProvider>(
                          builder: (context, sipProvider, child) {
                        return Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              backgroundColor: WidgetStateProperty.resolveWith(
                                  (state) => hexToColor(
                                      context.read<WealthProvider>().current ==
                                              1
                                          ? AppColors.whiteTextColor
                                          : AppColors.switchTabColor)),
                            ),
                            onPressed: () {
                              if (context.read<WealthProvider>().current == 0)
                                context.read<WealthProvider>().setMode(1);
                            },
                            child: const Text(
                              "LumpSum",
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: hexToColor(AppColors.expectedColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.all(
                            9 * MediaQuery.of(context).size.width / 360),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12 *
                                      MediaQuery.of(context).size.width /
                                      360),
                              child: Text('Expected\nAmount',
                                  style: TextStyle(
                                      fontSize: 12 *
                                          MediaQuery.of(context).size.width /
                                          360)),
                            ),
                            Consumer<WealthProvider>(
                              builder: (context, sipProvider, child) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 20 *
                                          MediaQuery.of(context).size.width /
                                          360),
                                  child: Text(
                                      '\u{20B9} ${sipProvider.futureValue?.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 13 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            9 * MediaQuery.of(context).size.width / 360),
                        decoration: BoxDecoration(
                          color: hexToColor(AppColors.gainedColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12 *
                                      MediaQuery.of(context).size.width /
                                      360),
                              child: Text('Gained\nAmount',
                                  style: TextStyle(
                                      fontSize: 12 *
                                          MediaQuery.of(context).size.width /
                                          360)),
                            ),
                            Consumer<WealthProvider>(
                              builder: (context, sipProvider, child) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 20 *
                                          MediaQuery.of(context).size.width /
                                          360),
                                  child: Text(
                                      '\u{20B9} ${sipProvider.gains.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontSize: 13 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            9 * MediaQuery.of(context).size.width / 360),
                        decoration: BoxDecoration(
                          color: hexToColor(AppColors.investedColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12 *
                                      MediaQuery.of(context).size.width /
                                      360),
                              child: Text('Invested\nAmount',
                                  style: TextStyle(
                                      fontSize: 12 *
                                          MediaQuery.of(context).size.width /
                                          360)),
                            ),
                            Consumer<WealthProvider>(
                              builder: (context, sipProvider, child) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 20 *
                                          MediaQuery.of(context).size.width /
                                          360),
                                  child: Text(
                                      '\u{20B9} ${sipProvider.invested.round()}',
                                      style: TextStyle(
                                          fontSize: 13 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360)),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: hexToColor(AppColors.inputFieldBorderColor)
                                  .withOpacity(0.6)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Consumer<WealthProvider>(
                                builder: (context, sipProvider, child) {
                              return Text(
                                sipProvider.current == 0
                                    ? 'Monthly Investment'
                                    : 'LumpSum Investment',
                                style: TextStyle(fontSize: 12),
                              );
                            }),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: hexToColor(AppColors.fieldValueColor)
                                      .withOpacity(0.23),
                                  border: Border.all(
                                      width: 1,
                                      color: hexToColor(
                                          AppColors.switchLabelBorderColor)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: TextField(
                                controller: context
                                    .read<WealthProvider>()
                                    .controllerInvestment,
                                decoration: InputDecoration(
                                  prefix: Text(" \u{20B9} "),
                                  suffix: Text("  "),
                                  border: InputBorder
                                      .none, // This removes the underline
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  try {
                                    context
                                        .read<WealthProvider>()
                                        .setMonthlyInvestment(
                                            double.parse(value));
                                  } catch (e) {
                                    // handle the error
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: hexToColor(AppColors.inputFieldBorderColor)
                                  .withOpacity(0.6)),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              'Duration (years)',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: hexToColor(AppColors.fieldValueColor)
                                      .withOpacity(0.23),
                                  border: Border.all(
                                      width: 1,
                                      color: hexToColor(
                                          AppColors.switchLabelBorderColor)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: context
                                    .read<WealthProvider>()
                                    .controllerDuration,
                                decoration: const InputDecoration(
                                  prefix: Text("    "),
                                  suffix: Text("yrs "),
                                  border: InputBorder
                                      .none, // This removes the underline
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  try {
                                    context
                                        .read<WealthProvider>()
                                        .setDurationYears(int.parse(value));
                                  } catch (e) {
                                    // handle the error
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: hexToColor(AppColors.inputFieldBorderColor)
                                .withOpacity(0.6)),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            'Expected Rtn (% yearly)',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: hexToColor(AppColors.fieldValueColor)
                                    .withOpacity(0.23),
                                border: Border.all(
                                    width: 1,
                                    color: hexToColor(
                                        AppColors.switchLabelBorderColor)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: TextField(
                              controller: context
                                  .read<WealthProvider>()
                                  .controllerExpectedRtn,
                              decoration: const InputDecoration(
                                prefix: Text("    "),
                                suffix: Text("%    "),
                                border: InputBorder
                                    .none, // This removes the underline
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                try {
                                  context
                                      .read<WealthProvider>()
                                      .setSelectedPercent(double.parse(value));
                                } catch (e) {
                                  // handle the error
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: 'Note:\n',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: '• Monthly Contributions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'SIP involves regular monthly investments, not a lump sum.\n',
                    ),
                    TextSpan(
                      text: '• Compounding Effect: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Returns are compounded monthly, leading to a more accurate reflection of growth.\n',
                    ),
                    TextSpan(
                      text: '• Different Calculation Method: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'The SIP calculator uses monthly compounding, which differs from a simple annual return calculation.\n',
                    ),
                    TextSpan(
                      text: '• Effective Annual Growth: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'The growth rate appears lower due to the way returns are calculated over time with compounding.\n',
                    ),
                  ],
                ),
              )

              // ElevatedButton(
              //   onPressed: () {
              //     context.read<WealthProvider>().calculateFuture();
              //   },
              //   child: const Text('Calculate'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

double calculateSip(
    double ratePA, double monthlyInvestment, int durationYears) {
  double r = ratePA;
  r = (r / 12.0) / 100.0;
  int n = durationYears * 12;
  double futureValue = monthlyInvestment * ((pow(1 + r, n) - 1) / r) * (1 + r);

  return futureValue;
}

class WealthProvider with ChangeNotifier {
  int selected = 1;
  int current = 0;
  double _monthlyInvestment = 1000.0;
  int _durationYears = 1;
  double _retPA = 14.0;
  double _futureValue = 0.0;
  double invested = 0.0;
  double gains = 0.0;

  WealthProvider() {
    calculateFuture();
  }

  TextEditingController controllerInvestment =
      TextEditingController(text: '1000');
  TextEditingController controllerDuration = TextEditingController(text: '1');
  TextEditingController controllerExpectedRtn =
      TextEditingController(text: '14');

  double get monthlyInvestment => _monthlyInvestment;
  int get durationYears => _durationYears;
  double get percentage => _retPA;
  double? get futureValue => _futureValue;

  void setMonthlyInvestment(double value) {
    _monthlyInvestment = value;
    // notifyListeners();
    notifyListeners();
    calculateFuture();
  }

  void setDurationYears(int value) {
    if (value >= 1) {
      _durationYears = value;
      // notifyListeners();
      notifyListeners();
      calculateFuture();
    }
  }

  void setSelectedPercent(double papy) {
    _retPA = papy;
    notifyListeners();
    calculateFuture();
  }

  void calculateFuture() {
    if (current == 0) {
      calculateFutureSipValue();
    } else {
      calculateFutureLumpSumValue();
    }
  }

  void calculateFutureSipValue() {
    _futureValue = calculateSip(_retPA, _monthlyInvestment, _durationYears);
    invested = monthlyInvestment * _durationYears * 12;
    gains = ((_futureValue ?? 0) - invested);
    notifyListeners();
  }

  double calculateLumpSum(double principal, double annualRate, int years) {
    double r = annualRate / 100; // Convert percentage to decimal
    double t = years.toDouble();
    double futureValue = principal * pow(1 + r, t);
    return futureValue;
  }

  void calculateFutureLumpSumValue() {
    _futureValue = calculateLumpSum(_monthlyInvestment, _retPA, _durationYears);
    invested = monthlyInvestment;
    gains = ((_futureValue ?? 0) - invested);
    notifyListeners();
  }

  void setMode(int i) {
    current = i;
    _futureValue = 0.0;
    if (current == 0) {
      _monthlyInvestment = 1000.0;
      controllerInvestment.text = "1000";
    } else {
      _monthlyInvestment = 25000.0;
      controllerInvestment.text = "25000";
    }
    _durationYears = 1;
    controllerDuration.text = "1";
    _retPA = 14;
    controllerExpectedRtn.text = "14";
    gains = 0.0;
    invested = 0.0;
    calculateFuture();
    notifyListeners();
  }
}
