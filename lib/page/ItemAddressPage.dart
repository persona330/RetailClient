import 'package:flutter/material.dart';
import 'package:retail/model/Post.dart';

class ItemAddressPage extends StatelessWidget {

  final Post post;

  // элемент списка отображает один пост
  ItemAddressPage(this.post);

  Widget build(BuildContext context)
  {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green.shade300),
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: ListTile(
        leading: Text(post.userId.toString(),),
      title: Text('${post.title}'),
      subtitle: Text(
        'Тело: ${post.body}\n'
        ),
        trailing: Text('${post.id}'),
      ),
        );
  }
}