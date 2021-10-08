import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ios_challenge/model/entitys/repository.dart';
import 'package:ios_challenge/view/pull_view/pull_screen.dart';
import 'package:ios_challenge/view/shared_components/custom_image_loader.dart';

class CardRepository extends StatelessWidget {
  Repository repository;
  CardRepository({Key? key, required this.repository}) : super(key: key);
  //tag usada para a transição da imagem do avatar entre telas
  String tagHero = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 120,
            child: InkWell(
              onTap: () {
                Get.to(
                    () => PullScreen(
                          repository: repository,
                          tagHero: tagHero,
                        ),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 600));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: tagHero,
                          child: CustomImageLoader(
                            width: 50,
                            height: 50,
                            colorLoader: Colors.black,
                            imgPath: repository.ownerUrlAvatar,
                          ),
                        ),
                        Container(
                            width: 80,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Text(
                              repository.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      width: 1,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              repository.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              repository.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(repository.getCountStartFormated)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: colorCircleLanguage,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                repository.language,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  Color get colorCircleLanguage {
    switch (repository.language) {
      case "Python":
        return Colors.blue;
      case "C++":
        return Colors.pink;
      case "Swift":
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
