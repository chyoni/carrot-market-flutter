import 'dart:io';

import 'package:carrotmarket/config/view_models/config_view_model.dart';
import 'package:carrotmarket/constants/gaps.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:carrotmarket/features/authentication/views/login_screen.dart';
import 'package:carrotmarket/features/authentication/views/set_geolocation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerWidget {
  static const String routeName = "signUp";
  static const String routeURL = "/";

  const SignupScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onStartBtnTap(BuildContext context) {
    context.pushNamed(SetGeolocationScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/signup_logo.png",
                width: Sizes.size96 + Sizes.size56,
              ),
            ),
            Text(
              "당신 근처의 당근마켓",
              style: TextStyle(
                fontSize: Sizes.size16 + Sizes.size4,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            Gaps.v5,
            Text(
              "중고 거래부터 동네 정보까지,",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              "지금 내 동네를 선택하고 시작해보세요!",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
          horizontal: Sizes.size20,
        ),
        color: ref.watch(configProvider).darkMode
            ? Colors.black
            : Colors.grey.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _onStartBtnTap(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                  vertical: Sizes.size10,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(Sizes.size5),
                ),
                child: const Center(
                  child: Text(
                    "시작하기",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: Platform.isAndroid
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  "이미 계정이 있나요?",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: Sizes.size14,
                  ),
                ),
                Gaps.h10,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
