import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:money_management_app/controller/getx/internet_controller.dart';
import 'package:money_management_app/view/settings/view/widget/feedback_tile.dart';
import 'package:money_management_app/view/widgets/toast_msg.dart';

// ignore: must_be_immutable
class FeedbackS extends StatelessWidget {
  static const route = 'feedback';
  FeedbackS({super.key});
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [CustomColors.commonClr, CustomColors.gradientSecond]),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: CustomColors.kwhite,
                  )),
              title: Text(
                'Contact Our Team',
                style: CustomFuction.style(
                    fontWeight: FontWeight.w600,
                    size: 17,
                    color: CustomColors.kwhite),
              ),
            ),
            Form(
              key: globalKey,
              child: Column(
                children: [
                  FeedbackTileWidget(
                      nameController: nameController,
                      screenSize: screenSize,
                      hintText: 'Name'),
                  CustomHeights.commonheight(context),
                  FeedbackTileWidget(
                      nameController: emailController,
                      screenSize: screenSize,
                      hintText: 'Email'),
                  CustomHeights.commonheight(context),
                  FeedbackTileWidget(
                      nameController: subjectController,
                      screenSize: screenSize,
                      hintText: 'Subject'),
                  CustomHeights.commonheight(context),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: contentController,
                      maxLength: null,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Content',
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          messageToast('Content is empty');
                        }
                        return;
                      },
                    ),
                  ),
                ],
              ),
            ),
            CustomHeights.commonheight(context),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      await conformButtonClick(context);
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Conform')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> conformButtonClick(ctx) async {
    final internetController = Get.put(InternetController());
    await internetController.checkInternet();

    if (nameController.text.isEmpty) {
      return;
    }
    if (emailController.text.isEmpty) {
      return;
    }
    if (contentController.text.isEmpty) {
      return;
    }
    if (subjectController.text.isEmpty) {
      return;
    }
    if (internetController.hasInternet.value == false) {
      messageToast('Enable Internet');
    } else {
      await feedbackSent(ctx: ctx);
      clearControllers();
    }
  }

  Future<void> feedbackSent({required BuildContext ctx}) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
      final respose = await http.post(url,
          body: json.encode({
            'service_id': 'service_6vebo7n',
            'template_id': 'template_92ap2mn',
            'user_id': 'JcCWgw-cYY-WPW2tL',
            "template_params": {
              "user_name": nameController.text,
              "user_subject": subjectController.text,
              "user_message": contentController.text,
              "user_email": emailController.text
            }
          }),
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          });
      if (respose.statusCode == 200 || respose.statusCode == 201) {
        messageToast('Feedback is Sented');
      } else {
        messageToast('somthing went wrong');
        log(respose.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    contentController.clear();
  }
}
