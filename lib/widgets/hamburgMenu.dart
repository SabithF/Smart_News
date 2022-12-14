import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_news/controllers/SmartNewsController.dart';
import 'package:smart_news/consts/colorConst.dart';
import 'package:smart_news/consts/sizeConst.dart';
import 'package:smart_news/consts/uiConst.dart';
import 'package:smart_news/utils/otherUtils.dart';
import 'dropDown.dart';

Drawer hamburgerMenu(SmartNewsController smartNewsController) {
  return Drawer(
    backgroundColor: ColorConst.lightGrey,
      child: ListView(
      children: <Widget>[
      GetBuilder<SmartNewsController>(
      builder: (controller) {
            return Container(
      decoration: const BoxDecoration(
          color: ColorConst.burgundy,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Sizes.dimen_10),
            bottomRight: Radius.circular(Sizes.dimen_10),
          )),
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_18, vertical: Sizes.dimen_18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.cName.isNotEmpty
              ? Text(
            "Country: ${controller.cName.value.toUpperCase()}",
            style: const TextStyle(
                color: ColorConst.white, fontSize: Sizes.dimen_18),
          )
              : const SizedBox.shrink(),
          vertical15,
          controller.category.isNotEmpty
              ? Text(
            "Category: ${controller.category.value.capitalizeFirst}",
            style: const TextStyle(
                color: ColorConst.white, fontSize: Sizes.dimen_18),
          )
              : const SizedBox.shrink(),
          vertical15,
          controller.channel.isNotEmpty
              ? Text(
            "Category: ${controller.channel.value.capitalizeFirst}",
            style: const TextStyle(
                color: ColorConst.white, fontSize: Sizes.dimen_18),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  },
  init: SmartNewsController(),
  ),


      //Country selection

        ExpansionTile(
          collapsedTextColor: ColorConst.burgundy,
          collapsedIconColor: ColorConst.burgundy,
          iconColor: ColorConst.burgundy,
          textColor: ColorConst.burgundy,
          title: const Text("Select Country"),
          children: <Widget>[
            for (int i = 0; i < listOfCountry.length; i++)
              dropDown(
                onCalled: () {
                  smartNewsController.country.value = listOfCountry[i]['code']!;
                  smartNewsController.cName.value =
                      listOfCountry[i]['name']!.toUpperCase();
                  smartNewsController.getAllNews();
                  smartNewsController.getBreakingNews();
                },
                name: listOfCountry[i]['name']!.toUpperCase(),
              ),
          ],
        ),

        /// For Selecting the Category
        ExpansionTile(
          collapsedTextColor: ColorConst.burgundy,
          collapsedIconColor: ColorConst.burgundy,
          iconColor: ColorConst.burgundy,
          textColor: ColorConst.burgundy,
          title: const Text("Select Category"),
          children: [
            for (int i = 0; i < listOfCategory.length; i++)
              dropDown(
                  onCalled: () {
                    smartNewsController.category.value = listOfCategory[i]['code']!;
                    smartNewsController.getAllNews();
                  },
                  name: listOfCategory[i]['name']!.toUpperCase())
          ],
        ),

        /// For Selecting the Channel
        ExpansionTile(
          collapsedTextColor: ColorConst.burgundy,
          collapsedIconColor: ColorConst.burgundy,
          iconColor: ColorConst.burgundy,
          textColor: ColorConst.burgundy,
          title: const Text("Select Channel"),
          children: [
            for (int i = 0; i < listOfNewsChannel.length; i++)
              dropDown(
                onCalled: () {
                  smartNewsController.channel.value = listOfNewsChannel[i]['code']!;
                  smartNewsController.getAllNews(
                      channel: listOfNewsChannel[i]['code']);
                  smartNewsController.cName.value = '';
                  smartNewsController.category.value = '';
                  smartNewsController.update();
                },
                name: listOfNewsChannel[i]['name']!.toUpperCase(),
              ),
          ],
        ),
        const Divider(),
        ListTile(
            trailing: const Icon(
              Icons.done_sharp,
              size: Sizes.dimen_28,
              color: Colors.black,
            ),
            title: const Text(
              "Done",
              style: TextStyle(fontSize: Sizes.dimen_16, color: Colors.black),
            ),
            onTap: () => Get.back()),
      ],
      ),
  );
}
