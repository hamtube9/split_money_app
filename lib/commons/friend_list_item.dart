// Widget for a single friend item
import 'package:flutter/material.dart';
import 'package:split_money/commons/circle_avatar.dart';

class FriendListItem extends StatelessWidget {
  final List<String> imageUrls;

  const FriendListItem({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    // The Row widget is used to display the avatars horizontally.
    return Container(
      height: 50,
      width: 120,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(imageUrls.length, (index) {
          return Positioned(
            top: 0,
            bottom: 0,
            right: imageUrls.length - index == 0 ? 0.0 : 16.0 * (imageUrls.length - index),
            child: ClipRRect(borderRadius: BorderRadius.circular(26),child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(26)
              ),
              child: Image.network(
                "https://images.ctfassets.net/sfnkq8lmu5d7/1wwJDuKWXF4niMBJE9gaSH/97b11bcd7d41039f3a8eb5c3350acdfd/2024-05-24_Doge_meme_death_-_Hero.jpg?w=1000&h=750&fl=progressive&q=70&fm=jpg",
              ),
            ),),
          );
        }),
      ),
    );
  }
}
