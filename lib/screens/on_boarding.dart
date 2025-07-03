import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do/screens/login_screen.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/app_icons.dart';
import 'package:to_do/utils/constants/app_images.dart';
import 'package:to_do/utils/constants/store_keys.dart';
import 'package:to_do/utils/theme/app_text_style.dart';
import 'package:to_do/widgets/cutom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SvgPicture.asset(AppIcons.logo),
                  SizedBox(height: 20),
                  Image.asset(AppImages.onboarding),
                  SizedBox(height: 40),
                  Text(
                    "Ishlaringiz va hayotingizni tartibga soling.",
                    style: AppTextStyle.size25Weight600,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              CustomButton(
                text: "Continue",
                onTap: ()async {
                  await SharedPreferenceStorage.setBool(key: StoreKeys.isFirsTime, value: true);
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
