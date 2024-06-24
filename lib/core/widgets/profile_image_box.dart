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
        'https://media.discordapp.net/attachments/1229873636845031554/1254442735075721279/image.png?ex=667ad3d6&is=66798256&hm=5baa4e5edf50e9ef3b87301c6b11621b194290df95438629cd02eeda337c194d&=&format=webp&quality=lossless';
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
