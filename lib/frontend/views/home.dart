import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:musixmatch/backend/blocs/connectivity_bloc.dart';
import 'package:musixmatch/backend/blocs/tracks_bloc.dart';
import 'package:musixmatch/backend/models/track.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:musixmatch/frontend/widgets/custom_appbar.dart';
import 'package:musixmatch/frontend/widgets/default_system_overlay.dart';
import 'package:musixmatch/frontend/widgets/track_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ConnectivityBloc _connectivityBloc = ConnectivityBloc();
  final TracksBloc _tracksBloc = TracksBloc();

  @override
  void dispose() {
    _connectivityBloc.dispose();
    _tracksBloc.dispose();
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
              _tracksBloc.fetchMusic();
              return LiquidPullToRefresh(
                onRefresh: () => _tracksBloc.fetchMusic(),
                child: StreamBuilder<ResponseProvider<TrackResponse>>(
                  stream: _tracksBloc.trackStream.asBroadcastStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.status == Status.LOADING) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.status == Status.COMPLETED) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const TrackTile();
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: 10,
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.data!.message}',
                          ),
                        );
                      }
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
