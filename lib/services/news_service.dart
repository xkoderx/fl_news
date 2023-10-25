import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news/models/category_model.dart';
import 'package:news/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'newsapi.org';
const _APIKEY = 'YOUR_API_KEY';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  dynamic _selectedCat = 'business';
  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var e in categories) {
      categoryArticles[e.name] = [];
    }
  }

  bool get isLoading => _isLoading;
  String get selectedCat => _selectedCat;
  set selectedCat(String v) {
    _selectedCat = v;
    _isLoading = true;
    getArticlesByCats(v);
    notifyListeners();
  }

  List<Article>? get getArticulosByCatSelc => categoryArticles[selectedCat];

  getTopHeadlines() async {
    // final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
    // final url =
    //     Uri.https('$_URL_NEWS', '/v2/top-headlines?country=ca&apiKey=$_APIKEY');
    // final resp = await http.get(Uri.parse(url));
    var url = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'us', 'apiKey': _APIKEY});
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCats(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    var url = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'category': category, 'country': 'us', 'apiKey': _APIKEY});
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]?.addAll(newsResponse.articles);

    _isLoading = false;
    notifyListeners();
  }
}
