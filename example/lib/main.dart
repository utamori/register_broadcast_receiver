import 'package:flutter/material.dart';
import 'package:register_broadcast_receiver/intent_filter.dart';
import 'package:register_broadcast_receiver/register_broadcast_receiver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataReceiver? dataReceiver;

  @override
  void initState() {
    BroadcastReceiver.registerBroadcast(IntentFilter(actions: [
      IntentFilter.ACTION_PACKAGE_ADDED,
      IntentFilter.ACTION_PACKAGE_REMOVED,
    ], categories: [], dataSchemes: [
      'package'
    ])).listen((event) {
      setState(() {
        dataReceiver = event;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: dataReceiver == null
              ? const SizedBox()
              : Column(
                  children: [
                    Text(dataReceiver?.action ?? 'no action'),
                    Text(dataReceiver?.data ?? 'no data'),
                  ],
                ),
        ),
      ),
    );
  }
}
