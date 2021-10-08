import 'package:get/state_manager.dart';
import 'package:ios_challenge/model/API/git_hub_api.dart';
import 'package:ios_challenge/model/dao/dao.dart';
import 'package:ios_challenge/model/entitys/repository.dart';
import 'package:sqflite/sqlite_api.dart';

class RepositoryController extends GetxController {
  String textSearch;

  late List<Repository> listRepositoryOn = [];
  late List<Repository> listRepositoryOff = [];

  GitHubApi gitHubApi = GitHubApi();
  Dao dao = Dao();

  bool isLoadingRepoOn = true;
  bool isLoadingRepoOff = true;

  int limitDb = 20;
  int offsetDb = 0;

  bool hasMoreOff = true;
  bool hasMoreOn = true;

  int page = 1;
  RepositoryController({required this.textSearch});

  //metodo chamado assim que o controller é instanciado na memória
  @override
  void onInit() {
    super.onInit();
    getRepoList().then((_) async {
      dao.init().then((_) {
        setLoadingOn(false);
      });
    });
  }

  startOnlineMode() async {
    hasMoreOn = true;
    listRepositoryOn = [];
    page = 1;
    setLoadingOn(true);
    await getRepoList();
    setLoadingOn(false);
  }

  startOfflineMode() async {
    hasMoreOff = true;
    listRepositoryOff = [];
    offsetDb = 0;
    setLoadingOff(true);
    await getDataBaseList();
    setLoadingOff(false);
  }

  Future<void> getRepoList() async {
    List<Repository> listAuxRepo =
        await gitHubApi.getRepositories(page: page, language: textSearch);
    if (listAuxRepo.length > 0) {
      listRepositoryOn.addAll(listAuxRepo);
    } else {
      hasMoreOn = false;
    }
  }

  //se a query não retornar uma lista > 0, então o repositório ainda não foi salvo
  Future<bool> isSaved(Repository repository) async {
    List result = await dao.dataBase.query(dao.tableRepository,
        where: "id = ?", whereArgs: [repository.id]);
    return result.length > 0;
  }

  Future<int> insertRepoDataBase(Repository repository) async {
    return await dao.dataBase.insert(dao.tableRepository, repository.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> getDataBaseList() async {
    List result = await dao.dataBase
        .query(dao.tableRepository, limit: limitDb, offset: offsetDb);
    if (result.length > 0) {
      listRepositoryOff.addAll(result
          .map((mapDb) => Repository.fromJson(mapDb, fromDb: true))
          .toList());
    } else {
      hasMoreOff = false;
    }
  }

  Future<int> deleteRepositoryFromDb(Repository repository) async {
    return await dao.dataBase.delete(dao.tableRepository,
        where: "id = ?", whereArgs: [repository.id]);
  }

  nexPageOn() async {
    isLoadingRepoOn = true;
    page++;
    await getRepoList();
    setLoadingOn(false);
  }

  nextPageOff() async {
    isLoadingRepoOff = true;
    offsetDb += limitDb;
    await getDataBaseList();
    setLoadingOff(false);
  }

  setLoadingOn(bool value) {
    this.isLoadingRepoOn = value;
    update();
  }

  setLoadingOff(bool value) {
    this.isLoadingRepoOff = value;
    update();
  }
}
