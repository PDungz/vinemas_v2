import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Layout/custom_layout_horizontal.dart';
import 'package:packages/widget/Layout/custom_layout_vertical.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/core/global/global_bloc/global_bloc.dart';
import 'package:vinemas_v1/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:vinemas_v1/gen/assets.gen.dart';
import 'package:vinemas_v1/l10n/generated/app_localizations.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CustomLayoutVertical(
          verticalPadding: 4,
          horizontalPadding: 0,
          topWidget: Text(
            AppLocalizations.of(context)!.keyword_settings,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColor.secondaryTextColor),
          ),
          bottomWidget: CustomLayoutHorizontal(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            horizontalPadding: 8,
            leftWidget: Text(
              AppLocalizations.of(context)!.keyword_language,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            rightWidget: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context
                          .read<GlobalBloc>()
                          .add(LanguageEvent(language: 'vi')),
                      child: Container(
                        padding: const EdgeInsets.all(4.8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: state.isVietnamese == true
                                ? AppColor.primaryTextColor
                                : AppColor.secondaryTextColor,
                            width: 1.6,
                          ),
                        ),
                        child: Image.asset(
                          $AssetsImagesFlagGen().vietNam.path,
                          height: 28,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () => context
                          .read<GlobalBloc>()
                          .add(LanguageEvent(language: 'en')),
                      child: Container(
                        padding: const EdgeInsets.all(4.8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: state.isVietnamese != true
                                ? AppColor.primaryTextColor
                                : AppColor.secondaryTextColor,
                            width: 1.6,
                          ),
                        ),
                        child: Image.asset(
                          $AssetsImagesFlagGen().england.path,
                          height: 28,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
