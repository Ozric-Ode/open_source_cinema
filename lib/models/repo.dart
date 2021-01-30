import "package:flutter/material.dart";

class Repo {
  final String title;
  final List<String> scripts;
  final int parentId;
  final String authorId;
  bool isForked = false;

  Repo({
    @required this.parentId,
    @required this.authorId,
    @required this.title,
    @required this.isForked,
    @required this.scripts,
  });
}
