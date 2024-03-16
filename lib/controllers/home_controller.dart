import 'package:github_repositories_flutter/model/repository_entity.dart';
import 'package:github_repositories_flutter/repositories/github_repositories_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  final repository = GitHubRepositoriesRepository();
  final state = ValueNotifier<HomeStates>(HomeStates.start);
  late Repository repos;

  int _pageIndex = 0;

  Future start() async {
    if(_pageIndex == 0){
      state.value = HomeStates.loading;
    }else{
      state.value = HomeStates.moreItems;
    }
    try {
      repos = await repository.fetchRepositories(_pageIndex);
      state.value = HomeStates.success;
      _pageIndex++;
    } catch (e) {
      state.value = HomeStates.error;
    }
  }
}

enum HomeStates { start, loading, success, error, moreItems }
