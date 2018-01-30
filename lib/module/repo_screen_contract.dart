import 'package:fluthubrepos/data/model/github_repo.dart';
import 'package:fluthubrepos/module/repo_screen_presenter.dart';

abstract class RepoScreenContractView {

  void setPresenter(RepoScreenPresenter presenter);

  void updateData(List<GithubRepo> repo);

  void showMessage(String msg);

}

abstract class RepoScreenContractPresenter {

  void githubUser(String userName);

  void loadData();

}