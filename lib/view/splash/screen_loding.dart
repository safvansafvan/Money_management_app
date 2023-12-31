import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/controller/getx/category_db_controller.dart';
import 'package:money_management_app/controller/getx/transaction_db_controller.dart';
import 'package:money_management_app/view/home/home_screen.dart';

class ScrennLoadingScreen extends StatefulWidget {
  const ScrennLoadingScreen({super.key});

  @override
  State<ScrennLoadingScreen> createState() => _ScrennLoadingScreenState();
}

class _ScrennLoadingScreenState extends State<ScrennLoadingScreen> {
  @override
  void initState() {
    super.initState();
    navigation(context);
    Get.put(CategoryDbController()).reloadUi();
    Get.put(TransactionDbController()).refreshTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [CustomColors.commonClr, CustomColors.gradientSecond])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo/applogo.png',
                        height: 150, width: 150),
                    Text(
                      'W A L L E T  A P P',
                      style: CustomFuction.style(
                        fontWeight: FontWeight.bold,
                        size: 15,
                        color: CustomColors.kwhite,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Lottie.asset('assets/animation/app_loading.json',
                      height: 60, width: 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigation(context) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomeScreen()));
  }
}
