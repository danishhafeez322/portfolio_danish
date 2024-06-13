import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';

import '../../../utils/app_theme.dart';

class FeatureProjects extends StatelessWidget {
  const FeatureProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final imgList = [
      'assets/imgs/fitness_challenge.png',
      'assets/imgs/snaptik_video_downloader.jpg',
      'assets/imgs/fitness_challenge.png'
    ];
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Projects',
            style: textTheme.displaySmall!.copyWith(
              color: PortfolioAppTheme.nameColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.height * 0.03),
          GridView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.width > 456 ? 3 : 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Image.asset(
                      width: double.infinity,
                      imgList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: context.height * 0.005),
                  FittedBox(
                    child: Text("Fitness Challenge App",
                        style: textTheme.titleSmall),
                  ),
                  SizedBox(height: context.height * 0.005),
                  SizedBox(
                    height: context.height * 0.037,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: PortfolioAppTheme.nameColor),
                      onPressed: () {},
                      child: const FittedBox(
                        child: Text("Github Link"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
