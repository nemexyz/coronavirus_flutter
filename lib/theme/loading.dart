import 'package:coronavirus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: themeProvider.isDarkMode() ? Colors.black : Colors.white,
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
                    color: themeProvider.isDarkMode()
                        ? Colors.white
                        : Colors.black,
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
