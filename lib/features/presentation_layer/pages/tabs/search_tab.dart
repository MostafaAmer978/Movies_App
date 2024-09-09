import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/reuseable_components/image_not_found.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/core/utiles/app_styles.dart';
import 'package:movies_app/core/utiles/constants.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/data_source/remote/search_remote_ds_impl.dart';
import 'package:movies_app/features/data_layer/repository/search_repository_impl.dart';
import 'package:movies_app/features/domain_layer/usecases/search_usecase.dart';
import 'package:movies_app/features/presentation_layer/cubits/search_tab_cubit/search_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/search_tab_cubit/search_state.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class SearchTab extends StatelessWidget {
  SearchTab({super.key});

  var searchMovie = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        searchUseCase: SearchUseCase(
          searchRepository: SearchRepositoryImpl(
            searchRemoteDS: SearchRemoteDsImpl(),
          ),
        ),
      ),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  onChanged: (value) {
                    searchMovie = value;
                    searchMovie == "" ?
                      Variables.searchPage = 1 :
                    SearchCubit.get(context).getSearch(searchMovie, Variables.searchPage);
                  },
                  cursorColor: AppColors.cursorColor,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColors.lightGreyColor,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.whiteColor,
                      size: 20,
                    ),
                    hintText: "Search",
                    hintStyle: AppStyles.title_15,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: AppColors.whiteColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                searchMovie == ""
                    ? Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_movies,
                                size: 160.sp,
                                color: AppColors.lightWhiteColor,
                              ),
                              Text(
                                "No movies found",
                                style: AppStyles.title_15,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: NotificationListener(
                          onNotification:
                              (notification) {
                            if (notification is ScrollEndNotification) {
                              if (Variables.isEndSearch == false) {
                                var scroll = notification.metrics.pixels;
                                var scrollMax =
                                    notification.metrics.maxScrollExtent;
                                if (scroll == scrollMax) {
                                  SearchCubit.get(context).getSearch(
                                      searchMovie, ++Variables.searchPage);
                                }
                              }
                            }
                            return true;
                          },
                          child: ListView.separated(
                            // controller: scrollControllerSearch,
                            itemCount: Variables.newSearchPagination.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => const Divider(
                              color: AppColors.dividerColor,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MovieDetails.routeName,
                                      arguments: Variables
                                          .newSearchPagination[index].id
                                          .toString());
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  margin: EdgeInsets.symmetric(vertical: 12.h),
                                  height: 90.h,
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        child: Variables
                                                    .newSearchPagination[index]
                                                    .backdropPath ==
                                                null
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: AppColors
                                                          .lightGreyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: imageNotFound(
                                                    140, double.infinity),
                                              )
                                            : CachedNetworkImage(
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        Center(
                                                          child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                        ),
                                                fit: BoxFit.fill,
                                                width: 140.w,
                                                height: double.infinity.h,
                                                imageUrl:
                                                    '${Constants.baseURLImage}${Variables.newSearchPagination[index].backdropPath}'),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Variables
                                                      .newSearchPagination[
                                                          index]
                                                      .originalTitle ??
                                                  "No Title",
                                              style: AppStyles.title_15,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Variables.newSearchPagination[index]
                                                        .releaseDate ==
                                                    ""
                                                ? Text(
                                                    "No Date",
                                                    style: AppStyles
                                                        .description_13,
                                                  )
                                                : Text(
                                                    Variables
                                                        .newSearchPagination[
                                                            index]
                                                        .releaseDate!
                                                        .substring(0, 4),
                                                    style: AppStyles
                                                        .description_13,
                                                  ),
                                            Text(
                                              Variables
                                                      .newSearchPagination[
                                                          index]
                                                      .overview ??
                                                  "No Title",
                                              style: AppStyles.description_13,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
