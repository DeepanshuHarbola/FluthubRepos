import 'package:fluthubrepos/data/model/github_repo.dart';
import 'package:fluthubrepos/module/repo_screen_contract.dart';
import 'package:fluthubrepos/module/repo_screen_presenter.dart';
import 'package:fluthubrepos/ui/list_item.dart';
import 'package:flutter/material.dart';

class RepoScreen extends StatefulWidget {

  @override
  RepoScreenState createState() {
    RepoScreenState state = new RepoScreenState();
    new RepoScreenPresenter(state);
    return state;
  }

}

class RepoScreenState extends State<RepoScreen> implements RepoScreenContractView {

  final TextEditingController _textController = new TextEditingController();
  RepoScreenPresenter _presenter;
  List<GithubRepo> repos;
  bool _isLoading;


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.githubUser("DeepanshuHarbola");
    _presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Fluthub Repos")),
      body: new Column(                                        //modified
        children: <Widget>[                                         //new
          new Flexible(                                             //new
            child: _buildListComposer(),                               //new
          ),                                                        //new
          new Divider(height: 1.0),                                 //new
          new Container(                                            //new
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),                                                        //new
        ],                                                          //new
      ),                                                            //new
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    repos.clear();
    setState(() {
      _isLoading = true;
      _presenter.githubUser(text);
      _presenter.loadData();
    });
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Enter user name"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: (){
                    if(_textController.text != ""){
                      _handleSubmitted(_textController.text);
                    }
                    else{
                      /*Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("No user to find"),
                      ));*/
                    }
                  },
                  //onPressed: () => _handleSubmitted(_textController.text)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListComposer(){
    Widget widget;

    if (_isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );
    } else {

      if(repos == null || repos.isEmpty ) {
        widget = new Center(
            child: new Text("Error fetching data")
        );
      } else {
        widget = new ListView(
            children: _buildReposWidgetList()
        );
      }

    }

    return widget;
  }

  List<Widget> _buildReposWidgetList() {
    List<Widget> list = new List<Widget>();

    repos.forEach((repo) => list.add(new ListItem(repo)));
    return list;
  }

  @override
  void setPresenter(RepoScreenPresenter presenter) {
    _presenter = presenter;
  }

  @override
  void updateData(List<GithubRepo> repo) {
    setState(() {
      this.repos = repo;
      _isLoading = false;
    });
  }

  @override
  void showMessage(String msg) {
    /*Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
    ));*/
    setState(() {
      _isLoading = false;
    });
  }
}
