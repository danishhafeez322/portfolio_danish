import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

class FeatureProjects extends StatelessWidget {
  const FeatureProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Featured Projects:",
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
        Container(
          width: context.width * 0.2,
          height: context.height * 0.7,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                "assets/imgs/sugar_tracker.jpeg",
                fit: BoxFit.contain,
              ),
              SizedBox(height: context.height * 0.01),
              const Text("Description: All is best"),
              SizedBox(height: context.height * 0.01),
              ElevatedButton(onPressed: () {}, child: const Text("Github Link"))
            ],
          ),
        ),
      ],
    );
  }
}
