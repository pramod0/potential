import 'package:flutter/material.dart';
import 'package:potential/utils/AllData.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app_assets_constants/AppColors.dart';

// Define a class to hold the investment data
class InvestmentData {
  final String type;
  final double amount;
  final Color color;

  InvestmentData(this.type, this.amount, this.color);
}

// Define a provider class to manage the state
class InvestmentDataProvider with ChangeNotifier {
  List<InvestmentData> _investments = [];

  List<InvestmentData> get investments => _investments;

  void setInvestments(List<InvestmentData> investments) {
    _investments = investments;
    // notifyListeners();
  }
}

// Widget to display the investment graph
class InvestmentGraph extends StatefulWidget {
  final List<InvestmentData> data;

  InvestmentGraph(this.data);

  @override
  State<InvestmentGraph> createState() => _InvestmentGraphState();
}

class _InvestmentGraphState extends State<InvestmentGraph> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              majorGridLines:
                  MajorGridLines(width: 0), // Remove major grid lines
              //minorGridLines: MinorGridLines(width: 0),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines:
                  MajorGridLines(width: 0), // Remove major grid lines
              minorGridLines:
                  MinorGridLines(width: 0), // Remove minor grid lines
            ),
            enableAxisAnimation: true,
            series: <CartesianSeries>[
              ColumnSeries<InvestmentData, String>(
                dataSource: widget.data,
                xValueMapper: (InvestmentData investment, _) => investment.type,
                yValueMapper: (InvestmentData investment, _) =>
                    investment.amount,
                color: const Color.fromRGBO(53, 92, 125, 1),
                // Default color for bars
                pointColorMapper: (InvestmentData investment, _) =>
                    investment.color,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
            //     annotations: <CartesianChartAnnotation>[
            //   CartesianChartAnnotation(
            //     widget: Container(
            //       padding: const EdgeInsets.all(5),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(5),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             spreadRadius: 1,
            //             blurRadius: 3,
            //             offset: const Offset(0, 2), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: const Text(
            //         'Annotation', // You can customize the annotation text here
            //         style: TextStyle(color: Colors.black),
            //       ),
            //     ),
            //     coordinateUnit: CoordinateUnit.logicalPixel,
            //     x: 0, // X-coordinate (in pixel) of the annotation
            //     y: AllData.investedData
            //         .invested, // Y-coordinate (in data value) of the annotation
            //   ),
            // ] // Y-coordinate (in data value) of the annotation,
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final double amount;
  final DateTime date;

  Transaction(this.amount, this.date);
}

class GraphValuesUtility {
  static List<Transaction> list = [];

  static createTransaction() async {
    if (list.isEmpty) {
      for (var element in AllData.investedData.fundData) {
        // print("${element.fundCode} ${element.schemeCode}");
        element.invested != 0
            ? list.add(Transaction(
                element.invested, DateTime.parse(element.sinceDate)))
            : print("Omitted");
      }
    }
    print(list[0].date);
  }

  static double calculateFDTillDate(
      List<Transaction> transactions, double rate) {
    double totalFD = 0;

    // Iterate over transactions
    for (Transaction transaction in transactions) {
      // Calculate days between invested date and transaction date
      int days = DateTime.now().difference(transaction.date).inDays;

      // Calculate FD amount till transaction date
      double fdAmount = (transaction.amount * rate * days) / (100 * 365);

      // Add FD amount to total
      totalFD +=
          (fdAmount + transaction.amount); // calculated for each transaction
    }

    return totalFD;
  }

  static double calculateSimpleInterestTillDate(
      List<Transaction> transactions, double rate) {
    double totalInterest = 0;

    // Iterate over transactions
    for (Transaction transaction in transactions) {
      // Calculate days between invested date and transaction date
      int days = DateTime.now().difference(transaction.date).inDays;

      // Calculate simple interest for this transaction
      double interest = (transaction.amount * rate * days) / (100 * 365);
      // double interest = transaction.amount *
      //     (pow(1 + rate / 100, days / 365) - 1);

      // Add interest to total
      totalInterest += (interest + transaction.amount);
    }

    return totalInterest;
  }

  static double calculateSimpleInterest(
      double principal, double rate, DateTime investedDate) {
    // Get today's date
    DateTime today = DateTime.now();

    // Calculate the duration in days
    int days = today.difference(investedDate).inDays;

    // Calculate simple interest
    double interest = (principal * rate * days) / (100 * 365);

    return interest;
  }

  static double calculateFDSimpleInterestToToday(
      double principal, double rate, DateTime investedDate) {
    // Get today's date
    DateTime today = DateTime.now();

    // Calculate the duration in days
    int days = today.difference(investedDate).inDays;

    // Calculate simple interest
    double interest = (principal * rate * days) / (100 * 365);

    return interest;
  }
}

// Widget to display the vertical constant line
// class VerticalLine extends StatelessWidget {
//   final double investment;
//
//   const VerticalLine(this.investment, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 0,
//       top: 0,
//       bottom: 0,
//       child: Container(
//         width: 2,
//         color: Colors.red, // You can change the color as needed
//       ),
//     );
//   }
// }

// Main widget combining the graph and the vertical line
class GraphAnalysisScreen extends StatelessWidget {
  const GraphAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GraphValuesUtility.list = [];
    GraphValuesUtility.createTransaction();
    final investmentProvider =
        Provider.of<InvestmentDataProvider>(context, listen: true);

    // Mock data
    investmentProvider.setInvestments([
      InvestmentData("Invested", AllData.investedData.invested.roundToDouble(),
          Colors.blueAccent.shade100),
      InvestmentData(
          "Savings",
          // (AllData.investedData.invested +
          //         GraphValuesUtility.calculateSimpleInterest(
          //             AllData.investedData.invested,
          //             3.5,
          //             DateTime(2024, 2, 12)))
          //     .roundToDouble(),

          GraphValuesUtility.calculateSimpleInterestTillDate(
            GraphValuesUtility.list,
            3.08,
          ).roundToDouble(),
          Colors.orangeAccent),
      InvestmentData(
          "Fixed",
          // (AllData.investedData.invested +
          //         GraphValuesUtility.calculateFDSimpleInterestToToday(
          //             AllData.investedData.invested,
          //             6.75,
          //             DateTime(2024, 2, 12)))
          //     .roundToDouble(),
          GraphValuesUtility.calculateSimpleInterestTillDate(
            GraphValuesUtility.list,
            6.51,
          ).roundToDouble(),
          Colors.redAccent),
      InvestmentData("Mutual Fund",
          AllData.investedData.current.roundToDouble(), Colors.greenAccent),
    ]);

    // final double totalInvestment = investmentProvider.investments
    //     .fold(0, (previousValue, element) => previousValue + element.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Analysis'),
        // leading: GestureDetector(
        //   onTap: () => {
        //     GraphValuesUtility.list = [],
        //     Navigator.of(context).pop(),
        //   },
        //   child: const Icon(Icons.arrow_back),
        // ),
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: InvestmentGraph(investmentProvider.investments)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: AppColors.whiteTextColor,
                  //Colors.black.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.black26.withOpacity(0.2),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("*Note:"),
                  const Text(
                      "1. The average interest rate for a fixed deposit is approximately 6.19%, and for senior citizens it is approximately 6.83%."),
                  const Text(
                      "2. The average savings account interest rate is approximately 3.08%"),
                  const Text(
                      "3. For Calculations we have taken FD rate as 6.51% and Savings rate as 3.08%"),
                  Text(
                      "4. These are approx. values as of Date-${DateTime.now().toString().substring(0, 11)}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
