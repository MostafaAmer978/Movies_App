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

class MovieDetails extends StatelessWidget {
  static const String routeName = "MovieDetails";

   const MovieDetails({super.key});


  @override
  Widget build(BuildContext context) {
    String movieId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider.value(
      value: HomeCubit.get(context)
        ..getSimilarMovie(movieId, Variables.similarPage)
        ..getMovieDetails(movieId),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeSimilarEndState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No More Similar Movies Available")));
          }
        },
        builder: (context, state) {
          List<String?> movieDetailsModel = [
            Variables.movieDetailsModel?.id.toString(),
            Variables.movieDetailsModel?.backdropPath,
            Variables.movieDetailsModel?.originalTitle,
            Variables.movieDetailsModel?.releaseDate,
            Variables.movieDetailsModel?.overview,
          ];
          if (state is HomeSuccessState || state is AddToWatchlist || state is HomeSimilarEndState) {
            return Scaffold(
              backgroundColor: AppColors.blackColor,
              appBar: AppBar(
                backgroundColor: AppColors.blackColor,
                title: Text(
                    Variables.movieDetailsModel?.originalTitle ?? "No Title",
                    style: AppStyles.title_20),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Variables.movieDetailsModel?.backdropPath == null
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.lightGreyColor, width: 2),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: imageNotFound(double.infinity, 217),
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 217.h,
                            width: double.infinity.w,
                            imageUrl:
                                '${Constants.baseURLImage}${Variables.movieDetailsModel?.backdropPath}',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.whiteColor,
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) => Container(
                              alignment: Alignment.center,
                              height: double.infinity.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.lightGreyColor,
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: const Icon(
                                Icons.error,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Variables.movieDetailsModel?.originalTitle ??
                                "No Title",
                            style: AppStyles.titleInter_18,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Variables.movieDetailsModel?.releaseDate == ""
                              ? Text(
                                  "No Date",
                                  style: AppStyles.descriptionInter_10,
                                )
                              : Text(
                                  Variables.movieDetailsModel?.releaseDate
                                          ?.substring(0, 4) ??
                                      "",
                                  style: AppStyles.descriptionInter_10,
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 200.h,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: Stack(
                                    children: [
                                      Variables.movieDetailsModel?.posterPath ==
                                              null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .lightGreyColor,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              child: imageNotFound(
                                                  130, double.infinity),
                                            )
                                          : CachedNetworkImage(
                                              fit: BoxFit.fill,
                                              width: 130.w,
                                              imageUrl:
                                                  '${Constants.baseURLImage}${Variables.movieDetailsModel?.posterPath}',
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: AppColors
                                                            .whiteColor,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                      Positioned(
                                        top: -7.h,
                                        left: -11.w,
                                        child: InkWell(
                                          onTap: () {
                                            HomeCubit.get(context)
                                                .addToWatchlist(
                                              WatchlistModel(
                                                id: movieDetailsModel[0],
                                                backdropPath:
                                                    movieDetailsModel[1],
                                                originalTitle:
                                                    movieDetailsModel[2],
                                                releaseDate:
                                                    movieDetailsModel[3],
                                                overview: movieDetailsModel[4],
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Icon(
                                                Icons.bookmark,
                                                size: 50.sp,
                                                color: HomeCubit.get(context)
                                                        .isSaved(
                                                  WatchlistModel(
                                                    id: movieDetailsModel[0],
                                                    backdropPath:
                                                        movieDetailsModel[1],
                                                    originalTitle:
                                                        movieDetailsModel[2],
                                                    releaseDate:
                                                        movieDetailsModel[3],
                                                    overview:
                                                        movieDetailsModel[4],
                                                  ),
                                                )
                                                    ? AppColors.yellowColor
                                                    : AppColors.lightGreyColor
                                                        .withOpacity(0.9),
                                              ),
                                              Icon(
                                                HomeCubit.get(context).isSaved(
                                                  WatchlistModel(
                                                    id: movieDetailsModel[0],
                                                    backdropPath:
                                                        movieDetailsModel[1],
                                                    originalTitle:
                                                        movieDetailsModel[2],
                                                    releaseDate:
                                                        movieDetailsModel[3],
                                                    overview:
                                                        movieDetailsModel[4],
                                                  ),
                                                )
                                                    ? Icons.done
                                                    : Icons.add,
                                                size: 20.sp,
                                                color: AppColors.whiteColor
                                                    .withOpacity(0.9),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        controller: ScrollController(
                                            keepScrollOffset: false),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 3,
                                                childAspectRatio: 2),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              border: Border.all(
                                                  color:
                                                      AppColors.whiteColor),
                                            ),
                                            child: Text(
                                              Variables.movieDetailsModel
                                                      ?.genres?[index].name ??
                                                  "",
                                              style: AppStyles
                                                  .descriptionInter_10,
                                            ),
                                          );
                                        },
                                        itemCount: Variables.movieDetailsModel
                                                ?.genres?.length ??
                                            0,
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            Variables.movieDetailsModel
                                                    ?.overview ??
                                                "No Description",
                                            style: AppStyles.description_13,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      SizedBox(
                                        height: 28.h,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.yellowColor,
                                              size: 26.sp,
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              Variables.movieDetailsModel
                                                      ?.voteAverage
                                                      .toString()
                                                      .substring(0, 3) ??
                                                  "No Rate",
                                              style: AppStyles.titlePoppins_18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.r),
                      width: double.infinity,
                      height: 250.h,
                      color: AppColors.greyColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "More Like This",
                            style: AppStyles.title_15,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Variables.newSimilarPagination.isEmpty
                              ? Expanded(
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.error,
                                        color: AppColors.whiteColor,
                                        size: 30.sp,
                                      )),
                                )
                              : Expanded(
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (ScrollNotification scrollNotification){
                                      if(scrollNotification is ScrollEndNotification){
                                        if(Variables.isEndSimilar == false){
                                          var scroll = scrollNotification.metrics.pixels;
                                          var scrollMax = scrollNotification.metrics.maxScrollExtent;
                                          if(scroll == scrollMax){
                                            HomeCubit.get(context).getSimilarMovie(movieId, ++Variables.similarPage);
                                          }
                                      }
                                        }
                                        return true;
                                        },
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          List<String?> similarModel = [
                                            Variables.newSimilarPagination[index].id
                                                .toString(),
                                            Variables.newSimilarPagination[index]
                                                .backdropPath,
                                            Variables.newSimilarPagination[index]
                                                .originalTitle,
                                            Variables.newSimilarPagination[index]
                                                .releaseDate,
                                            Variables
                                                .newSimilarPagination[index].overview,
                                          ];
                                          return SizedBox(
                                            height: 185.h,
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5.r),
                                                    topRight:
                                                        Radius.circular(5.r),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context, MovieDetails.routeName,
                                                              arguments: Variables
                                                                  .newSimilarPagination[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                        },
                                                        child: Variables
                                                                    .newSimilarPagination[
                                                                        index]
                                                                    .posterPath ==
                                                                null
                                                            ? Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: AppColors
                                                                          .lightGreyColor,
                                                                      width: 2),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5.r),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5.r),
                                                                  ),
                                                                ),
                                                                child: imageNotFound(
                                                                    double
                                                                        .infinity,
                                                                    128),
                                                              )
                                                            : CachedNetworkImage(
                                                                fit: BoxFit.fill,
                                                                height: 128.h,
                                                                width: double
                                                                    .infinity.w,
                                                                imageUrl:
                                                                    '${Constants.baseURLImage}${Variables.newSimilarPagination[index].posterPath}',
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
                                                              ),
                                                      ),
                                                      Positioned(
                                                        top: -8.h,
                                                        left: -9.w,
                                                        child: InkWell(
                                                          onTap: () {
                                                            HomeCubit.get(context)
                                                                .addToWatchlist(
                                                              WatchlistModel(
                                                                id: similarModel[
                                                                    0],
                                                                backdropPath:
                                                                    similarModel[
                                                                        1],
                                                                originalTitle:
                                                                    similarModel[
                                                                        2],
                                                                releaseDate:
                                                                    similarModel[
                                                                        3],
                                                                overview:
                                                                    similarModel[
                                                                        4],
                                                              ),
                                                            );
                                                          },
                                                          child: Stack(
                                                            alignment:
                                                                Alignment.center,
                                                            children: [
                                                              Icon(
                                                                Icons.bookmark,
                                                                color: HomeCubit.get(
                                                                            context)
                                                                        .isSaved(
                                                                  WatchlistModel(
                                                                    id: similarModel[
                                                                        0],
                                                                    backdropPath:
                                                                        similarModel[
                                                                            1],
                                                                    originalTitle:
                                                                        similarModel[
                                                                            2],
                                                                    releaseDate:
                                                                        similarModel[
                                                                            3],
                                                                    overview:
                                                                        similarModel[
                                                                            4],
                                                                  ),
                                                                )
                                                                    ? AppColors
                                                                        .yellowColor
                                                                    : AppColors
                                                                        .lightGreyColor
                                                                        .withOpacity(
                                                                            0.9),
                                                                size: 40.sp,
                                                              ),
                                                              Icon(
                                                                HomeCubit.get(
                                                                            context)
                                                                        .isSaved(
                                                                  WatchlistModel(
                                                                    id: similarModel[
                                                                        0],
                                                                    backdropPath:
                                                                        similarModel[
                                                                            1],
                                                                    originalTitle:
                                                                        similarModel[
                                                                            2],
                                                                    releaseDate:
                                                                        similarModel[
                                                                            3],
                                                                    overview:
                                                                        similarModel[
                                                                            4],
                                                                  ),
                                                                )
                                                                    ? Icons.done
                                                                    : Icons.add,
                                                                color: AppColors
                                                                    .whiteColor
                                                                    .withOpacity(
                                                                        0.9),
                                                                size: 18.sp,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.all(5.r),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .lightGreyColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(5.r),
                                                        bottomRight:
                                                            Radius.circular(5.r),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color: AppColors
                                                                  .yellowColor,
                                                            ),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            Text(
                                                              Variables
                                                                  .newSimilarPagination[
                                                                      index]
                                                                  .voteAverage
                                                                  .toString()
                                                                  .substring(
                                                                      0, 3),
                                                              style: AppStyles
                                                                  .descriptionPoppins_10,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          Variables
                                                                  .newSimilarPagination[
                                                                      index]
                                                                  .originalTitle ??
                                                              "No Title",
                                                          style: AppStyles
                                                              .descriptionPoppins_10,
                                                        ),
                                                        Variables
                                                                    .newSimilarPagination[
                                                                        index]
                                                                    .releaseDate ==
                                                                ""
                                                            ? Text(
                                                                "No Date",
                                                                style: AppStyles
                                                                    .description_8,
                                                              )
                                                            : Text(
                                                                Variables
                                                                    .newSimilarPagination[
                                                                        index]
                                                                    .releaseDate
                                                                    .toString()
                                                                    .substring(
                                                                        0, 4),
                                                                style: AppStyles
                                                                    .description_8,
                                                              )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                        itemCount:
                                        Variables.newSimilarPagination.length),
                                  ),
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is HomeErrorState) {
            const Center(
              child: Text("Error"),
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
