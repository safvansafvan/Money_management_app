import 'package:flutter/material.dart';
import 'package:money_management_app/controller/core/constant.dart';
import 'package:money_management_app/view/category/widget/expence.dart';
import 'package:money_management_app/view/category/widget/income.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: CustomColors.commonClr,
          leading: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                Icons.menu,
                color: CustomColors.kwhite,
              )),
          title: Text(
            'STATICS',
            style: CustomFuction.style(
                fontWeight: FontWeight.w600,
                size: 17,
                color: CustomColors.kwhite),
          ),
          centerTitle: true,
        ),
        TabBar(
          controller: controller,
          labelStyle:
              CustomFuction.style(fontWeight: FontWeight.bold, size: 16),
          tabs: [
            Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expence',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
              controller: controller,
              children: [IncomeTabBar(), ExpenceTabBar()]),
        )
      ],
    );
  }
}
