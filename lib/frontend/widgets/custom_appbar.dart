import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked_themes/stacked_themes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  const CustomAppbar({
    Key? key,
    this.title = 'Musixmatch',
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness iconBrightness =
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;
    final bool isDarkEnabled = Theme.of(context).brightness == Brightness.dark;

    final Color adaptiveColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return AppBar(
      iconTheme: IconThemeData(
        color: adaptiveColor,
      ),
      actionsIconTheme: IconThemeData(
        color: adaptiveColor,
      ),
      leading: leading,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.bold,
          color: adaptiveColor,
        ),
      ),
      actions: actions ??
          [
            IconButton(
              onPressed: () {
                getThemeManager(context).setThemeMode(
                  isDarkEnabled ? ThemeMode.light : ThemeMode.dark,
                );
              },
              icon: Icon(
                isDarkEnabled ? Iconsax.sun : Iconsax.moon,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.save_2,
              ),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
