import 'package:flutter/material.dart';
import 'package:scan_app/pres/widgets/save_dilog.dart';

import 'dilog.dart';

class ParacticePage extends StatelessWidget {
  const ParacticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => Dilog());
          },
          child: Text('data'),
        ),
      ),
    );
  }
}
