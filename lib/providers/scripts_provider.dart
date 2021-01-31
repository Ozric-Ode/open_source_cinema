import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:open_source_cinema/models/scripts.dart';
import '../models/repo.dart';

class ScriptsProvider with ChangeNotifier {
  List<Scripts> _scripts = [
    Scripts(
        
        title: 'Dummy 1',
        content: 'Just a dummy description of the repo',
        ),
    Scripts(
        
        title: 'Dummy 2',
        content: 'Just a dummy description of the repo',
        ),
    Scripts(
        
        title: 'Dummy 3',
        content: 'Just a dummy description of the repo',
        ),
    Scripts(
        
        title: 'Dummy 4',
        content: 'Just a dummy description of the repo',
        ),
    
  ];
  
  List<Repo> _homeRepo = [];
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
          'genre': repo.genre,
        }),
      );
      final newRepo = Repo(
        title: repo.title,
        repoId: json.decode(response.body)['name'],
        description: repo.description,
        parentRepoId: userId,
        authorId: userId,
        genre: repo.genre,
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
            genre: repoData['genre']));
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

  void homerepo(String genre) {
    if (genre != 'All') {
      _homeRepo = _repo
          .where((element) =>
              (element.genre == genre && element.authorId != userId))
          .toList();
      print('allis fine');
    } else {
      _homeRepo = _repo.where((element) => element.authorId != userId).toList();
    }
    notifyListeners();
  }

  List<Repo> get notMeRepo {
    return [..._homeRepo];
  }
}
