import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ios_challenge/controller/repository_controller.dart';
import 'package:ios_challenge/view/repository_view/widgets/body_repository.dart';
import 'package:ios_challenge/view/repository_view/widgets/segmented_button.dart';

class RepositoryScreen extends StatelessWidget {
  String textSearch;
  RepositoryScreen({Key? key, required this.textSearch}) : super(key: key);
  RxInt groupValue = 0.obs;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: "logo",
            child: Image.asset(
              "images/github.png",
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Chave de pesquisa: 'Swift'",
        ),
      ),
      backgroundColor: Colors.white24,
      body: GetBuilder<RepositoryController>(
          init: RepositoryController(textSearch: textSearch),
          builder: (repositoryController) {
            return Obx(() {
              return Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  height: 60,
                  child: CupertinoSegmentedControl(
                      pressedColor: Colors.grey,
                      groupValue: groupValue.value,
                      selectedColor: Colors.black,
                      unselectedColor: Colors.white,
                      borderColor: Colors.transparent,
                      children: {
                        0: SegmentedButton(
                          title: "repositórios online",
                          icon: Icon(Icons.cloud),
                        ),
                        1: SegmentedButton(
                          icon: Icon(Icons.cloud_off_outlined),
                          title: "repositórios offline",
                        )
                      },
                      onValueChanged: (int index) {
                        if (groupValue.value != index) {
                          if (index == 0) {
                            repositoryController.startOnlineMode();
                          } else {
                            repositoryController.startOfflineMode();
                          }

                          groupValue.value = index;
                          pageController.animateToPage(index,
                              duration: Duration(milliseconds: 600),
                              curve: Curves.decelerate);
                        }
                      }),
                ),
                //Uso da page view, foi para dar o efeito de Slide entre os bodys
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      BodyReposytory(
                        repositoryController: repositoryController,
                        isOnline: true,
                      ),
                      BodyReposytory(
                        repositoryController: repositoryController,
                        isOnline: false,
                      )
                    ],
                  ),
                )
              ]);
            });
          }),
    );
  }
}
