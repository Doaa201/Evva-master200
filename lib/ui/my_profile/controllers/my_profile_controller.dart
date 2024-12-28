import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/database/helper/db_helper.dart';
import 'package:women_lose_weight_flutter/database/table/weight_table.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';
import '../../../utils/utils.dart';

class MyProfileController extends GetxController {
  bool isKgCm = Constant.boolValueTrue;

  int heightUnitValue = Constant.valueZero;
  int weightUnitValue = Constant.valueZero;
  int targetWeightUnitValue = Constant.valueZero; // Ensure this is initialized

  List<String> heightUnitList = ["txtCM".tr];
  List<String> weightUnitList = ["txtKG".tr];
  List<String> targetWeightUnitList = ["txtKG".tr]; // Ensure this contains the correct unit

  String? heightInCM;
  String? weightInKG;
  String? targetWeightInKG;

  int heightCM = Constant.heightCm;
  int weightKG = Constant.weightKg;
  int targetWeightKG = Constant.weightKg;

  FixedExtentScrollController? fixedExtentScrollControllerCm;
  FixedExtentScrollController? fixedExtentScrollControllerWeight;
  FixedExtentScrollController? fixedExtentScrollControllerTargetWeight;

  List<WeightTable>? weightDataList;

  @override
  void onInit() {
    fixedExtentScrollControllerCm = FixedExtentScrollController(initialItem: 80);
    fixedExtentScrollControllerWeight = FixedExtentScrollController(initialItem: 40);
    fixedExtentScrollControllerTargetWeight = FixedExtentScrollController(initialItem: 40); // Initialize for target weight
    _fillData();
    super.onInit();
  }

  void _fillData() {
    isKgCm = (Preference.shared.getString(Preference.currentWeightUnit) == Constant.weightUnitKg) &&
        (Preference.shared.getString(Preference.currentHeightUnit) == Constant.heightUnitCm);

    if (isKgCm) {
      heightInCM = "${Preference.shared.getInt(Preference.currentHeightInCm) ?? Constant.heightCm} CM";
      weightInKG = "${Preference.shared.getInt(Preference.currentWeightInKg) ?? Constant.weightKg} KG";
      targetWeightInKG = "${Preference.shared.getInt(Preference.targetWeightInKg) ?? Constant.weightKg} KG";
    }

    update([Constant.idKgCmLbsFtSelection]);
  }

  void onSelectKgCm() {
    isKgCm = Constant.boolValueTrue;
    Preference.shared.setString(Preference.currentWeightUnit, Constant.weightUnitKg);
    Preference.shared.setString(Preference.currentHeightUnit, Constant.heightUnitCm);
    _fillData();
    update([Constant.idKgCmLbsFtSelection]);
  }

  /// Height Methods
  void getHeightPreferenceData() {
    heightCM = Preference.shared.getInt(Preference.currentHeightInCm) ?? Constant.heightCm;

    Future.delayed(const Duration(milliseconds: 50), () async {
      await fixedExtentScrollControllerCm!.animateToItem(heightCM - 20,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void onChangeCMValue(int value) {
    heightCM = value;
  }

  void onChangeHeightUnit(int changeUnit) {
    heightUnitValue = changeUnit;
    update([Constant.idChooseHeightPickerDialog]);
  }

  void onHeightSaveButtonClick() {
    Preference.shared.setInt(Preference.currentHeightInCm, heightCM);
    Get.back();
    _fillData();
  }

  /// Weight Methods
  void getWeightPreferenceData() {
    weightKG = Preference.shared.getInt(Preference.currentWeightInKg) ?? Constant.weightKg;

    Future.delayed(const Duration(milliseconds: 50), () {
      fixedExtentScrollControllerWeight!.animateToItem(weightKG - 20,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void onChangeKgValue(int value) {
    weightKG = value;
  }

  void onChangeWeightUnit(int changeUnit) {
    weightUnitValue = changeUnit;
    update([Constant.idChooseWeightPickerDialog]);
  }

  void onWeightSaveButtonClick() async {
    Preference.shared.setInt(Preference.currentWeightInKg, weightKG);
    Preference.shared.setString(Preference.currentWeightUnit, Constant.weightUnitKg);
    Get.back();
    _fillData();
    await _addWeightToDatabase();
  }

  Future<void> _addWeightToDatabase() async {
    weightDataList = await DBHelper.dbHelper.getWeightData();
    if (weightDataList!.isNotEmpty) {
      var res = weightDataList!.where((element) =>
      element.weightId == DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0, 0)
          .millisecondsSinceEpoch);
      if (res.isNotEmpty) {
        updateWeightDatabase();
      } else {
        insertWeightToDatabase();
      }
    } else {
      insertWeightToDatabase();
    }
  }

  void updateWeightDatabase() {
    DBHelper.dbHelper.updateWeight(
      weightKG: weightKG.toString(),
      id: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0, 0)
          .millisecondsSinceEpoch,
    );
  }

  void insertWeightToDatabase() {
    DBHelper.dbHelper.insertWeightData(WeightTable(
      weightId: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0, 0, 0)
          .millisecondsSinceEpoch,
      weightKg: weightKG.toString(),
      weightDate: Utils.getDate(DateTime.now()).toString(),
      currentTimeStamp: DateTime.now().toString(),
      status: Constant.statusSyncPending,
    ));
  }

  /// Target Weight Methods
  void getTargetWeightPreferenceData() {
    targetWeightKG = Preference.shared.getInt(Preference.targetWeightInKg) ?? Constant.weightKg;

    Future.delayed(const Duration(milliseconds: 50), () {
      fixedExtentScrollControllerTargetWeight!.animateToItem(targetWeightKG - 20,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  void onChangeKgTargetValue(int value) {
    targetWeightKG = value;
  }

  void onChangeTargetWeightUnit(int value) {
    targetWeightUnitValue = value; // Add this line
    update([Constant.idChooseWeightPickerDialog]); // Update the UI
  }

  void onTargetWeightSaveButtonClick() {
    Preference.shared.setInt(Preference.targetWeightInKg, targetWeightKG);
    Preference.shared.setString(Preference.targetWeightUnit, Constant.weightUnitKg);
    Get.back();
    _fillData();
  }
}