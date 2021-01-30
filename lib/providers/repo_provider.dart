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
    ),
    Repo(
      repoId: '1',
      parentRepoId: '0',
      authorId: '0',
      title: 'Dummy 2',
      description: 'Just a dummy description of the repo',
    ),
    Repo(
      repoId: '2',
      parentRepoId: '0',
      authorId: '0',
      title: 'Dummy 3',
      description: 'Just a dummy description of the repo',
    ),
  ];
  final String authToken;
  final String userId;
  RepoProvider(this.authToken, this.userId, this._repo);

  Future<void> addRepo(Repo repo) async {
    final url =
        'https://open-source-cinema-default-rtdb.firebaseio.com/repos.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          // 'title': product.title,
          // 'description': product.description,
          // 'imageUrl': product.imageUrl,
          // 'price': product.price,
          'title': repo.title,

          'parentRepoId': userId,
          'authorId': userId,
          'description': repo.description,
        }),
      );
      final newRepo = Repo(
        title: repo.title,
        repoId: json.decode(response.body)['name'],
        parentRepoId: userId,
        authorId: userId,

      );
      _repo.add(newRepo);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<Repo> get repo {
    return [..._repo];
  }
}
