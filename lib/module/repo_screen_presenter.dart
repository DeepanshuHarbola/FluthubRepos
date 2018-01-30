import 'package:fluthubrepos/data/services/api_client.dart';
import 'package:fluthubrepos/di/injector.dart';
import 'package:fluthubrepos/module/repo_screen_contract.dart';

class RepoScreenPresenter extends RepoScreenContractPresenter {
  RepoScreenContractView view;
  ApiClient client;
  String userName;

  RepoScreenPresenter(this.view) {
    client = new Injector().client;
    view.setPresenter(this);
  }

  @override
  void githubUser(String userName) {
    this.userName = userName;
  }

  @override
  void loadData() {
    client
        .fetchGithubRepos(userName)
        .then((repo) => view.updateData(repo))
        .catchError((onError) => view.showMessage(onError.message));
  }
}
