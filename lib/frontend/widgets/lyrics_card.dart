import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musixmatch/backend/blocs/track_lyrics_bloc.dart';
import 'package:musixmatch/backend/models/track_lyrics.dart';
import 'package:musixmatch/backend/providers/response_provider.dart';
import 'package:sizer/sizer.dart';

class LyricsCard extends StatelessWidget {
  final TrackLyricsBloc lyricsBloc;

  const LyricsCard({
    Key? key,
    required this.lyricsBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkEnabled = Theme.of(context).brightness == Brightness.light;

    return Container(
      constraints: BoxConstraints(
        minHeight: 50.h,
      ),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.w),
        color: isDarkEnabled ? Colors.grey[200] : Colors.grey,
      ),
      child: StreamBuilder<ResponseProvider<TrackLyricsResponse>>(
        stream: lyricsBloc.stream.asBroadcastStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.status == Status.LOADING) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.status == Status.ERROR) {
              return Center(
                child: Text('Error ${snapshot.data!.message}'),
              );
            } else {
              final trackLyrics =
                  snapshot.data!.data!.message!.body!.lyrics!.lyricsBody;
              return Text(
                trackLyrics!,
                style: GoogleFonts.nunitoSans(
                  color: Colors.black,
                  fontSize: 13.sp,
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
