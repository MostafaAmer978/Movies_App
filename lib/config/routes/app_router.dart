// import 'package:flutter/material.dart';
// import 'package:movies_app/features/presentation_layer/pages/home.dart';
// import 'package:movies_app/features/presentation_layer/pages/movie_details.dart';
// import 'package:movies_app/features/presentation_layer/pages/tabs/browse_tab.dart';
// import 'package:movies_app/features/presentation_layer/pages/tabs/home_tab.dart';
// import 'package:movies_app/features/presentation_layer/pages/tabs/search_tab.dart';
// import 'package:movies_app/features/presentation_layer/pages/tabs/watchlist_tab.dart';
//
// class RoutesName {
//   static const String home = "home";
//   static const String homeTab = "homeTab"; //   "/" is stands for Start Page
//   static const String searchTab = "searchTab";
//   static const String browseTab = "browseTab";
//   static const String watchlistTab = "watchlistTab";
//   static const String movieDetails = "movieDetails";
// }
//
// class AppRoutes {
//   static Route<dynamic> onGenerate(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutesName.homeTab:
//         return MaterialPageRoute(
//           builder: (context) => const HomeTab(),
//         );
//       case RoutesName.searchTab:
//         return MaterialPageRoute(
//           builder: (context) => const SearchTab(),
//         );
//       case RoutesName.browseTab:
//         return MaterialPageRoute(
//           builder: (context) => const BrowseTab(),
//         );
//       case RoutesName.watchlistTab:
//         return MaterialPageRoute(
//           builder: (context) => const WatchlistTab(),
//         );
//       case RoutesName.movieDetails:
//         return MaterialPageRoute(
//           builder: (context) => const MovieDetails(),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (context) => Home(),
//         );
//     }
//   }
// }
