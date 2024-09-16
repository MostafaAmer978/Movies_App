import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/reuseable_components/image_not_found.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/core/utiles/app_styles.dart';
import 'package:movies_app/core/utiles/constants.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_state.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomeCubit.get(context),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is WatchlistTabState ||
              state is HomeSuccessState ||
              state is AddToWatchlist) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Watchlist", style: AppStyles.title_22),
                  SizedBox(
                    height: 15.h,
                  ),
                  Variables.watchlistMovies.isEmpty
                      ? Expanded(
                          child: Center(
                              child: Text("No Favourite Movies",
                                  style: AppStyles.title_15)),
                        )
                      : Expanded(
                          child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: AppColors.dividerColor,
                                    height: 30.h,
                                  );
                                },
                                itemCount: Variables.watchlistMovies.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, MovieDetails.routeName,
                                          arguments: Variables
                                              .watchlistMovies[index].id
                                              .toString());
                                    },
                                    child: SizedBox(
                                      height: 100.h,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            child: Variables
                                                        .watchlistMovies[index]
                                                        .backdropPath ==
                                                    null
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .lightGreyColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                    ),
                                                    child: imageNotFound(
                                                        140, double.infinity))
                                                : CachedNetworkImage(
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                              child: CircularProgressIndicator(
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  value: downloadProgress
                                                                      .progress),
                                                            ),
                                                    fit: BoxFit.fill,
                                                    width: 140.w,
                                                    height: double.infinity.h,
                                                    imageUrl:
                                                        '${Constants.baseURLImage}${Variables.watchlistMovies[index].backdropPath}'),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 20.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    Variables
                                                            .watchlistMovies[
                                                                index]
                                                            .originalTitle ??
                                                        "No Title",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppStyles.title_15,
                                                  ),
                                                  Variables
                                                              .watchlistMovies[
                                                                  index]
                                                              .releaseDate ==
                                                          ""
                                                      ? Text(
                                                          "No Date",
                                                          style: AppStyles
                                                              .description_13,
                                                        )
                                                      : Text(
                                                          Variables
                                                              .watchlistMovies[
                                                                  index]
                                                              .releaseDate!
                                                              .substring(0, 4),
                                                          style: AppStyles
                                                              .description_13,
                                                        ),
                                                  Text(
                                                    Variables
                                                            .watchlistMovies[
                                                                index]
                                                            .overview ??
                                                        "No overview",
                                                    style: AppStyles
                                                        .description_13,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                          ),
                        ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
