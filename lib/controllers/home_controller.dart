import 'package:github_repositories_flutter/model/repository_entity.dart';
import 'package:github_repositories_flutter/repositories/github_repositories_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
  final repository = GitHubRepositoriesRepository();
  final state = ValueNotifier<HomeStates>(HomeStates.start);
  late Repository repos;
  List<Items> items = [];

  int _pageIndex = 0;

  Future start() async {
      state.value = HomeStates.loading;
    try {
      var newItems = await repository.fetchRepositories(_pageIndex);
      newItems.items?.forEach((element) {
        items.add(element);
      });
      state.value = HomeStates.success;
      _pageIndex++;
    } catch (e) {
      state.value = HomeStates.error;
    }
  }
}

enum HomeStates { start, loading, success, error }
