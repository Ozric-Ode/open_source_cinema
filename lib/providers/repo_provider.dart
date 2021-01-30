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
        description: repo.description,
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

  Future<void> fetchAndSetRepos() async {
    // final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://open-source-cinema-default-rtdb.firebaseio.com/repos.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Repo> loadedRepos = [];
      extractedData.forEach((repoId, repoData) {
        loadedRepos.add(Repo(
          // id: prodId,
          // title: prodData['title'],
          // description: prodData['description'],
          // price: prodData['price'],
          // isFavorite:
          //     favoriteData == null ? false : favoriteData[prodId] ?? false,
          // imageUrl: prodData['imageUrl'],
          repoId: repoId,
          title: repoData['title'],
          description: repoData['description'],
          authorId: repoData['authorId'],
          parentRepoId: repoData['parentRepoId'],
        ));
      });
      // _items = loadedProducts;
      _repo = loadedRepos;
      notifyListeners();
    } catch (error) {
      print(error.toString());
      //throw (error);
    }
  }

  List<Repo> get repo {
    return [..._repo];
  }

  List<Repo> get notMeRepo {
    return _repo.where((element) => element.authorId != userId).toList();
  }
}
