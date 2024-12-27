import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart'; // تأكد من استيراد المسار

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
              SizedBox(height: AppSizes.height_2_5),
              Text(
                "txtInstruction".tr.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_12_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: AppSizes.height_2),
              Text(
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.txtColor666,
                  fontSize: AppFontSize.size_11,
                  fontWeight: FontWeight.w400,
                  height: AppSizes.height_0_2,
                ),
              ),
              SizedBox(height: AppSizes.height_5),
              RichText(
                text: TextSpan(
                  text:
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing ',
                  style: TextStyle(
                    color: AppColor.txtColor666,
                    fontSize: AppFontSize.size_10_5,
                    fontWeight: FontWeight.w400,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'Wikipedia',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        color: AppColor.hyperLinkText,
                      ),
                    ),
                    TextSpan(
                      text:
                      ' Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.height_5),

              // زر BACK في آخر الصفحة
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();// الانتقال إلى صفحة Me
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        side: const BorderSide(
                          color: AppColor.transparent,
                          width: 0.7,
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(AppColor.white), // اللون الخلفي
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)), // الحشو
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