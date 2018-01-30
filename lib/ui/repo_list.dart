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
  List<GithubRepo> _repos;
  bool _isLoading;
  BuildContext _scaffoldContext;


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.githubUser("DeepanshuHarbola");
    _presenter.loadData();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainBody = new Column(
      children: <Widget>[
        new Flexible(
          child: _buildListComposer(),
        ),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(
              color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ],
    );
    return new Scaffold(
      appBar: new AppBar(title: new Text("Fluthub Repos")),
      body: new Builder(
          builder: (BuildContext context) {
            _scaffoldContext = context;
            return mainBody;
          }
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _repos.clear();
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
                      Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
                        content: new Text("No user to find"),
                      ));
                    }
                  },
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

      if(_repos == null || _repos.isEmpty ) {
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

    _repos.forEach((repo) => list.add(new ListItem(repo)));
    return list;
  }

  @override
  void setPresenter(RepoScreenPresenter presenter) {
    _presenter = presenter;
  }

  @override
  void updateData(List<GithubRepo> repo) {
    setState(() {
      this._repos = repo;
      _isLoading = false;
    });
  }

  @override
  void showMessage(String msg) {
    Scaffold.of(_scaffoldContext).showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
    setState(() {
      _isLoading = false;
    });
  }
}
