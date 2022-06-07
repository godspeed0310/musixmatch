import 'dart:async';

import 'package:musixmatch/backend/models/track.dart';
import 'package:musixmatch/backend/providers/base_provider.dart';
import 'package:musixmatch/frontend/shared/shared_constants.dart';

class TrackRepository {
  final BaseProvider _provider = BaseProvider();
  Future<TrackResponse> fetchMusicListData() async {
    final response =
        await _provider.get("chart.tracks.get?apikey=$apiKey&f_has_lyrics=1");
    return TrackResponse.fromJson(response);
  }
}
