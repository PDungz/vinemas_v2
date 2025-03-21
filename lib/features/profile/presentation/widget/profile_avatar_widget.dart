import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Button/custom_icon_button.dart';
import 'package:vinemas_v1/features/login/domain/entity/user.dart';
import 'package:vinemas_v1/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                File? imageFile;
                UserEntity? user;
                if (state is ProfileUpdateUserState) {
                  imageFile = state.imageFile;
                }
                if (state is ProfileGetUserState) {
                  user = state.user;
                }

                return Container(
                  margin: const EdgeInsets.only(top: 80),
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: imageFile != null
                      ? Image.file(imageFile, fit: BoxFit.cover)
                      : (user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty
                          ? Image.network(user.avatarUrl ?? '',
                              fit: BoxFit.cover)
                          : Image.asset(
                              $AssetsImagesGen().background.splash.path,
                              fit: BoxFit.cover,
                            )),
                );
              },
            ),
            Positioned(
              bottom: -5,
              right: 0,
              child: CustomIconButton(
                elevation: 0,
                svgPathUp: $AssetsIconsGen().iconApp.camera,
                onPressed: () {
                  context.read<ProfileBloc>().add(ProfileImageEvent());
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            UserEntity? user;
            if (state is ProfileGetUserState) {
              user = state.user;
            }
            return Text(
              user?.fullName ?? 'Vinemas',
              style: Theme.of(context).textTheme.titleMedium,
            );
          },
        ),
      ],
    );
  }
}
