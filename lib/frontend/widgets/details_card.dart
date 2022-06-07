import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:musixmatch/backend/models/track_details.dart';
import 'package:musixmatch/frontend/widgets/item_card.dart';
import 'package:sizer/sizer.dart';

class DetailsCard extends StatelessWidget {
  final TrackDetailsResponse trackDetails;
  const DetailsCard({
    Key? key,
    required this.trackDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trackDetailsData = trackDetails.message!.body!.track;
    final Color adaptiveColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return ListView(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.w),
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Icon(Iconsax.music),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              trackDetailsData!.trackName ?? 'Untitled',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            if (trackDetailsData.albumName != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'From the album ',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.sp,
                      color: adaptiveColor,
                    ),
                    children: [
                      TextSpan(
                        text: trackDetailsData.albumName,
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 2.h,
            ),
            if (trackDetailsData.albumName == null)
              Text(
                'Single',
                style: GoogleFonts.nunitoSans(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            RichText(
              text: TextSpan(
                text: 'By ',
                style: GoogleFonts.nunitoSans(
                  fontSize: 15.sp,
                  color: adaptiveColor,
                ),
                children: [
                  TextSpan(
                    text: trackDetailsData.artistName ?? 'Unknown',
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 7.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ItemCard(
                    icon: Iconsax.heart5,
                    value: '${trackDetailsData.trackRating.toString()}%',
                  ),
                  VerticalDivider(
                    color: adaptiveColor.withOpacity(0.7),
                  ),
                  ItemCard(
                    icon: trackDetailsData.explicit == 1
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                    value:
                        trackDetailsData.explicit == 1 ? 'Explicit' : 'Clean',
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
