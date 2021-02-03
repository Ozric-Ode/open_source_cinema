import "package:flutter/material.dart";
import 'package:open_source_cinema/models/request.dart';
import './scripts.dart';

class Repo with ChangeNotifier {
  final String repoId;
  final String title;
  List<Scripts> script = [];
  String description;
  final String parentRepoId;
  final String authorId;
  bool isForked = false;
  final genre;
  List<Request> reqScript = [];

  Repo({
    @required this.repoId,
    @required this.parentRepoId,
    @required this.authorId,
    @required this.title,
    this.reqScript,
    this.genre,
    this.description,
  });
}
