// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart' as foundation;
// import 'package:path_provider/path_provider.dart';
//
//
// // Define the log levels directly as integers
// const int LOG_LEVEL_ERROR = 2000; // Example value for error
// const int LOG_LEVEL_INFO = 300; // Example value for info
// const int LOG_LEVEL_ACK = 200; // Example value for acknowledgment
//
// typedef FunctionWithArguments = dynamic Function(
//     List<dynamic> positionalArguments, Map<Symbol, dynamic> namedArguments);
//
// class MyFunction {
//   final FunctionWithArguments function;
//
//   MyFunction(this.function);
//
//   @override
//   dynamic noSuchMethod(Invocation invocation) {
//     if (invocation.isMethod && invocation.memberName == const Symbol('call')) {
//       return function(
//           invocation.positionalArguments, invocation.namedArguments);
//     }
//     return;
//   }
// }
//
// void typeMessage(name) {
//   log(name, level: LOG_LEVEL_ERROR, time: DateTime.now());
// }
//
// class ERROR {
//   static get LOG => new MyFunction((p, n) {
//         typeMessage("/////ERROR/////");
//         for (var a in p) {
//           LogWriter.LOG(a.toString(),
//               level: LOG_LEVEL_ERROR, prefix: a.hashCode.toString());
//         }
//       });
// }
//
// class INFO {
//   static get LOG {
//     return new MyFunction((p, n) {
//       typeMessage("-----INFO-----");
//
//       for (var a in p) {
//         LogWriter.LOG(a.toString(),
//             level: LOG_LEVEL_ERROR, prefix: a.hashCode.toString());
//       }
//     });
//   }
// }
//
// class ACK {
//   static get LOG => new MyFunction((p, n) {
//         typeMessage("=====ACK=====");
//         for (var a in p) {
//           LogWriter.LOG(a.toString(),
//               level: 2000, prefix: a.hashCode.toString());
//         }
//       });
// }
//
// class LogWriter {
//   static Future<void> _writeToFile(String message) async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       print('LOG written to ${directory.path}/app_logs.txt');
//       final file = File('${directory.path}/app_logs.txt');
//       await file.writeAsString('$message\n', mode: FileMode.append);
//     } catch (e) {
//       print('LOG debarred to /app_logs.txt with $e');
//     }
//   }
//
//   static void LOG(String message,
//       {int level = LOG_LEVEL_INFO, String prefix = ""}) {
//     _log(message, level: LOG_LEVEL_INFO, prefix: "");
//   }
//
//   static void _log(String message,
//       {int level = LOG_LEVEL_INFO, String prefix = ""}) {
//     final fullMessage = "${prefix + " "}$message";
//
//     // Always print to console
//     if (!foundation.kReleaseMode) {
//       log(fullMessage);
//     }
//
//     // Write to file in release mode
//     // if (foundation.kReleaseMode &&
//     if ((TestingEnvironment.isTestApp || TestingEnvironment.isDemoApp)) {
//       _writeToFile(fullMessage);
//     }
//   }
// }
