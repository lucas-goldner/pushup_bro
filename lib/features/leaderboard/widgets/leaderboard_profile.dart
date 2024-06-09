import 'package:flutter/cupertino.dart';
import 'package:pushup_bro/core/model/user.dart';
import 'package:pushup_bro/core/widgets/minimized_profile.dart';

class LeaderboardProfile extends StatelessWidget {
  const LeaderboardProfile(this.user, {super.key});
  final User user;

  @override
  Widget build(BuildContext context) => MinimizedProfile(
        user.toMinimizedUser(),
        leadingItem: const Text(''),
      );
}
