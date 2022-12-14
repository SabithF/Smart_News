import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_news/controllers/SmartNewsController.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_news/consts/colorConst.dart';
import 'package:smart_news/consts/sizeConst.dart';
import 'package:smart_news/consts/uiConst.dart';
import 'package:smart_news/Screens/webView.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_news/widgets/hamburgMenu.dart';
import 'package:smart_news/widgets/cusAppBar.dart';

import '../widgets/newsCard.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // creating controllers
  SmartNewsController smartNewsController = Get.put(SmartNewsController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: hamburgerMenu(smartNewsController),
        appBar: customAppBar('SMART NEWS', context, actions: [
            IconButton(
            onPressed: (){
    smartNewsController.country.value = '';
    smartNewsController.category.value = '';
    smartNewsController.searchNews.value = '';
    smartNewsController.channel.value = '';
    smartNewsController.cName.value = '';
    smartNewsController.getAllNews(reload: true);
    smartNewsController.getBreakingNews(reload: true);
    smartNewsController.update();
    },
        icon: const Icon(Icons.refresh),

    ),
    ]),
    body:SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_8),
                  margin: const EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_18, vertical: Sizes.dimen_16),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.dimen_8)),
                  child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Padding(
                  padding: const EdgeInsets.only(left: Sizes.dimen_16),
                  child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search News"),
                  onChanged: (val) {
                  smartNewsController.searchNews.value = val;
                  smartNewsController.update();
                  },
                    onSubmitted: (value) async {
                    smartNewsController.searchNews.value = value;
                    smartNewsController.getAllNews(
                    searchKey: smartNewsController.searchNews.value);
                    searchController.clear();
                    },
                    ),
                    ),
                    ),
                  //search icon
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: ColorConst.blue,
                      onPressed: () async {
                           smartNewsController.getAllNews(
                          searchKey: smartNewsController.searchNews.value);
                          searchController.clear();
                    },
                    icon: const Icon(Icons.search_sharp)),
                    ),
                    ],
                    ),
                    ),
                    ),
                    GetBuilder<SmartNewsController>(
                    init: SmartNewsController(),
                    builder: (controller) {
                    return CarouselSlider(
                    options: CarouselOptions(
                    height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: controller.breakingNews.map((instance) {
                    return controller.articleNotAvailable.value
                    ? const Center(
                    child: Text("Loading...",
                    style: TextStyle(fontSize: 30)))
                        : controller.breakingNews.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                        : Builder(builder: (BuildContext context) {
                    try {
                    return Banner(
                    location: BannerLocation.topStart,
                    message: 'Top Headlines',
                    child: InkWell(
                    onTap: () => Get.to(() =>
                        WebNews(newsUrl: instance.url)),
                          child: Stack(children: [
                          ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Image.network(
                      instance.urlToImage ?? " ",
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      errorBuilder:
                      (BuildContext context,
                      Object exception,
                      StackTrace? stackTrace) {
                      return Card(
                      shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                      10)),
                      child: const SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Icon(Icons
                          .broken_image_outlined),
                      ),
                      );
                      },
                      ),
                      ),
                      Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                      decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(
                      10),
                    gradient: LinearGradient(
                    colors: [
                    Colors.black12
                        .withOpacity(0),
                    Colors.black
                    ],
                    begin:
                    Alignment.topCenter,
                    end: Alignment
                        .bottomCenter)),
                    child: Container(
                    padding: const EdgeInsets
                        .symmetric(
                    horizontal: 5,
                    vertical: 10),
                    child: Container(
                    margin: const EdgeInsets
                        .symmetric(
                    horizontal: 10),
                    child: Text(
                    instance.title,
                    style: const TextStyle(
                    fontSize: Sizes
                        .dimen_16,
                    color:
                    Colors.white,
                    fontWeight:
                    FontWeight
                        .bold),
                    ))),
                    )),
                    ]),
                    ),
                    );
                    } catch (e) {
                    if (kDebugMode) {
                    print(e);
                    }
                    return Container();
                    }
                    });
                    }).toList(),
                    );
                    }),
                    vertical10,
                    const Divider(),
                    vertical10,
                    smartNewsController.cName.isNotEmpty
                    ? Padding(
                    padding: const EdgeInsets.only(left: Sizes.dimen_18),
                    child: Obx(() {
                    return Text(
                    smartNewsController.cName.value.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                    fontSize: Sizes.dimen_20,
                    fontWeight: FontWeight.bold),
                    );
                    }),
                    )
                        : const SizedBox.shrink(),
                    vertical10,
                    GetBuilder<SmartNewsController>(
                    init: SmartNewsController(),
                    builder: (controller) {
                    return controller.articleNotAvailable.value
                    ? const Center(
                    child: Text('Nothing Found'),
                    )
                        : controller.allNews.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                    controller: controller.scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.allNews.length,
                    itemBuilder: (context, index) {
                    index == controller.allNews.length - 1 &&
                    controller.isLoading.isTrue
                    ? const Center(
                    child: CircularProgressIndicator(),
                    )
                        : const SizedBox();
                    return InkWell(
                    onTap: () => Get.to(() => WebNews(
                    newsUrl: controller.allNews[index].url)),
                    child: NewsCard(
                    imgUrl: controller
                        .allNews[index].urlToImage ??
                    '',
                    desc: controller
                        .allNews[index].description ??
                    '',
                    title: controller.allNews[index].title,
                    content:
                    controller.allNews[index].content ??
                    '',
                    postUrl: controller.allNews[index].url),
                    );
                    });
                    }),
                    ],
                    ),
                    ),
                    );
                  }
                }




