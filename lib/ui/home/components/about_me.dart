import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_strings.dart';
import 'package:portfolio_danish/utils/app_theme.dart';
import 'package:portfolio_danish/widgets/my_photo.dart';
import 'package:universal_html/html.dart' as html;

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: context.width * 0.06),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, I'm",
                style: textTheme.titleLarge!.copyWith(
                    color: PortfolioAppTheme.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: context.height * 0.01),
              Text(
                "Danish Hafeez",
                style: context.width > 456
                    ? textTheme.displayLarge!.copyWith(
                        color: PortfolioAppTheme.nameColor,
                        fontWeight: FontWeight.w700)
                    : textTheme.displayMedium!.copyWith(
                        color: PortfolioAppTheme.nameColor,
                        fontWeight: FontWeight.w700),
              ),
              SizedBox(height: context.height * 0.01),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TyperAnimatedText(
                    "A Mobile App Developer",
                    textStyle: textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                    speed: const Duration(milliseconds: 120),
                  ),
                  TyperAnimatedText(
                    "A UI/UX Designer",
                    textStyle: textTheme.titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                  TyperAnimatedText(
                    "A Web App Developer",
                    textStyle: textTheme.titleMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                isRepeatingAnimation: true,
              ),
              SizedBox(height: context.height * 0.02),
              SizedBox(
                height: context.height * 0.042,
                child: ElevatedButton.icon(
                  onPressed: () {
                    html.window.open(AppStrings.resume, "pdf");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PortfolioAppTheme.white,
                  ),
                  icon: const Icon(Icons.download,
                      color: PortfolioAppTheme.nameColor),
                  label: FittedBox(
                    child: Text(
                      "Download Resume",
                      style: textTheme.titleMedium!.copyWith(
                        color: PortfolioAppTheme.greyButtonColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.03),
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: context.width * 0.6,
                  child: context.width > 550
                      ? Text(
                          "Passionate Flutter developer with 4+ years of experience, always exploring the latest advancements in the Flutter ecosystem. I focus on building scalable, high-performance apps with clean architecture and future-proof solutions.",
                          style: textTheme.titleMedium,
                          // softWrap: true,
                        )
                      : const SizedBox(),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: context.width * 0.03),
        const Myphoto(),
        SizedBox(width: context.width * 0.11)
      ],
    );
  }
}
