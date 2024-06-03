import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.notesView);
    });
  }

  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: AppAssets.appLogo,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primaryColor.withOpacity(0.7)),
            child: Image.asset(AppAssets.appLogo,
                height: MediaQuery.of(context).size.height * 0.2),
          ),
        ),
      ),
    );
  }
}
