import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:musixmatch/backend/blocs/connectivity_bloc.dart';
import 'package:musixmatch/frontend/widgets/custom_appbar.dart';
import 'package:musixmatch/frontend/widgets/default_system_overlay.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ConnectivityBloc _connectivityBloc = ConnectivityBloc();

  @override
  void dispose() {
    _connectivityBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultSystemOverlay(
      scaffold: Scaffold(
        appBar: const CustomAppbar(),
        body: StreamBuilder<ConnectivityResult>(
          stream: _connectivityBloc.connectivityStream.asBroadcastStream(),
          builder: (context, snapshot) {
            if (snapshot.data == ConnectivityResult.none) {
              return const Center(
                child: Text('No internet connection'),
              );
            } else {
              return const Center(
                child: Text('Connected'),
              );
            }
          },
        ),
      ),
    );
  }
}
