import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/reuseable_components/image_not_found.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/core/utiles/app_styles.dart';
import 'package:movies_app/core/utiles/constants.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/models/watchlist_model.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_state.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class RecommendedMovies extends StatefulWidget {
  const RecommendedMovies({super.key});

  @override
  State<RecommendedMovies> createState() => _RecommendedMoviesState();
}

class _RecommendedMoviesState extends State<RecommendedMovies> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getRecommendedMovies(Variables.recommendedPage);
    scrollControllerRecommended.addListener((){
      if (Variables.isEndRecommended == false) {
        var scrollMax = scrollControllerRecommended.position.maxScrollExtent;
        var scroll = scrollControllerRecommended.offset;
        if (scroll == scrollMax) {
          HomeCubit.get(context)
              .getRecommendedMovies(++Variables.recommendedPage);
        }
      } else {
        return;
      }
    });
  }

  ScrollController scrollControllerRecommended = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollControllerRecommended.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeRecommendedEndState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No More Recommended Movies available")));
        }
      },
      builder: (context, state) {
        return Container(
          height: 255.h,
          margin: EdgeInsets.symmetric(vertical: 15.h),
          padding:
              EdgeInsets.only(top: 10.h, left: 25.w, bottom: 15.h, right: 10.w),
          width: double.infinity.w,
          color: AppColors.greyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Recommended",
                style: AppStyles.title_15,
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 186.h,
                child: ListView.separated(
                  controller: scrollControllerRecommended,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 14.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    List<String?> recommendedModel = [
                      Variables.newRecommendedPagination[index].id.toString(),
                      Variables.newRecommendedPagination[index].backdropPath,
                      Variables.newRecommendedPagination[index].originalTitle,
                      Variables.newRecommendedPagination[index].releaseDate,
                      Variables.newRecommendedPagination[index].overview,
                    ];
                    return Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.r),
                                topLeft: Radius.circular(5.r)),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, MovieDetails.routeName,
                                        arguments: recommendedModel[0]);
                                  },
                                  child: Variables.newRecommendedPagination[index].posterPath ==
                                          null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.lightGreyColor,
                                                width: 2.w),
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: imageNotFound(
                                              double.infinity, 128),
                                        )
                                      : CachedNetworkImage(
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .whiteColor,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                          fit: BoxFit.fill,
                                          width: double.infinity.w,
                                          height: 128.h,
                                          imageUrl:
                                              '${Constants.baseURLImage}${Variables.newRecommendedPagination[index].posterPath ?? "No Image"}'),
                                ),
                                Positioned(
                                  top: -7.h,
                                  left: -11.w,
                                  child: InkWell(
                                    onTap: () {
                                      HomeCubit.get(context).addToWatchlist(
                                        WatchlistModel(
                                          id: recommendedModel[0],
                                          backdropPath: recommendedModel[1],
                                          originalTitle: recommendedModel[2],
                                          releaseDate: recommendedModel[3],
                                          overview: recommendedModel[4],
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          color: HomeCubit.get(context).isSaved(
                                            WatchlistModel(
                                              id: recommendedModel[0],
                                              backdropPath: recommendedModel[1],
                                              originalTitle:
                                                  recommendedModel[2],
                                              releaseDate: recommendedModel[3],
                                              overview: recommendedModel[4],
                                            ),
                                          )
                                              ? AppColors.yellowColor
                                              : AppColors.lightGreyColor
                                                  .withOpacity(0.9),
                                          size: 45.sp,
                                        ),
                                        Icon(
                                          HomeCubit.get(context).isSaved(
                                            WatchlistModel(
                                              id: recommendedModel[0],
                                              backdropPath: recommendedModel[1],
                                              originalTitle:
                                                  recommendedModel[2],
                                              releaseDate: recommendedModel[3],
                                              overview: recommendedModel[4],
                                            ),
                                          )
                                              ? Icons.done
                                              : Icons.add,
                                          color: AppColors.whiteColor
                                              .withOpacity(0.9),
                                          size: 18.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5.h, right: 10.w, left: 7.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20.sp,
                                      color: AppColors.yellowColor,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      Variables.newRecommendedPagination[index]
                                          .voteAverage
                                          .toString()
                                          .substring(0, 3),
                                      style: AppStyles.descriptionInter_10,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${Variables.newRecommendedPagination[index].originalTitle}",
                                  style: AppStyles.descriptionInter_10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Variables.newRecommendedPagination[index]
                                            .releaseDate ==
                                        ""
                                    ? Text("No Date",style: AppStyles.description_8,)
                                    : Text(
                                        Variables.newRecommendedPagination[index]
                                            .releaseDate
                                            .toString()
                                            .substring(0, 4),
                                        style: AppStyles.description_8,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: Variables.newRecommendedPagination.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
