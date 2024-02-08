import 'package:coronavirus/theme/assets.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _controller.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      _login();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() {
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: ThemeColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8 * 9, vertical: 64),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(Images.logomAlpha, height: 200, width: 200),
            ),
            Text(
              "Loading...",
              style: arialbold.copyWith(fontSize: 12, color: ThemeColors.black),
            ),
            const Gap(8),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeColors.white,
                        border: Border.all(
                          color: ThemeColors.black,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: LinearProgressIndicator(
                        value: _controller.value,
                        borderRadius: BorderRadius.circular(0),
                        minHeight: 16,
                        color: ThemeColors.black,
                      ),
                    ),
                    Text(
                      "${_controller.value * 100 ~/ 1}%",
                      style: arialbold.copyWith(
                        fontSize: 12,
                        color: ThemeColors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
