import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/localization/localizations_delegate.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/me/controllers/me_controller.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
import 'package:women_lose_weight_flutter/utils/utils.dart';
import '../../../utils/color.dart';

class MeScreen extends StatelessWidget {
  MeScreen({super.key});
  final MeController _meController = Get.find<MeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.height_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dividerWidget(),
          _spaceWidget(h: AppSizes.height_2_5),
          _commonTitleText("txtWorkout".tr),
          _spaceWidget(h: AppSizes.height_3_3),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.reminder);
            },
            child: Row(
              children: [
                Expanded(
                  child: _commonFieldText(
                    "txtReminder".tr,
                    "",
                    Icons.alarm,
                    Constant.boolValueFalse,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: AppSizes.width_5,
                    left: AppSizes.width_5,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
          _spaceWidget(h: AppSizes.height_3),
          _dividerWidget(),
          _spaceWidget(),
          _commonTitleText("txtGeneralSettings".tr),
          _spaceWidget(h: AppSizes.height_3_3),
          Row(
            children: [
              Expanded(
                child: _commonFieldText(
                  "txtTurnOnWaterTracker".tr,
                  "ic_set_water.webp",
                  null,
                  Constant.boolValueTrue,
                  onTap: () {},
                ),
              ),
              GetBuilder<MeController>(
                id: Constant.idMeTurnOnWaterTrackerSwitch,
                builder: (logic) {
                  return Container(
                    height: AppSizes.height_1,
                    width: AppSizes.height_3,
                    margin: EdgeInsets.only(
                        right: AppSizes.width_5, left: AppSizes.width_5),
                    child: Switch(
                      onChanged: (value) {
                        logic.onTurnOnWaterTrackerToggleSwitchChange(value);
                      },
                      value: logic.isTurnOnWaterTracker,
                      activeColor: AppColor.switchActivate,
                      activeTrackColor: AppColor.switchActivateTrack,
                      inactiveThumbColor: AppColor.switchInactive,
                      inactiveTrackColor: AppColor.switchInactiveTrack,
                    ),
                  );
                },
              ),
            ],
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "txtMyProfile".tr,
            "",
            Icons.add_box_outlined,
            Constant.boolValueFalse,
            onTap: () {
              Get.toNamed(AppRoutes.myProfile); // Navigate to MyProfileScreen
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "txtRestartProgress".tr,
            "",
            Icons.refresh,
            Constant.boolValueFalse,
            onTap: () {
              _dialogResetProgress();
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _spaceWidget(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
            child: Row(
              children: [
                const Icon(
                  Icons.translate,
                  color: AppColor.txtColor999,
                ),
                Expanded(
                  child: GetBuilder<MeController>(
                    id: Constant.idMeChangeLanguage,
                    builder: (logic) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: AppSizes.width_3,
                        ),
                        child: DropdownButton<LanguageModel>(
                          value: logic.languagesChosenValue,
                          isExpanded: true,
                          elevation: 2,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: AppFontSize.size_12_5,
                            fontWeight: FontWeight.w400,
                          ),
                          iconEnabledColor: AppColor.black,
                          iconDisabledColor: AppColor.black,
                          dropdownColor: AppColor.white,
                          underline: Container(
                            color: AppColor.transparent,
                          ),
                          isDense: true,
                          items: languages
                              .map<DropdownMenuItem<LanguageModel>>(
                                (e) => DropdownMenuItem<LanguageModel>(
                              value: e,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      " ${e.language}",
                                      style: TextStyle(
                                        fontSize: AppFontSize.size_12_5,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    e.symbol,
                                    style: TextStyle(
                                      fontSize: AppFontSize.size_12_5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (LanguageModel? value) {
                            logic.onLanguageChange(value);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _spaceWidget(),
          _dividerWidget(),
          _spaceWidget(),
          _commonTitleText("txtSupportUs".tr),

          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "txtFeedback".tr,
            "",
            Icons.edit_outlined,
            Constant.boolValueFalse,
            onTap: () {
              Utils().sendFeedback();
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          _commonFieldText(
            "txtPrivacyPolicy".tr,
            "",
            Icons.visibility_outlined,
            Constant.boolValueFalse,
            onTap: () {
              _meController.loadPrivacyPolicy();
            },
          ),
          _spaceWidget(h: AppSizes.height_3),
          GetBuilder<MeController>(
            id: Constant.idLoginInfo,
            builder: (logic) {
              if (_meController.firebaseAuth.currentUser != null &&
                  _meController.firebaseAuth.currentUser!.photoURL != null) {
                return _commonFieldText(
                  "txtAccountDelete".tr,
                  "",
                  Icons.delete_forever,
                  Constant.boolValueFalse,
                  onTap: () {
                    showDeleteAccountDialog();
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  _commonTitleText(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.width_3),
      child: Text(
        title.toUpperCase(),
        textAlign: TextAlign.left,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _commonFieldText(String title, String asset, IconData? icon, bool isAsset,
      {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSizes.height_3,
              width: AppSizes.height_3,
              child: (isAsset)
                  ? Image.asset(
                Constant.getAssetIcons() + asset,
                color: AppColor.txtColor999,
              )
                  : Icon(
                icon,
                color: AppColor.txtColor999,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.width_4),
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: AppFontSize.size_12_5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dividerWidget() {
    return Container(
      height: AppSizes.height_1_2,
      color: AppColor.grayLight,
      child: null,
    );
  }

  _spaceWidget({double? h}) {
    return SizedBox(
      height: h ?? AppSizes.height_2_5,
    );
  }

  _dialogResetProgress() {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          content: Text(
            "txtAreYouSure".tr,
            style: TextStyle(
              color: AppColor.black,
              fontSize: AppFontSize.size_12,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "txtCancel".tr.toUpperCase(),
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: AppFontSize.size_11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  showLogoutDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSizes.height_3, horizontal: AppSizes.width_6),
              child: Text(
                "txtAreYouSureWantToLogout".tr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  child: Text(
                    "txtCancel".tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppFontSize.size_11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text(
                    "txtLogout".tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppFontSize.size_11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    _meController.signOutFromGoogle();
                  },
                ),
                SizedBox(width: AppSizes.width_3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showDeleteAccountDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: AppSizes.height_3, horizontal: AppSizes.width_6),
              child: Text(
                "txtAreSureWantDeleteYourAccount".tr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  child: Text(
                    "txtCancel".tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppFontSize.size_11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text(
                    "txtDeleteDes".tr.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.primary,
                      fontSize: AppFontSize.size_11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    _meController.deleteAccountFromGoogle();
                  },
                ),
                SizedBox(width: AppSizes.width_3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}