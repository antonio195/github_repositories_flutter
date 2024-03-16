class Repository {
  List<Items>? items;

  Repository({this.items});

  Repository.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  Owner? owner;
  String? htmlUrl;
  String? description;
  int? stargazersCount;
  String? language;
  int? forksCount;

  Items({
    this.name,
    this.owner,
    this.htmlUrl,
    this.description,
    this.stargazersCount,
    this.language,
    this.forksCount,
  });

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    htmlUrl = json['html_url'];
    description = json['description'];
    stargazersCount = json['stargazers_count'];
    language = json['language'];
    forksCount = json['forks_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['html_url'] = this.htmlUrl;
    data['description'] = this.description;
    data['stargazers_count'] = this.stargazersCount;
    data['language'] = this.language;
    data['forks_count'] = this.forksCount;
    return data;
  }
}

class Owner {
  String? login;
  String? avatarUrl;

  Owner({this.login, this.avatarUrl});

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}
