import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/pages/splash/splash_page_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../constants/string_constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      Provider.of<SplashPageViewModel>(context, listen: false).handleStartUpLogic(version);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              width: context.sized.dynamicWidth(1),
              height: context.sized.dynamicHeight(1),
              ImageConstants.splashPageBg,
              fit: BoxFit.fill,
            ),
            Center(
              child: DefaultTextStyle(
                style: context.general.textTheme.headlineMedium!.copyWith(
                  color: ColorConstants.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(StringConstants.appName),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
