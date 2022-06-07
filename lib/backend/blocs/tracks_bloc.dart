import 'dart:async';
import 'dart:developer';

import 'package:musixmatch/backend/models/track.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:musixmatch/backend/repositories/track_repository.dart';

class TracksBloc {
  late TrackRepository _trackRepository;
  late StreamController<ResponseProvider<TrackResponse>> _trackController;

  StreamSink<ResponseProvider<TrackResponse>> get trackSink =>
      _trackController.sink;

  Stream<ResponseProvider<TrackResponse>> get trackStream =>
      _trackController.stream;

  TracksBloc() {
    _trackController =
        StreamController<ResponseProvider<TrackResponse>>.broadcast();
    _trackRepository = TrackRepository();
    fetchMusic();
  }

  fetchMusic() async {
    trackSink.add(ResponseProvider.loading('Loading Tracks...'));
    try {
      TrackResponse tracks = await _trackRepository.fetchMusicListData();
      trackSink.add(ResponseProvider.completed(tracks));
    } catch (e) {
      trackSink.add(ResponseProvider.error(e.toString()));
      log(e.toString());
    }
  }

  dispose() {
    _trackController.close();
  }
}
