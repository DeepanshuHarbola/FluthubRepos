import 'package:fluthubrepos/data/model/github_repo.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final GithubRepo _repo;

  ListItem(this._repo);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new Text(_repo.name,
              style: new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.black),
              maxLines: 2
          )
      ),

      new Padding(
          padding: new EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
          child: new Text(((_repo.description != "null") ? _repo.description : "No description"),
              style: new TextStyle(fontSize: 16.0)
          )
      ),

      new Row(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(left: 5.0, bottom: 5.0),
              child: new Text("Language: " + _repo.language,
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo
                ),
              )
          ),

          new Padding(
              padding: new EdgeInsets.only(left: 20.0, bottom: 5.0),
              child: new Icon(
                Icons.star, color: Colors.amber,
              ),
          ),
          new Padding(
                padding: new EdgeInsets.only(left: 2.0 ,bottom: 5.0, right: 5.0),
                child: new Text(_repo.stargazersCount.toString(),
                  style: new TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
          )

        ],
      )

    ];

    return new Padding(
        padding: new EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
        child: new Card(
          elevation: 4.0,
            color: Colors.white,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _widgets
            )
        )
    );
  }
}