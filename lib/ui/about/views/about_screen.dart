import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';

import '../../../utils/constant.dart'; // تأكد من استيراد المسار

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: AppSizes.height_1,
              bottom: AppSizes.height_3,
              left: AppSizes.width_5,
              right: AppSizes.width_5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Go back when the icon is tapped
                    },
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), // لون داكن
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        Constant.getAssetIcons() + "ic_back_gray.png",
                        height: AppSizes.height_3,
                        width: AppSizes.height_3,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.width_2), // مساحة بين الأيقونة والعنوان
                  Text(
                    "ABOUT US".tr.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: AppFontSize.size_12_7,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.height_3), // مساحة إضافية لتقليل الارتفاع
              Text(
                "Welcome to our app! We are here to help you achieve your health and fitness goals in an easy and enjoyable way. Our app is specifically designed to meet the needs of individuals looking to improve their lifestyle, whether it’s through weight loss or maintaining a healthy balance.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.txtColor666,
                  fontSize: AppFontSize.size_11,
                  fontWeight: FontWeight.w400,
                  height: AppSizes.height_0_2,
                ),
              ),
              SizedBox(height: AppSizes.height_2),
              Text('Features of the App:\n',
                style: TextStyle(fontSize: AppFontSize.size_12_7,
                    fontWeight: FontWeight.w900),
              ),
              RichText(
                text: TextSpan(
                  text:
                  '1. Weight and Height Calculation: \n The app allows you to enter your weight and height to determine your ideal weight. You will receive personalized tips to help you reach your goal.\n2. Water Intake Tracking:\n We understand that drinking enough water is a crucial part of a healthy lifestyle. Therefore, we have developed a reminder feature to help you stay hydrated throughout the day.\n3. Customized Fitness Activities:\n Enjoy a variety of fitness activities that include easy-to-understand animations. These activities are specifically designed for women, making exercise fun and effective.\n4. Cup Tracking: You can track the number of cups you drink daily, helping you monitor your water intake more effectively.\n ',
                  style: TextStyle(
                      color: AppColor.txtColor666,
                      fontSize: AppFontSize.size_12,
                      fontWeight: FontWeight.w400,
                      height: AppSizes.height_0_2
                  ),
                ),
              ),
              SizedBox(height: AppSizes.height_0_1),
              Text('Our Vision:\n',
                style: TextStyle(fontSize: AppFontSize.size_12_7,
                    fontWeight: FontWeight.w900),
              ),
              RichText(
                text: TextSpan(
                  text: 'We aim to be your perfect companion on your journey to health and fitness. We believe that everyone has the ability to achieve their goals, and with our app, you will be on the right path to do so. Our goal is to provide support and encouragement at every step. We are excited to help you improve your health and life.\n ',
                  style: TextStyle(
                      color: AppColor.txtColor666,
                      fontSize: AppFontSize.size_12,
                      fontWeight: FontWeight.w400,
                      height: AppSizes.height_0_2
                  ),
                ),
              ),
              Center(
                child: Text("Join us today and start!",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: AppFontSize.size_12_7),
                ),
              ),
              SizedBox(height: AppSizes.height_5),
              // زر BACK في آخر الصفحة
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back(); // الانتقال إلى صفحة Me
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        side: const BorderSide(
                          color: AppColor.transparent,
                          width: 0.7,
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(AppColor.white), // اللون الخلفي
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)), // الحشو
                  ),
                  child: Text(
                    'BACK',
                    style: TextStyle(
                      color: AppColor.black, // لون النص
                      fontSize: AppFontSize.size_12_5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.height_5), // لمزيد من المساحة في الأسفل
            ],
          ),
        ),
      ),
    );
  }
}