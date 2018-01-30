class GithubRepo {
  final int id;
  final String name;
  final String description;
  final String language;
  final int stargazersCount;

  GithubRepo({this.id, this.name, this.description,
    this.language, this.stargazersCount});

  GithubRepo.map(Map<String, dynamic> map) :
        id = map['id'],
        name = "${map['name']}",
        description = "${map['description']}",
        language = "${map['language']}",
        stargazersCount = map['stargazers_count'];

}