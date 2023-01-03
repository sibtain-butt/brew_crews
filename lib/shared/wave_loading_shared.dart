import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaveLoadingShared extends StatelessWidget {
  const WaveLoadingShared({Key? key}) : super(key: key);

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

        child: SpinKitWave(
          color: Colors.brown.shade400,
          size: 50.0,
        ),
      ),
    );
  }
}
