import 'dart:async';

import 'package:fluthubrepos/data/model/github_repo.dart';
import 'package:fluthubrepos/data/services/api_service.dart';

class ApiClient {
  ApiService _apiService;

  ApiClient(){
    _apiService = new ApiService();
  }

  Future<List<dynamic>> fetchGithubRepos(String userName) =>
      _apiService.request("https://api.github.com/users/$userName/repos")
          .then((dynamic res) {
        return res.map((obj) => new GithubRepo.map(obj)).toList();
      });

}