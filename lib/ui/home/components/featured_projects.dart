import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

class FeatureProjects extends StatelessWidget {
  const FeatureProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Featured Projects",
            style: textTheme.displaySmall!.copyWith(
              color: PortfolioAppTheme.nameColor,
            ),
          ),
          SizedBox(height: context.height * 0.05),
          // GridView.builder(
          //     itemCount: 2,
          //     physics: const NeverScrollableScrollPhysics(),
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: 8,
          //       mainAxisSpacing: 10,
          //     ),
          //     itemBuilder: (context, __) => Container(
          //           width: context.width * 0.1,
          //           height: context.height * 0.1,
          //           color: Colors.grey,
          //         ))
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: context.width * 0.32,
                height: context.height * 0.42,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      width: context.width * 0.3,
                      height: context.height * 0.3,
                      "assets/imgs/fitness_challenge.png",
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: context.height * 0.005),
                    Text("Fitness Challenge App", style: textTheme.titleSmall),
                    SizedBox(height: context.height * 0.005),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: PortfolioAppTheme.nameColor),
                        onPressed: () {},
                        child: const Text("Github Link"))
                  ],
                ),
              ),
              SizedBox(width: context.width * 0.01),
              Container(
                width: context.width * 0.32,
                height: context.height * 0.42,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      width: context.width * 0.3,
                      height: context.height * 0.3,
                      "assets/imgs/snaptik_video_downloader.jpg",
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: context.height * 0.005),
                    Text("Snaptik Video Downloader",
                        style: textTheme.titleSmall),
                    SizedBox(height: context.height * 0.005),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: PortfolioAppTheme.nameColor),
                        onPressed: () {},
                        child: const Text("Github Link"))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
