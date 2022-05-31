import 'package:appsebas/post.dart';
import 'package:flutter/material.dart';
import 'package:appsebas/post-repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final repo = PostRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<Post>>(
            future: repo.getPost(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const CircularProgressIndicator();
              }

              if (snap.hasError) {
                return const Icon(
                  Icons.error,
                  color: Colors.red,
                );
              }

              final posts = snap.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final post = posts![index];
                  return ListTile(
                    title: Text(post.title.toString()),
                    subtitle: Text(post.body.toString()),
                  );
                },
                itemCount: posts?.length ?? 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
