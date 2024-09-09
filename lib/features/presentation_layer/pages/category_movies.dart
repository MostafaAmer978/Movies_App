import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/reuseable_components/image_not_found.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/core/utiles/app_styles.dart';
import 'package:movies_app/core/utiles/constants.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/presentation_layer/cubits/browse_tab_cubit/browse_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/browse_tab_cubit/browse_state.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class CategoryMovies extends StatefulWidget {
  static const String routeName = "CategoryMovies";

  const CategoryMovies({super.key});

  @override
  State<CategoryMovies> createState() => _CategoryMoviesState();
}

class _CategoryMoviesState extends State<CategoryMovies> {
  ScrollController scrollControllerCategory = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollControllerCategory.addListener(() {
      if (Variables.categoryPage <= 500) {
        var scrollMax = scrollControllerCategory.position.maxScrollExtent;
        var scroll = scrollControllerCategory.offset;
        if (scroll == scrollMax) {
          BrowseCubit.get(context).getCategoryMovies(
              BrowseCubit.get(context).genres?[
                BrowseCubit.get(context).index ?? 0].id.toString() ?? "",++Variables.categoryPage);
        }
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerCategory.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseCubit, BrowseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.blackColor,
            title: Text(
                "${BrowseCubit.get(context).genres?[BrowseCubit.get(context).index ?? 0].name} Category",
                style: AppStyles.title_20),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Variables.categoryPage = 1;
                Variables.newCategoryPagination.clear();
                BrowseCubit.get(context).clickNavigator();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: ListView.separated(
                controller: scrollControllerCategory,
                separatorBuilder: (context, index) => Divider(
                      color: AppColors.dividerColor,
                      endIndent: 50,
                      indent: 50,
                      height: 50.h,
                    ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, MovieDetails.routeName,
                          arguments: Variables.newCategoryPagination[index]
                              .id
                              .toString());
                    },
                    child: Container(
                      height: 300.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.lightGreyColor,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: Variables.newCategoryPagination[index]
                                        .backdropPath ==
                                    null
                                ? Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.lightGreyColor,
                                            width: 2.w),),
                                    child: imageNotFound(double.infinity, 220),)
                                : Variables.newCategoryPagination[index]
                                            .backdropPath ==
                                        null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.lightGreyColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child:
                                            imageNotFound(double.infinity, 220),
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        width: double.infinity.w,
                                        height: 220.h,
                                        imageUrl:
                                            '${Constants.baseURLImage}${Variables.newCategoryPagination[index].backdropPath}',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              color: AppColors.whiteColor,
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  "${Variables.newCategoryPagination[index].title}",
                                  style: AppStyles.movieGenreTitle,
                                ),
                                Variables.newCategoryPagination[index]
                                            .releaseDate ==
                                        ""
                                    ? Text(
                                        "No Date",
                                        style: AppStyles.movieGenreTitle,
                                      )
                                    : Text(
                                        "${Variables.newCategoryPagination[index].releaseDate?.substring(0, 4)}",
                                        style: AppStyles.movieGenreTitle,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount:
                Variables.newCategoryPagination.length),
          ),
        );
      },
    );
  }
}
