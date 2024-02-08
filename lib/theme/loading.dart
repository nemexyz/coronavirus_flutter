import 'package:coronavirus/theme/assets.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_indicators/progress_indicators.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      color: theme.isDarkMode() ? ThemeColors.darkGrey : ThemeColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    color: theme.isDarkMode()
                        ? ThemeColors.white
                        : ThemeColors.darkGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VirusLoader extends StatelessWidget {
  const VirusLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HeartbeatProgressIndicator(
        child: SizedBox(
          height: 40.0,
          child: Image(
            height: MediaQuery.of(context).size.height,
            image: const AssetImage(Images.loader),
          ),
        ),
      ),
    );
  }
}
