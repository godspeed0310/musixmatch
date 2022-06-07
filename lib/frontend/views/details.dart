import 'package:flutter/material.dart';
import 'package:musixmatch/frontend/widgets/custom_appbar.dart';
import 'package:musixmatch/frontend/widgets/default_system_overlay.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultSystemOverlay(
      scaffold: Scaffold(
        appBar: CustomAppbar(
          title: 'Track Details',
        ),
      ),
    );
  }
}
