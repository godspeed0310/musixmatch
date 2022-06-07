import 'package:musixmatch/backend/models/track_details.dart';
import 'package:musixmatch/backend/providers/base_provider.dart';

import '../../frontend/shared/shared_constants.dart';

class DetailsRepository {
  final int trackId;
  DetailsRepository({required this.trackId});
  final BaseProvider _provider = BaseProvider();
  Future<TrackDetailsResponse> fetchTrackDetails() async {
    final response = await _provider.get(
      'track.get?track_id=$trackId&apikey=$apiKey',
    );
    return TrackDetailsResponse.fromJson(response);
  }
}
