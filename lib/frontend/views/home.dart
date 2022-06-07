import 'package:flutter/material.dart';
import 'package:musixmatch/frontend/widgets/custom_appbar.dart';
import 'package:musixmatch/frontend/widgets/default_system_overlay.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const DefaultSystemOverlay(
      scaffold: Scaffold(
        appBar: CustomAppbar(),
      ),
    );
  }
}
