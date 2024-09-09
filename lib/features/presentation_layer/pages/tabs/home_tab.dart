import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_state.dart';
import 'package:movies_app/features/presentation_layer/widgets/new_releases.dart';
import 'package:movies_app/features/presentation_layer/widgets/popular.dart';
import 'package:movies_app/features/presentation_layer/widgets/recommeded.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeErrorState) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("try Again")),
              ],
            ),
          );
        }
        return const SingleChildScrollView(
          child: Column(
            children: [
              PopularMovies(),
              NewReleasesMovies(),
              RecommendedMovies(),
            ],
          ),
        );
      },
    );
  }
}
