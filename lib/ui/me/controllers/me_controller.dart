import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_lose_weight_flutter/database/helper/firestore_helper.dart';
import 'package:women_lose_weight_flutter/localization/localizations_delegate.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/home/controllers/home_controller.dart';
import 'package:women_lose_weight_flutter/ui/me/views/me_screen.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/debug.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../database/helper/db_helper.dart';
import '../../../utils/utils.dart';
import '../../plan/controllers/plan_controller.dart';

class MeController extends GetxController {
  bool isTurnOnWaterTracker = Constant.boolValueFalse;

  bool isMute = Constant.boolValueFalse;
  bool isVoiceGuide = Constant.boolValueFalse;
  bool isCoachTips = Constant.boolValueFalse;


  LanguageModel? languagesChosenValue;
  List<LanguageModel>? languageList;
  String? prefLanguageCode;

  String? lastSyncDate;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  final HomeController _homeController = Get.find<HomeController>();
  final PlanController _planController = Get.find<PlanController>();

  @override
  void onInit() {
    _initialGetPreferenceData();
    getLanguageData();
    getLastSyncDate();
    super.onInit();
  }



  onTurnOnWaterTrackerToggleSwitchChange(bool value) {
    isTurnOnWaterTracker = value;

    if (isTurnOnWaterTracker) {
      Utils.setWaterReminderNotifications();
    } else {
      Utils.cancelWaterReminderNotifications();
    }

    Preference.shared
        .setBool(Preference.turnOnWaterTracker, isTurnOnWaterTracker);

    update([Constant.idMeTurnOnWaterTrackerSwitch]);
  }

  _initialGetPreferenceData() {
    isTurnOnWaterTracker =
        Preference.shared.getBool(Preference.turnOnWaterTracker) ??
            Constant.boolValueTrue;

    isMute = Preference.shared.getBool(Preference.soundOptionMute) ??
        Constant.boolValueFalse;
    isVoiceGuide =
        Preference.shared.getBool(Preference.soundOptionVoiceGuide) ??
            Constant.boolValueTrue;
    isCoachTips = Preference.shared.getBool(Preference.soundOptionCoachTips) ??
        Constant.boolValueTrue;

    _homeController.isPurchase();
  }

  onChangeValueOfMute(bool value) {
    isMute = !isMute;
    if (isMute) {
      isVoiceGuide = Constant.boolValueFalse;
      isCoachTips = Constant.boolValueFalse;
    }

    Preference.shared.setBool(Preference.soundOptionMute, isMute);
    Preference.shared.setBool(Preference.soundOptionVoiceGuide, isVoiceGuide);
    Preference.shared.setBool(Preference.soundOptionCoachTips, isCoachTips);

    update([
      Constant.idSoundOptionMute,
      Constant.idSoundOptionVoiceGuide,
      Constant.idSoundOptionCoachTips
    ]);
  }

  onChangeValueOfVoiceGuide(bool value) {
    isVoiceGuide = !isVoiceGuide;
    if (isMute) {
      isMute = Constant.boolValueFalse;
    }

    Preference.shared.setBool(Preference.soundOptionMute, isMute);
    Preference.shared.setBool(Preference.soundOptionVoiceGuide, isVoiceGuide);

    update([Constant.idSoundOptionMute, Constant.idSoundOptionVoiceGuide]);
  }

  onChangeValueOfCoachTips(bool value) {
    isCoachTips = !isCoachTips;
    if (isMute) {
      isMute = Constant.boolValueFalse;
    }

    Preference.shared.setBool(Preference.soundOptionMute, isMute);
    Preference.shared.setBool(Preference.soundOptionCoachTips, isCoachTips);

    update([Constant.idSoundOptionMute, Constant.idSoundOptionCoachTips]);
  }

  share() async {
    await Share.share(
      "txtShareDesc".tr + Constant.shareLink,
      subject: "txtAppName".tr,
    );
  }

  Future<void> loadPrivacyPolicy() async {
    var url = Uri.parse(Constant.getPrivacyPolicyURL());
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    } else {
      throw "Cannot load the page";
    }
  }

  getLanguageData() {
    prefLanguageCode =
        Preference.shared.getString(Preference.selectedLanguage) ?? 'en';
    languagesChosenValue = languages
        .where((element) => (element.languageCode == prefLanguageCode))
        .toList()[0];
    update([Constant.idMeChangeLanguage]);
  }

  onLanguageChange(LanguageModel? value) {
    if (value != null) {
      languagesChosenValue = value;
      Preference.shared
          .setString(Preference.selectedLanguage, value.languageCode);
      Preference.shared
          .setString(Preference.selectedCountryCode, value.countryCode);
      Get.updateLocale(Locale(value.languageCode, value.countryCode));
    }
    update([Constant.idMeChangeLanguage]);
  }

  Future<String?> signInWithGoogle() async {
    try {
      await _googleSignIn.signIn().then((value) async {
        if (value != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
          await value.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await firebaseAuth.signInWithCredential(credential).then((value) {
            Debug.printLog("firebaseAuth -->> $value");
            Preference.shared
                .setString(Preference.firebaseAuthUid, value.user!.uid);
            FirestoreHelper().addUser(value.user);
            // Utils.showToast(Get.context!, "txtLoginSuccess".tr);
          });
        } else {
          _homeController.onChangeIsShowLoading(Constant.boolValueFalse);
        }
      });

      update([Constant.idLoginInfo]);
    } on FirebaseAuthException catch (e) {
      _homeController.onChangeIsShowLoading(Constant.boolValueFalse);
      Debug.printLog("FirebaseAuthException -->> ${e.message}");
      rethrow;
    }
    return null;
  }

  getLastSyncDate() {
    lastSyncDate = Preference.shared.getString(Preference.lastSyncDate) ?? "";
    update([Constant.idLoginInfo]);
  }

  Future<void> signOutFromGoogle() async {
    await Preference.shared.firebaseLogout();
    await _googleSignIn.signOut();
    await firebaseAuth.signOut();
    Utils.showToast(Get.context!, "txtLogoutSuccess".tr);
    update([Constant.idLoginInfo]);
  }

  onSignInButtonClick() async {
    if (await Utils.isInternetConnectivity()) {
      if (Utils.getFirebaseUid() == null) {
        _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
        signInWithGoogle();
      } else {
        MeScreen().showLogoutDialog();
      }
    } else {
      Utils.showToast(Get.context!, "txtInternetConnection".tr);
    }
  }

  onSyncButtonClick() async {
    if (await Utils.isInternetConnectivity()) {
      _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
      if (Utils.getFirebaseUid() == null) {
        signInWithGoogle();
      } else {
        FirestoreHelper().onSyncButtonClick();
      }
    } else {
      Utils.showToast(Get.context!, "txtInternetConnection".tr);
    }
  }

  onPremiumBtnClick() {
    Get.toNamed(AppRoutes.accessAllFeature)!.then((value) {
      if (value != null && value == true) {
        _homeController.isShowPremiumBtn = false;
        update([Constant.idMeGoPremiumBtn]);
      }
    });
  }

  Future<void> deleteAccountFromGoogle() async {
    _homeController.onChangeIsShowLoading(Constant.boolValueTrue);
    FirestoreHelper().deleteUserAccountPermanently().then((value) async {
      await Preference.shared.firebaseLogout();
      if (firebaseAuth.currentUser != null) firebaseAuth.currentUser!.delete();
      await _googleSignIn.signOut();
      await firebaseAuth.signOut();
      await DBHelper.dbHelper
          .restartProgress()
          .then((value) => _planController.refreshData());
      _homeController.onChangeIsShowLoading(Constant.boolValueFalse);
      Utils.showToast(Get.context!, "txtDeleteAccountSuccessfully".tr);
      update([Constant.idLoginInfo]);
    });
  }
}
