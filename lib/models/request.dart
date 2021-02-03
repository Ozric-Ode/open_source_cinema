import "package:flutter/material.dart";

class Request with ChangeNotifier {
  final String parentRepoId, childRepoId;
  final String title;
  final String requestMessage;

  Request({
    @required this.parentRepoId,
    @required this.childRepoId,
    @required this.requestMessage,
    @required this.title,
  });
}
