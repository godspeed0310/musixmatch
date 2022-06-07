import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultSystemOverlay extends StatelessWidget {
  final Scaffold scaffold;
  const DefaultSystemOverlay({
    Key? key,
    required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness iconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: scaffold,
    );
  }
}
