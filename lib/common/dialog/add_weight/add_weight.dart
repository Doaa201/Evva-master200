import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:women_lose_weight_flutter/database/helper/db_helper.dart';
import 'package:women_lose_weight_flutter/database/table/weight_table.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';
import 'package:women_lose_weight_flutter/utils/utils.dart';
import '../../../utils/constant.dart';
import '../../../utils/debug.dart';

class AddWeightDialog extends StatefulWidget {
  const AddWeightDialog({super.key});

  @override
  AddWeightDialogState createState() => AddWeightDialogState();
}

class AddWeightDialogState extends State<AddWeightDialog> {
  final DatePickerController _datePickerController = DatePickerController();
  TextEditingController weightController = TextEditingController();

  DateTime _selectedDate = Utils.getDate(DateTime.now());
  bool? isKg;
  bool? isLb;

  int? daysCount;
  DateTime? startDate;
  DateTime? endDate;
  List<WeightTable> weightDataList = [];

  @override
  void initState() {
    getCurrentWeightUnit();
    Future.delayed(const Duration(milliseconds: 100), () {
      _datePickerController.animateToSelection();
    });

    startDate = DateTime(
        DateTime
            .now()
            .year - 1, DateTime
        .now()
        .month, DateTime
        .now()
        .day);
    endDate = DateTime.now().add(const Duration(days: 4));
    daysCount = endDate!.difference(startDate!).inDays;

    getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.transparent,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Wrap(
            children: [

            ],
          ),
        ),
      ),
    );
  }

  getDataFromDatabase() async {
    weightDataList = await DBHelper.dbHelper.getWeightData();

    if (weightDataList.isNotEmpty) {
      for (var element in weightDataList) {
        if (element.weightDate == _selectedDate.toString()) {
          if (isKg!) {
            weightController.text = element.weightKg!;
          } else {
            weightController.text = element.weightLb!;
          }
        }
      }
    }
  }

  onSave() {
    if (weightDataList.isNotEmpty) {
      Debug.printLog("not empty");
      var res = weightDataList.where((element) =>
      element.weightId ==
          DateTime(
              _selectedDate.year,
              _selectedDate.month,
              _selectedDate.day,
              0,
              0,
              0,
              0,
              0)
              .millisecondsSinceEpoch);
      Debug.printLog("result ==> $res");
      if (res.isNotEmpty) {
        updateWeightDatabase();
      } else {
        insertWeightToDatabase();
      }
    } else {
      insertWeightToDatabase();
    }
    if (_selectedDate.toString() == Utils.getDate(DateTime.now()).toString()) {
      setCurrentWeightPref();
    }
    Get.back();
  }

  void updateWeightDatabase() {
    DBHelper.dbHelper.updateWeight(
      weightKG: isKg! && !isLb!
          ? double.parse(weightController.text).round().toString()
          : Utils.convertWeightLbsToKg(double.parse(weightController.text))
          .toString(),
      weightLBS: !isKg! && isLb!
          ? double.parse(weightController.text).round().toString()
          : Utils.convertWeightKgToLbs(double.parse(weightController.text))
          .toString(),
      id: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          0,
          0,
          0,
          0,
          0)
          .millisecondsSinceEpoch,
    );
  }

  void insertWeightToDatabase() {
    DBHelper.dbHelper.insertWeightData(WeightTable(
      weightId: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          0,
          0,
          0,
          0,
          0)
          .millisecondsSinceEpoch,
      weightKg: isKg! && !isLb!
          ? double.parse(weightController.text).round().toString()
          : Utils.convertWeightLbsToKg(double.parse(weightController.text))
          .toString(),
      weightLb: !isKg! && isLb!
          ? double.parse(weightController.text).round().toString()
          : Utils.convertWeightKgToLbs(double.parse(weightController.text))
          .toString(),
      weightDate: _selectedDate.toString(),
      currentTimeStamp: DateTime.now().toString(),
      status: Constant.statusSyncPending,
    ));
  }

  void setCurrentWeightPref() {
    if (isKg! && !isLb!) {
      Preference.shared.setInt(Preference.currentWeightInKg,
          double.parse(weightController.text).round());
      Preference.shared.setInt(Preference.currentWeightInLbs,
          Utils.convertWeightKgToLbs(double.parse(weightController.text)));
    } else {
      Preference.shared.setInt(Preference.currentWeightInKg,
          Utils.convertWeightLbsToKg(double.parse(weightController.text)));
      Preference.shared.setInt(Preference.currentWeightInLbs,
          double.parse(weightController.text).round());
    }
  }

  getCurrentWeightUnit() {
    var unit = Preference.shared.getString(Preference.currentWeightUnit) ??
        Constant.weightUnitKg;
    if (unit == Constant.weightUnitKg) {
      isKg = true;
      isLb = false;
    } else {
      isKg = false;
      isLb = true;
    }
  }
}
