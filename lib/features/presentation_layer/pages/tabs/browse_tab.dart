import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/core/utiles/app_styles.dart';
import 'package:movies_app/core/utiles/variables.dart';
import 'package:movies_app/features/data_layer/data_source/remote/browse_Remote_ds_impl.dart';
import 'package:movies_app/features/data_layer/repository/browse_repository_impl.dart';
import 'package:movies_app/features/domain_layer/usecases/browse_usecase.dart';
import 'package:movies_app/features/presentation_layer/cubits/browse_tab_cubit/browse_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/browse_tab_cubit/browse_state.dart';
import 'package:movies_app/features/presentation_layer/pages/category_movies.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BrowseCubit>(
      create: (context) => BrowseCubit(
        browseUseCase: BrowseUseCase(
          browseRepository: BrowseRepositoryImpl(
            browseRemoteDS: BrowseRemoteDSImpl(),
          ),
        ),
      )..getMovieListGenres(),
      child: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          if (state is BrowseSuccessState || state is BrowseNavigatorState) {
            return BrowseCubit.get(context).navigator == false
                ? Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Browse Category",
                          style: AppStyles.title_22,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 30,
                                    crossAxisSpacing: 40),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  BrowseCubit.get(context).clickNavigator();
                                  BrowseCubit.get(context).index = index;
                                  BrowseCubit.get(context).getCategoryMovies(
                                      BrowseCubit.get(context).genres?[BrowseCubit.get(context).index ?? 0].id.toString() ??
                                          "",Variables.categoryPage);
                                },
                                child: Container(
                                  width: 158.w,
                                  height: 90.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(image: AssetImage("assets/images/category.jpg"),fit: BoxFit.fill),
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r),color: AppColors.blackColor),
                                    child: Text(
                                      "${BrowseCubit.get(context).genres?[index].name}",
                                      style: AppStyles.movieGenreTitle,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: BrowseCubit.get(context).genres?.length,
                          ),
                        ),
                      ],
                    ),
                  )
                : const CategoryMovies();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
