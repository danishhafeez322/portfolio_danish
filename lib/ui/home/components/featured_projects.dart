import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FeatureProjects extends StatefulWidget {
  const FeatureProjects({super.key});

  @override
  State<FeatureProjects> createState() => _FeatureProjectsState();
}

class _FeatureProjectsState extends State<FeatureProjects> {
  int hoveredIndex = -1;
  List<Map<String, dynamic>> projects = [];

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  void fetchProjects() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.fetchAndActivate();
      String jsonString = remoteConfig.getString('projects');

      if (jsonString.isEmpty) {
        jsonString = '''
      {
        "projects": [
          {
            "image": "assets/imgs/default.png",
            "title": "Default Project",
            "description": "This is a default project description.",
            "github": "https://github.com/default",
            "videoUrl": "https://www.youtube.com/watch?v=default"
          }
        ]
      }
      ''';
      }

      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      if (jsonData.containsKey('projects') && jsonData['projects'] is List) {
        setState(() {
          projects = List<Map<String, dynamic>>.from(jsonData['projects']);
        });
      } else {
        projects = [];
      }

      log("✅ Projects Loaded Successfully");
    } catch (e) {
      log("❌ Error Fetching Projects: $e");
    }
  }

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
          const SizedBox(height: 20),
          projects.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
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
                    var project = projects[index];

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoveredIndex = index),
                      onExit: (_) => setState(() => hoveredIndex = -1),
                      child: SizedBox(
                        width: double.infinity, // Ensure it has a valid width

                        child: AnimatedScale(
                          scale: hoveredIndex == index ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: _buildProjectCard(
                            project["image"],
                            project["title"],
                            project["description"],
                            project["github"],
                            project["videoUrl"],
                            textTheme,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String image, String title, String description,
      String github, String videoUrl, TextTheme textTheme) {
    return GestureDetector(
      onTap: () => _showProjectPopup(context, title, description, videoUrl),
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
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.flutter_dash,
                          size: 50, color: Colors.blue),
                    ),
                  ),
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
                      onPressed: () => launchUrl(Uri.parse(github)),
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

  void _showProjectPopup(
      BuildContext context, String title, String description, String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(description),
                const SizedBox(height: 10),
                if (videoUrl.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: BuildVideoPlayer(videoUrl),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

class BuildVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const BuildVideoPlayer(this.videoUrl, {Key? key}) : super(key: key);

  @override
  State<BuildVideoPlayer> createState() => _BuildVideoPlayerState();
}

class _BuildVideoPlayerState extends State<BuildVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    String? videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl);
    if (videoId == null) {
      setState(() => _hasError = true);
      return;
    }

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    )..cueVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Text(
          "❌ Error: Invalid YouTube URL.\nPlease check the link.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: YoutubePlayer(controller: _controller),
    );
  }
}
