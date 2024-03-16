import 'package:github_repositories_flutter/model/repository_entity.dart';
import 'package:dio/dio.dart';

class GitHubRepositoriesRepository {
  final _dio = Dio();

  final _url = 'https://api.github.com';

  Future<Repository> fetchRepositories(int pageIndex) async{
    final response = await _dio.get("$_url/search/repositories?q=language:kotlin&sort=stars&page=$pageIndex&per_page=20");
    return Repository.fromJson(response.data);
  }
}