import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

class FeatureProjects extends StatefulWidget {
  const FeatureProjects({super.key});

  @override
  State<FeatureProjects> createState() => _FeatureProjectsState();
}

class _FeatureProjectsState extends State<FeatureProjects> {
  int hoveredIndex = -1;

  final projects = [
    {
      'image': 'assets/imgs/fitness_challenge.png',
      'title': 'Fitness Challenge App',
      'github': 'https://github.com/yourprofile/fitness-challenge'
    },
    {
      'image': 'assets/imgs/snaptik_video_downloader.jpg',
      'title': 'SnapTik Video Downloader',
      'github': 'https://github.com/yourprofile/snaptik-downloader'
    },
    {
      'image': 'assets/imgs/fitness_challenge.png',
      'title': 'Another Cool Project',
      'github': 'https://github.com/yourprofile/another-project'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool isMobile = context.width < 600;

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
            itemCount: projects.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 1.2 : 1.0,
            ),
            itemBuilder: (context, index) {
              final project = projects[index];
              return MouseRegion(
                onEnter: (_) => setState(() => hoveredIndex = index),
                onExit: (_) => setState(() => hoveredIndex = -1),
                child: AnimatedScale(
                  scale: hoveredIndex == index ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: _buildProjectCard(
                    project['image']!,
                    project['title']!,
                    project['github']!,
                    textTheme,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
      String image, String title, String github, TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        debugPrint('Opening: $github');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.code, size: 18),
                      label: const Text("View on GitHub"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: PortfolioAppTheme.nameColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
