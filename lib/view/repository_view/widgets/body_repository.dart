import 'package:ios_challenge/controller/repository_controller.dart';
import 'package:flutter/material.dart';
import 'package:ios_challenge/model/entitys/repository.dart';
import 'card_repository.dart';

class BodyReposytory extends StatelessWidget {
  RepositoryController repositoryController;
  bool isOnline;
  late bool loading;
  late bool hasMore;

  late List<Repository> listRepositoryView = [];
  BodyReposytory(
      {Key? key, required this.repositoryController, required this.isOnline})
      : super(key: key) {
    /*
      define se os dados a serem usados no body,
      devem ser consumidos da API, ou do banco de dados.
      */
    if (isOnline) {
      loading = repositoryController.isLoadingRepoOn;
      hasMore = repositoryController.hasMoreOn;
      listRepositoryView = repositoryController.listRepositoryOn;
    } else {
      loading = repositoryController.isLoadingRepoOff;
      hasMore = repositoryController.hasMoreOff;
      listRepositoryView = repositoryController.listRepositoryOff;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else if (listRepositoryView.length == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Nenhum repositorio encontrado",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      return ListView.builder(
        itemCount: listRepositoryView.length + 1,
        itemBuilder: (_, index) {
          if (index == listRepositoryView.length) {
            if (isOnline) {
              repositoryController.nexPageOn();
            } else {
              repositoryController.nextPageOff();
            }
            if (hasMore) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              );
            } else {
              return Container();
            }
          } else {
            if (isOnline) {
              return CardRepository(repository: listRepositoryView[index]);
            } else {
              return Container(
                child: Stack(
                  children: [
                    CardRepository(
                      repository: listRepositoryView[index],
                    ),
                    Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.highlight_remove_outlined,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await repositoryController.deleteRepositoryFromDb(
                                listRepositoryView[index]);
                            listRepositoryView.removeAt(index);
                            repositoryController.update();
                          },
                        ))
                  ],
                ),
              );
            }
          }
        },
      );
    }
  }
}
