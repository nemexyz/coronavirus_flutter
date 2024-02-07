import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  final bool dark;
  const CircularLoading({super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dark ? Colors.black : Colors.white,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
