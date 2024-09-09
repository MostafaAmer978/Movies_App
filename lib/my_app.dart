import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/data_layer/data_source/remote/home_remote_ds_impl.dart';
import 'package:movies_app/features/data_layer/repository/home_repository_impl.dart';
import 'package:movies_app/features/domain_layer/usecases/home_usecase.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_cubit.dart';
import 'package:movies_app/features/presentation_layer/pages/category_movies.dart';
import 'package:movies_app/features/presentation_layer/pages/home.dart';
import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocProvider(
        create: (context) => HomeCubit(
          homeUseCase: HomeUseCase(
            homeRepository: HomeRepositoryImpl(
              homeRemoteDS: HomeRemoteDsImpl(),
            ),
          ),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Home.routeName,
          routes: {
            Home.routeName: (context) => const Home(),
            MovieDetails.routeName: (context) => const MovieDetails(),
            CategoryMovies.routeName: (context) => const CategoryMovies(),
          },
        ),
      ),
    );
  }
}
