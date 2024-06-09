import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';

class ProfileImageBox extends StatelessWidget {
  const ProfileImageBox(
    this.profileImage, {
    Size? size,
    super.key,
  }) : _size = size ?? const Size(100, 100);

  final String profileImage;
  final Size _size;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _size.height,
        width: _size.width,
        child: profileImage.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  profileImage,
                  height: _size.height,
                  width: _size.width,
                ),
              )
            : const Icon(
                CarbonIcons.user,
                size: 48,
              ),
      );
}
