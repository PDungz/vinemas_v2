import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packages/widget/Shimmer/custom_shimmer.dart';
import 'package:vinemas_v1/core/common/enum/process_status.dart';
import 'package:vinemas_v1/core/config/app_color.dart';
import 'package:vinemas_v1/features/about_sessions/domain/entity/session/cinema_band.dart';
import 'package:vinemas_v1/features/about_sessions/presentation/bloc/session_bloc/session_bloc.dart';

class SessionCinemaWidget extends StatefulWidget {
  final Function(CinemaBand) onCinemaSelected;

  const SessionCinemaWidget({super.key, required this.onCinemaSelected});

  @override
  State<SessionCinemaWidget> createState() => _SessionCinemaWidgetState();
}

class _SessionCinemaWidgetState extends State<SessionCinemaWidget> {
  int currentCinema = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: 68,
        width: double.infinity,
        child: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is SessionCinemaBandState) {
              switch (state.state) {
                case ProcessStatus.loading:
                  return SessionCinemaMovieLoadingWidget();
                case ProcessStatus.success:
                  final cinemaBands = state.cinemaBands;
                  if (cinemaBands != null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && currentCinema == 0) {
                        setState(() {
                          currentCinema = 0;
                        });
                        widget.onCinemaSelected(cinemaBands[0]);
                      }
                    });
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cinemaBands.length,
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            currentCinema = index;
                          });
                          widget.onCinemaSelected(cinemaBands[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: currentCinema == index
                                    ? Border.all(
                                        color: AppColor.buttonLinerOneColor)
                                    : Border.all(
                                        color: AppColor.secondaryColor),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        cinemaBands[index].imageUrl ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              cinemaBands[index].nameCinema ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: currentCinema == index
                                          ? AppColor.buttonLinerOneColor
                                          : AppColor.primaryTextColor),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                default:
                  return SizedBox();
              }
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class SessionCinemaMovieLoadingWidget extends StatelessWidget {
  const SessionCinemaMovieLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(width: 16),
          Column(
            children: [
              CustomShimmer(
                height: 48,
                width: 48,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
              SizedBox(height: 4),
              CustomShimmer(
                height: 16,
                width: 32,
                borderRadius: 8,
                baseColor: AppColor.secondaryTextColor.withOpacity(0.3),
                highlightColor: AppColor.buttonLinerOneColor.withOpacity(0.6),
              ),
            ],
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
