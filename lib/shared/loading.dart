import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        ///best spinners are
        ///1. spinning lines
        ///2. wave
        ///3. cube grid
        ///4. chasing dots
        ///5. folding cube

        child: SpinKitSpinningLines(
          color: Colors.brown,
          size: 100.0,
        ),
      ),
    );
  }
}
