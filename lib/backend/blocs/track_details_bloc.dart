import 'dart:async';
import 'dart:developer';

import 'package:musixmatch/backend/models/track_details.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:musixmatch/backend/repositories/details_repository.dart';

class TrackDetailsBloc {
  late DetailsRepository _trackRepository;
  late StreamController<ResponseProvider<TrackDetailsResponse>>
      _streamController;
  int trackId;

  StreamSink<ResponseProvider<TrackDetailsResponse>> get _detailsSink =>
      _streamController.sink;

  Stream<ResponseProvider<TrackDetailsResponse>> get detailsStream =>
      _streamController.stream;

  TrackDetailsBloc({
    required this.trackId,
  }) {
    _trackRepository = DetailsRepository(trackId: trackId);
    _streamController =
        StreamController<ResponseProvider<TrackDetailsResponse>>.broadcast();
  }

  fetchTrackDetails() async {
    _detailsSink.add(ResponseProvider.loading('Loading Track Details...'));
    try {
      TrackDetailsResponse trackDetails =
          await _trackRepository.fetchTrackDetails();
      _detailsSink.add(ResponseProvider.completed(trackDetails));
    } catch (e) {
      _detailsSink.add(ResponseProvider.error(e.toString()));
      log(e.toString());
    }
  }

  dispose() {
    _streamController.close();
  }
}
