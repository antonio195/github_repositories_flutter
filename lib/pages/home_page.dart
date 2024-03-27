import 'package:flutter/material.dart';
import 'package:github_repositories_flutter/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();
  late ScrollController _scrollController;

  _success() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _controller.items.length,
      itemBuilder: (context, int index) {
        var repoItem = _controller.items[index];
        var starsCount = repoItem?.stargazersCount;
        var forksCount = repoItem?.forksCount;
        return ListTile(
          leading: Image.network(repoItem?.owner?.avatarUrl ?? ""),
          title: Text(repoItem?.name ?? ""),
          subtitle: Text("Stars: $starsCount, Forks: $forksCount"),
        );
      },
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            _controller.start();
          },
          child: const Text("Tentar novamente.")),
    );
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _start() {
    return Container();
  }

  _stateManagement(HomeStates state) {
    switch (state) {
      case HomeStates.start:
        return _start();
      case HomeStates.loading:
        return _loading();
      case HomeStates.success:
        return _success();
      case HomeStates.error:
        return _error();
      default:
        return _start();
    }
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _controller.start();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.start();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller.state,
        builder: (context, child) {
          return _stateManagement(_controller.state.value);
        },
      ),
    );
  }
}
