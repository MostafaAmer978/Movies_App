import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/data_layer/models/watchlist_model.dart';

class FirebaseFunctions {
  static List<String?> ids = [];
  // static bool isSaved = false;

  static CollectionReference<WatchlistModel> addCollection() {
    return FirebaseFirestore.instance
        .collection("MovieList")
        .withConverter<WatchlistModel>(
      fromFirestore: (snapshot, options) {
        return WatchlistModel.fromJson(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static void addAndDeleteMovie(WatchlistModel model) async {
    var collection = addCollection();
    var documentId = collection.doc(model.id);
    var isExistDocumentId = await documentId.get();
    if (isExistDocumentId.exists) {
      ids.remove(model.id);
      await documentId.delete();
    } else {
      ids.add(model.id);
      documentId.set(model);
    }
  }

  static Stream<QuerySnapshot<WatchlistModel>> getMoviesList() {
    return addCollection().snapshots();
  }

  static bool isSaved(String id) {
    if (ids.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

// static void deleteMovie(WatchlistModel model) {
//   var collection = addCollection();
//   var documentId = collection.doc(model.id);
//   documentId.delete();
// }
}
