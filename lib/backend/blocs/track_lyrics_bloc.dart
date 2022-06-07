import 'dart:async';
import 'dart:developer';

import 'package:musixmatch/backend/models/track_lyrics.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:musixmatch/backend/repositories/lyrics_repository.dart';

class TrackLyricsBloc {
  late TrackLyricsRepository _trackLyricsRepository;
  late StreamController<ResponseProvider<TrackLyricsResponse>>
      _streamController;
  late int trackId;
  StreamSink<ResponseProvider<TrackLyricsResponse>> get sink =>
      _streamController.sink;

  Stream<ResponseProvider<TrackLyricsResponse>> get stream =>
      _streamController.stream;

  TrackLyricsBloc({required this.trackId}) {
    _streamController =
        StreamController<ResponseProvider<TrackLyricsResponse>>.broadcast();
    _trackLyricsRepository = TrackLyricsRepository(trackId: trackId);
    fetchLyrics();
  }

  fetchLyrics() async {
    sink.add(ResponseProvider.loading('Loading Track Lyrics...'));
    try {
      TrackLyricsResponse trackLyrics =
          await _trackLyricsRepository.fetchLyrics();
      sink.add(ResponseProvider.completed(trackLyrics));
    } catch (e) {
      sink.add(ResponseProvider.error(e.toString()));
      log(e.toString());
    }
  }

  dispose() {
    _streamController.close();
  }
}
