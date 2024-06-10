import 'package:flutter/material.dart';
import 'package:pushup_bro/core/extensions/build_context_ext.dart';
import 'package:pushup_bro/features/pushup_tracking/model/news.dart';

class NewsBannerItem extends StatelessWidget {
  const NewsBannerItem({
    required this.factor,
    required this.index,
    required this.news,
    super.key,
  });

  final double factor;
  final int index;
  final News news;

  Widget _buildBasicCard(
    BuildContext context,
    Widget content,
  ) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            height: 25 + (factor * 30),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  context.shadow,
                ],
              ),
              child: Center(
                child: content,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => switch (news.type) {
        NewsType.update => _buildBasicCard(
            context,
            _UpdateCard(
              news,
            ),
          ),
        NewsType.friendBoost => _buildBasicCard(
            context,
            _FriendBoostCard(news),
          ),
        NewsType.eventDay => _buildBasicCard(
            context,
            _EventDayCard(news),
          ),
      };
}

class _UpdateCard extends StatelessWidget {
  const _UpdateCard(this.news);
  final News news;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _FriendBoostCard extends StatelessWidget {
  const _FriendBoostCard(this.news);
  final News news;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _EventDayCard extends StatelessWidget {
  const _EventDayCard(this.news);
  final News news;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
