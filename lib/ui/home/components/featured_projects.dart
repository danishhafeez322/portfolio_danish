import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';

import '../../../utils/app_theme.dart';

class FeatureProjects extends StatelessWidget {
  const FeatureProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: context.height * 0.7,
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: GridView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, __) => Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                width: context.width * 0.3,
                "assets/imgs/fitness_challenge.png",
                fit: BoxFit.cover,
              ),
              SizedBox(height: context.height * 0.005),
              Text("Fitness Challenge App", style: textTheme.titleSmall),
              SizedBox(height: context.height * 0.005),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: PortfolioAppTheme.nameColor),
                onPressed: () {},
                child: const Text("Github Link"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
