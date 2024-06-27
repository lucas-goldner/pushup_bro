import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pushup_bro/core/cubit/db_cubit.dart';

class ProfileImageBox extends StatelessWidget {
  const ProfileImageBox(
    this.profileImage, {
    Size? size,
    double? iconSize,
    super.key,
  })  : _size = size ?? const Size(100, 100),
        _iconSize = iconSize ?? 48;

  final String profileImage;
  final Size _size;
  final double _iconSize;

  void _setImageAsProfilePicture(BuildContext context) {
    const imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/pushupbro-dev.appspot.com/o/image.webp?alt=media&token=fb5a258e-ce22-40f3-8957-fa253e2a92e7';
    context.read<DBCubit>().updateProfileImage(imageUrl);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _setImageAsProfilePicture(context),
        child: SizedBox(
          height: _size.height,
          width: _size.width,
          child: profileImage.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    profileImage,
                    height: _size.height,
                    width: _size.width,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  CarbonIcons.user,
                  size: _iconSize,
                ),
        ),
      );
}
