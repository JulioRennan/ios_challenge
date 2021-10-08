import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ios_challenge/controller/pull_controller.dart';
import 'package:ios_challenge/controller/repository_controller.dart';
import 'package:ios_challenge/model/entitys/repository.dart';
import 'package:ios_challenge/view/pull_view/widgets/card_pull.dart';
import 'package:ios_challenge/view/shared_components/fade_container.dart';

class PullScreen extends StatelessWidget {
  Repository repository;
  //tag com valor única, que controla a transição das imagens entre telas
  String tagHero;
  //váriavel que controla, se o dados está processando a persistência/consulta no banco de dados
  RxBool isLoadingSave = true.obs;
  //variavel que controla se o repositório ja foi salvo ou não
  late bool isSaved = false;

  late PullController pullController;
  PullScreen({Key? key, required this.repository, required this.tagHero})
      : pullController = Get.put(PullController(fullName: repository.fullName)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<RepositoryController>().isSaved(repository).then((value) {
      isSaved = value;
      isLoadingSave.value = false;
    });
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: Get.back,
          ),
          title: Text(
            "Pull Requests",
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Hero(
                          tag: tagHero,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(repository.ownerUrlAvatar),
                            backgroundColor: Colors.transparent,
                            radius: 40,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeContainer(
                          child: Text(
                        repository.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GetBuilder<PullController>(
                    init: PullController(fullName: repository.fullName),
                    builder: (pullController) {
                      if (pullController.isLoadingPull) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (pullController.listPulls.length == 0) {
                        return FadeContainer(
                          color: Colors.black,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/pull.png",
                                width: 100,
                                height: 100,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "There aren’t any open \npull requests.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        );
                      } else {
                        return ListView(
                          children: pullController.listPulls.map((pull) {
                            return CardPull(pull: pull);
                          }).toList(),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: GetBuilder<PullController>(
          init: Get.find<PullController>(),
          builder: (pullController) {
            if (pullController.listPulls.length == 0 ||
                pullController.isLoadingPull) {
              return Container();
            }

            return FadeContainer(child: Obx(() {
              return AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: isLoadingSave.value ? 60 : 80,
                decoration: BoxDecoration(
                    color: isLoadingSave.value ? Colors.grey : Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                height: 60,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: isLoadingSave.value
                      ? null
                      : () async {
                          if (isSaved)
                            deleteFromDataBase();
                          else
                            insertDataBase();
                        },
                  child: isLoadingSave.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                        )
                      : FadeContainer(
                          child: Icon(
                            isSaved ? Icons.delete : Icons.save,
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            }));
          },
        ));
  }

  Future deleteFromDataBase() async {
    isLoadingSave.value = true;
    await Future.delayed(Duration(seconds: 2));
    await Get.find<RepositoryController>().deleteRepositoryFromDb(repository);
    isSaved = false;
    isLoadingSave.value = false;
    Get.rawSnackbar(
        message: "repositório removido com sucesso",
        duration: Duration(seconds: 2));
  }

  Future insertDataBase() async {
    isLoadingSave.value = true;
    await Future.delayed(Duration(seconds: 2));
    await Get.find<RepositoryController>().insertRepoDataBase(repository);
    isSaved = true;
    isLoadingSave.value = false;
    Get.rawSnackbar(
        message: "repositório salvo com sucesso",
        duration: Duration(seconds: 2));
  }
}
