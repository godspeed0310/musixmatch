import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:musixmatch/backend/blocs/connectivity_bloc.dart';
import 'package:musixmatch/backend/blocs/track_details_bloc.dart';
import 'package:musixmatch/backend/models/track.dart' as a;
import 'package:musixmatch/backend/models/track_details.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:musixmatch/frontend/widgets/custom_appbar.dart';
import 'package:musixmatch/frontend/widgets/default_system_overlay.dart';
import 'package:musixmatch/frontend/widgets/details_card.dart';

class DetailsView extends StatefulWidget {
  final a.Track track;
  const DetailsView({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late ConnectivityBloc _connectivityBloc;
  late TrackDetailsBloc _detailsBloc;

  @override
  void initState() {
    super.initState();
    _connectivityBloc = ConnectivityBloc();
    _detailsBloc = TrackDetailsBloc(trackId: widget.track.trackId!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultSystemOverlay(
      scaffold: Scaffold(
        appBar: const CustomAppbar(
          title: 'Track Details',
        ),
        body: StreamBuilder<ConnectivityResult>(
          stream: _connectivityBloc.connectivityStream.asBroadcastStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.none) {
                return const Center(
                  child: Text('No internet connection'),
                );
              } else {
                _detailsBloc.fetchTrackDetails();
                return LiquidPullToRefresh(
                  onRefresh: () => _detailsBloc.fetchTrackDetails(),
                  child: StreamBuilder<ResponseProvider<TrackDetailsResponse>>(
                    stream: _detailsBloc.detailsStream.asBroadcastStream(),
                    builder: (context, snaphot) {
                      if (snaphot.hasData) {
                        if (snaphot.data!.status == Status.LOADING) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snaphot.data!.status == Status.COMPLETED) {
                          return DetailsCard(
                            trackDetails: snaphot.data!.data!,
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'Something went wrong',
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
