import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_container/widgets/tab_container.dart';

import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return const MaterialApp(
      home: Scaffold(
        body: TabContainer(images: images),
      ),
    );
  }
}
