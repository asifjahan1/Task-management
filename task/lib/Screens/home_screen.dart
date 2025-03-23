import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/Model/post_model.dart';
import '../providers/post_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: const Color(0xFF11161F),
      appBar: AppBar(
        title: const Text(
          "Flutter API & Hive",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF11161F),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: postProvider.refreshPosts,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        edgeOffset: 1.0,
        displacement: 40,
        strokeWidth: 3,
        child: postProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : postProvider.posts.isEmpty
                ? const Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: postProvider.posts.length,
                    itemBuilder: (context, index) {
                      final PostModel post = postProvider.posts[index];
                      return Card(
                        color: Colors.white10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            post.title ?? "No Title",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            post.body ?? "No Content",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: postProvider.fetchPosts,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
