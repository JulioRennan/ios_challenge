import 'package:get/get.dart';
import 'package:ios_challenge/model/API/git_hub_api.dart';
import 'package:ios_challenge/model/entitys/pull.dart';

class PullController extends GetxController {
  bool isLoadingPull = true;
  GitHubApi gitHubApi = GitHubApi();
  List<Pull> listPulls = [];

  //from reposiory model;
  String fullName;
  PullController({required this.fullName});

  Future<void> getPullList() async {
    listPulls = await gitHubApi.getPulls(fullName: fullName);
  }

  setLoadingPull(bool value) {
    isLoadingPull = value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPullList().then((value) => setLoadingPull(false));
  }
}
