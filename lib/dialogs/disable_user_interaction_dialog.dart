import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DisableUserInteractionDialog extends StatelessWidget {
  const DisableUserInteractionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: SpinKitFadingCircle(
          size: MediaQuery.of(context).size.width / 6,
          color: Colors.white,
        ),
      ),
    );
  }
}
