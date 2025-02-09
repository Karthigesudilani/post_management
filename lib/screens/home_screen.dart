import 'package:flutter/material.dart';
import 'package:post_management/providers/post_provider.dart';
import 'package:post_management/utils/enum/api_status.dart';
import 'package:post_management/widget/post_item.dart';
import 'package:provider/provider.dart';
import 'post_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFf4f6fa),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Post Management',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostFormScreen()),
              );
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
      body: postProvider.loadStatus == ApiStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : postProvider.loadStatus == ApiStatus.success
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    final post = postProvider.posts[index];
                    return PostItem(post: post);
                  },
                )
              : Center(
                  child: Text(
                    postProvider.loadError,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
    );
  }
}
