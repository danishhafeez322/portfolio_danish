import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

import 'custom_outline.dart';

class Myphoto extends StatefulWidget {
  const Myphoto({super.key});

  @override
  State<Myphoto> createState() => _MyphotoState();
}

class _MyphotoState extends State<Myphoto> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late Animation sizeAnimation;
  String? photoUrl;
  @override
  void initState() {
    super.initState();
    fetchPhoto();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    sizeAnimation = Tween(begin: 0.0, end: 0.2).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.75, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    //
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  void fetchPhoto() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.fetchAndActivate();
      final photoUrl = remoteConfig.getString('portfolio_photo');
      if (photoUrl.isNotEmpty) {
        setState(() {
          this.photoUrl = photoUrl;
          // Update the state with the fetched photo URL
        });
      }
    } catch (e) {
      print("Error fetching remote config: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: context.width / 4,
      height: context.width / 4,
      child: AlignTransition(
        alignment: _alignAnimation,
        child: CustomOutline(
          strokeWidth: 5,
          radius: context.width * 0.2,
          padding: const EdgeInsets.all(5),
          width: context.width * sizeAnimation.value,
          height: context.width * sizeAnimation.value,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.secondaryColor,
                theme.secondaryColor.withOpacity(0),
                PortfolioAppTheme.blue,
                theme.primaryColor
              ],
              stops: const [
                0.2,
                0.4,
                0.6,
                1
              ]),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.width * 0.2),
              child: CachedNetworkImage(
                imageUrl: photoUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/imgs/danish_pic.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
