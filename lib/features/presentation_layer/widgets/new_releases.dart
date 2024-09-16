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
import 'package:movies_app/features/presentation_layer/pages/firebase_functions.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class NewReleasesMovies extends StatefulWidget {
  const NewReleasesMovies({super.key});

  @override
  State<NewReleasesMovies> createState() => _NewReleasesMoviesState();
}

class _NewReleasesMoviesState extends State<NewReleasesMovies> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getNewReleasesMovies(Variables.newReleasesPage);
    scrollControllerNewReleases.addListener(() {
      if (Variables.isEndNewReleases == false) {
        double scrollMax = scrollControllerNewReleases.position.maxScrollExtent;
        double scroll = scrollControllerNewReleases.offset;
        if (scroll == scrollMax) {
          HomeCubit.get(context)
              .getNewReleasesMovies(Variables.newReleasesPage);
        }
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerNewReleases.dispose();
  }

  final ScrollController scrollControllerNewReleases = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeNewReleasesEndState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("No More New Releases Movies available")));
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.w),
          margin: EdgeInsets.symmetric(vertical: 15.w),
          color: AppColors.greyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "New Releases",
                style: AppStyles.title_15,
              ),
              SizedBox(
                height: 13.h,
              ),
              Container(
                height: 130.h,
                child: ListView.separated(
                  controller: scrollControllerNewReleases,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 14.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    List<String> newReleasesModel = [
                      Variables.newReleasesPagination[index].id.toString(),
                      Variables.newReleasesPagination[index].backdropPath ?? "",
                      Variables.newReleasesPagination[index].originalTitle ?? "",
                      Variables.newReleasesPagination[index].releaseDate ?? "",
                      Variables.newReleasesPagination[index].overview ?? "",
                    ];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MovieDetails(),
                            settings: RouteSettings(
                              arguments: Variables
                                  .newReleasesPagination[index].id
                                  .toString(),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                        child: Stack(
                          children: [
                            Variables.newReleasesPagination[index].posterPath ==
                                    null
                                ? Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.lightGreyColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: imageNotFound(100, double.infinity),
                                  )
                                : CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: 100.w,
                                    height: double.infinity.h,
                                    imageUrl:
                                        '${Constants.baseURLImage}${Variables.newReleasesPagination[index].posterPath}',
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.whiteColor,
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                            Positioned(
                              top: -7.h,
                              left: -11.w,
                              child: InkWell(
                                onTap: () {
                                  HomeCubit.get(context).addToWatchlist(
                                    WatchlistModel(
                                      id: newReleasesModel[0],
                                      backdropPath: newReleasesModel[1],
                                      originalTitle: newReleasesModel[2],
                                      releaseDate: newReleasesModel[3],
                                      overview: newReleasesModel[4],
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color:
                                      HomeCubit.get(context).isSaved(
                                        WatchlistModel(
                                          id: newReleasesModel[0],
                                          backdropPath: newReleasesModel[1],
                                          originalTitle: newReleasesModel[2],
                                          releaseDate: newReleasesModel[3],
                                          overview: newReleasesModel[4],
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
                                          id: newReleasesModel[0],
                                          backdropPath: newReleasesModel[1],
                                          originalTitle: newReleasesModel[2],
                                          releaseDate: newReleasesModel[3],
                                          overview: newReleasesModel[4],
                                        ),
                                      )
                                          ? Icons.done
                                          : Icons.add,
                                      color:
                                          AppColors.whiteColor.withOpacity(0.9),
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: Variables.newReleasesPagination.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
