import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:movies_app/features/presentation_layer/pages/firebase_functions.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}


class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getPopularMovies(Variables.popularPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomePopularEndState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("No More Popular Movies Available")));
        }
      },
      builder: (context, state) {
        return CarouselSlider(
          items: Variables.newPopularPagination.map((results) {
            List<String?> popularModel = [
              results.id.toString(),
              results.backdropPath,
              results.originalTitle,
              results.releaseDate,
              results.overview
            ];
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Column(
                  children: [
                    Builder(
                      builder: (context) {
                        return results.backdropPath == null
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.lightGreyColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: imageNotFound(double.infinity, 217),
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.fill,
                                height: 217.h,
                                imageUrl:
                                    '${Constants.baseURLImage}${results.backdropPath}',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.whiteColor,
                                      value: downloadProgress.progress),
                                ),
                              );
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 25.w, right: 10.w),
                  height: 200.h,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MovieDetails.routeName,
                                    arguments: results.id.toString());
                              },
                              child: results.posterPath == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.lightGreyColor,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: imageNotFound(130, 217),
                                    )
                                  : CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      height: 217.h,
                                      width: 130.w,
                                      imageUrl:
                                          '${Constants.baseURLImage}${results.posterPath}',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            color: AppColors.whiteColor,
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: -7.h,
                              left: -11.w,
                              child: InkWell(
                                onTap: () {
                                  HomeCubit.get(context).addToWatchlist(
                                    WatchlistModel(
                                      id: popularModel[0],
                                      backdropPath: popularModel[1],
                                      originalTitle: popularModel[2],
                                      releaseDate: popularModel[3],
                                      overview: popularModel[4],
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
                                          id: popularModel[0],
                                          backdropPath: popularModel[1],
                                          originalTitle: popularModel[2],
                                          releaseDate: popularModel[3],
                                          overview: popularModel[4],
                                        ),
                                      )
                                          ? AppColors.yellowColor
                                          : AppColors.lightGreyColor
                                              .withOpacity(0.9),
                                      size: 50.sp,
                                    ),
                                    Icon(
                                      HomeCubit.get(context).isSaved(
                                        WatchlistModel(
                                          id: popularModel[0],
                                          backdropPath: popularModel[1],
                                          originalTitle: popularModel[2],
                                          releaseDate: popularModel[3],
                                          overview: popularModel[4],
                                        ),
                                      )
                                          ? Icons.done
                                          : Icons.add,
                                      color:
                                          AppColors.whiteColor.withOpacity(0.9),
                                      size: 20.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              results.originalTitle ?? "",
                              style: AppStyles.title_15,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              results.releaseDate.toString().substring(0, 4),
                              style: AppStyles.descriptionInter_10,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              if (index == Variables.newPopularPagination.length - 1) {
                HomeCubit.get(context)
                    .getPopularMovies(++Variables.popularPage);
              }
              setState(() {});
            },
            height: 295.h,
            autoPlay: true,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
