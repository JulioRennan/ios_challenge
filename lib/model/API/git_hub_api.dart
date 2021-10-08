import 'package:dio/dio.dart';
import 'package:ios_challenge/model/entitys/pull.dart';
import 'package:ios_challenge/model/entitys/repository.dart';

class GitHubApi extends Interceptor {
  Dio _dio = Dio();
  String baseUrl = "https://api.github.com";

  GitHubApi() {
    //configuração default das requisições
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
    );
    _dio.options = options;
  }
  //reponse.data contém o body de retorno da API
  Future<List<Repository>> getRepositories(
      {String language = "Swift", String sort = "stars", int page = 1}) async {
    String path = "/search/repositories";
    List<Repository> listRepositories = [];

    var response = await _dio.get(path, queryParameters: {
      "q": "language:$language",
      "sort": sort,
      "page": page
    });

    if (response.data["items"] != null) {
      listRepositories = (response.data['items'] as List)
          .map((json) => Repository.fromJson(json))
          .toList();
    }
    return listRepositories;
  }

  Future<List<Pull>> getPulls({required String fullName}) async {
    String path = "https://api.github.com/repos/$fullName/pulls";
    List<Pull> listPulls = [];
    var response = await _dio.get(path);

    listPulls =
        (response.data as List).map((json) => Pull.fromJson(json)).toList();

    return listPulls;
  }
}
