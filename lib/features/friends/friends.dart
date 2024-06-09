import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/model/friend.dart';
import 'package:pushup_bro/features/friends/widgets/friend_profile.dart';

class Friends extends StatelessWidget {
  Friends({super.key});
  static const routeName = '/friends';

  final List<Friend> friends = [
    Friend(
      name: 'Friend 1',
      image: 'https://picsum.photos/200',
      progress: (level: 0, points: 0),
    ),
    Friend(
      name: 'Friend 2',
      image: '',
      progress: (level: 2, points: 30),
    ),
    ...List.generate(
      8,
      (index) => Friend(
        name: 'Friend $index',
        image: 'https://picsum.photos/200',
        progress: (level: index, points: 10),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FriendProfile(friends[index]),
                  ),
                  itemCount: friends.length,
                ),
              ),
            ],
          ),
        ),
      );
}
