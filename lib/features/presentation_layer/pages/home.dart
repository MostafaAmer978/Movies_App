import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utiles/app_colors.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_cubit.dart';
import 'package:movies_app/features/presentation_layer/cubits/home_tab_cubit/home_state.dart';

class Home extends StatelessWidget {
  static const String routeName = "Home";

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.homeColor,

              /// BottomNavigationBar
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: AppColors.whiteColor,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      blurStyle: BlurStyle.inner)
                ]),
                child: BottomNavigationBar(
                    onTap: (value) {
                      HomeCubit.get(context).selectedIndexTab(value);
                    },
                    currentIndex: HomeCubit.get(context).index,
                    elevation: 0,
                    backgroundColor: AppColors.homeColor,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: AppColors.selectedItemColor,
                    unselectedItemColor: AppColors.whiteColor,
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset("assets/images/ic_home_unselect.png"),
                        label: "home",
                        activeIcon:
                        Image.asset("assets/images/ic_home_select.png"),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset("assets/images/ic_search_unselect.png"),
                        label: "search",
                        activeIcon:
                        Image.asset("assets/images/ic_search_select.png"),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset("assets/images/ic_browse_unselect.png"),
                        label: "browse",
                        activeIcon:
                        Image.asset("assets/images/ic_browse_select.png"),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                            "assets/images/ic_watchlist_unselect.png"),
                        label: "watchlist",
                        activeIcon:
                        Image.asset("assets/images/ic_watchlist_select.png"),
                      ),
                    ]),
              ),

              /// Body
              body: HomeCubit.get(context).tabs[HomeCubit.get(context).index]),
        );
      },
    );
  }
}
