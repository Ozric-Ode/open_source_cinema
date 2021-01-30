import "package:flutter/material.dart";
import './scripts.dart';

class Repo {
  final String repoId;
  final String title;
  List<Scripts> script;
  String description;
  final int parentRepoId;
  final String authorId;
  bool isForked = false;

  Repo({
    @required this.repoId,
    @required this.parentRepoId,
    @required this.authorId,
    @required this.title,
    @required this.isForked,
    this.description,
  });
}
