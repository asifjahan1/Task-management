import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task/Model/post_model.dart';

class PostProvider with ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;

  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  final Box _hiveBox = Hive.box('postsBox');

  PostProvider() {
    loadPosts(); // App Start e Hive theke Data Load korbe
  }

  // API Theke Data Fetch Kora & Hive e Save Kora
  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _posts = data.map((item) => PostModel.fromJson(item)).toList();

        // Fetch kora  and data Hive e Save kora
        await _hiveBox.put('cachedPosts', json.encode(data));
      }
    } catch (e) {
      debugPrint("API Fetch Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Hive theke Offline Data Load Kora
  void loadPosts() {
    final cachedData = _hiveBox.get('cachedPosts');

    if (cachedData != null) {
      List<dynamic> data = json.decode(cachedData);
      _posts = data.map((item) => PostModel.fromJson(item)).toList();
      notifyListeners();
    }
  }

  // jodi internet thake API call korbe, otherwise Hive theke show korbe
  Future<void> refreshPosts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _posts = data.map((item) => PostModel.fromJson(item)).toList();

        // jodi new data pay tahole Hive a save korbe
        await _hiveBox.put('cachedPosts', json.encode(data));
      }
    } catch (e) {
      debugPrint("No internet, loading from Hive..."); // Offline Mode
      loadPosts();
    }

    notifyListeners();
  }
}
