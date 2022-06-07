import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityBloc {
  late StreamController<ConnectivityResult> _connectivityController;
  StreamSink<ConnectivityResult> get connectivitySink =>
      _connectivityController.sink;
  Stream<ConnectivityResult> get connectivityStream =>
      _connectivityController.stream;

  ConnectivityBloc() {
    _connectivityController = StreamController<ConnectivityResult>.broadcast();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connectivityController.add(result);
    });
  }

  void checkConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    _connectivityController.add(connectivityResult);
  }

  dispose() {
    _connectivityController.close();
  }
}
