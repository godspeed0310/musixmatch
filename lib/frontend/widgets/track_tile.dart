import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:musixmatch/backend/models/track.dart';
import 'package:musixmatch/frontend/views/details.dart';
import 'package:sizer/sizer.dart';

class TrackTile extends StatelessWidget {
  final Track track;

  const TrackTile({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: OpenContainer(
        closedColor: Colors.transparent,
        openElevation: 0,
        closedElevation: 0,
        openColor: Colors.transparent,
        transitionType: ContainerTransitionType.fade,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Ink(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            height: 11.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 10.h,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.music,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.trackName ?? 'Untitled',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Text(
                        'Miley Cyrus',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.more_horiz,
                ),
              ],
            ),
          );
        },
        openBuilder: (BuildContext _, VoidCallback __) {
          return const DetailsView();
        },
      ),
    );
  }
}
