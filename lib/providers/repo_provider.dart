import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/repo.dart';

class RepoProvider with ChangeNotifier {
  List<Repo> _repo = [
    Repo(
      repoId: '0',
      parentRepoId: '0',
      authorId: '0',
      title: 'Dummy ',
      description: 'Just a dummy description of the repo',
      isForked: false,
    ),
    Repo(
      repoId: '1',
      parentRepoId: '0',
      authorId: '0',
      title: 'Dummy 2',
      description: 'Just a dummy description of the repo',
      isForked: false,
    ),
    Repo(
      repoId: '2',
      parentRepoId: '0',
      authorId: '0',
      title: 'Dummy 3',
      description: 'Just a dummy description of the repo',
      isForked: false,
    ),
  ];
  List<Repo> get repo {
    return [..._repo];
  }
}
