import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ios_challenge/view/repository_view/repository_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController textEditingController =
      TextEditingController(text: "Swift");

  RxBool loop = false.obs;

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 2), (_) {
      loop.value = !loop.value;
    });
    return Scaffold(body: Obx(() {
      return AnimatedContainer(
        height: double.infinity,
        width: double.infinity,
        duration: Duration(seconds: 2),
        color: loop.value ? Colors.black54 : Colors.black12,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "logo",
                child: Image.asset(
                  "images/github.png",
                  width: 100,
                  height: 100,
                  color: !loop.value ? Colors.white : Colors.black54,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                margin: EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(!loop.value ? 15 : 10)),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onEditingComplete: () {
                          if (textEditingController.text.isEmpty) {
                            Get.rawSnackbar(
                                message:
                                    "o campo de pesquisa não pode ser vazio");
                          } else {
                            openRepostitoryScreen();
                          }
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        color: Colors.black,
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            openRepostitoryScreen();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  openRepostitoryScreen() {
    Get.to(
        () => RepositoryScreen(
              textSearch: textEditingController.text,
            ),
        duration: Duration(milliseconds: 500),
        transition: Transition.topLevel);
  }
}
