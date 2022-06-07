import 'package:musixmatch/backend/models/track_lyrics.dart';
import 'package:musixmatch/backend/providers/base_provider.dart';

import '../../frontend/shared/shared_constants.dart';

class TrackLyricsRepository {
  final int trackId;
  TrackLyricsRepository({required this.trackId});
  final BaseProvider _provider = BaseProvider();
  Future<TrackLyricsResponse> fetchLyrics() async {
    final response = await _provider.get(
      "track.lyrics.get?track_id=$trackId&apikey=$apiKey",
    );
    return TrackLyricsResponse.fromJson(response);
  }
}
