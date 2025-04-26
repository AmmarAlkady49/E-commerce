import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  // final HomeCubit homeCubit;
  SearchCubit() : super(SearchInitial());

  // List<String> reacentSearches = [];
  // List<ProductResponse> searchResults = [];
  // final HomePageServices homePageServices = HomePageServicesImpl();

  // Future<void> searchProducts(String query) async {
  //   emit(SearchLoading());
  //   try {
  //     final allProducts = await homePageServices.getAllProducts();
  //     searchResults = allProducts
  //         .where((product) =>
  //             product.name!.toLowerCase().contains(query.trim().toLowerCase()))
  //         .toList();

  //     addToRecentSearches(query); // 👈 Add this line
  //     emit(SearchLoaded(searchResults));
  //   } catch (e) {
  //     emit(SearchError("Something went wrong: ${e.toString()}"));
  //   }
  // }

  // void addToRecentSearches(String query) {
  //   if (query.trim().isEmpty) return;
  //   reacentSearches.remove(query); // Remove duplicates
  //   reacentSearches.insert(0, query); // Add to top
  //   if (reacentSearches.length > 10) {
  //     reacentSearches = reacentSearches.sublist(0, 10); // Limit to 10
  //   }
  //   emit(SearchRecentUpdated(reacentSearches));
  // }

  // void clearRecentSearches() {
  //   reacentSearches.clear();
  //   emit(SearchRecentUpdated(reacentSearches));
  // }
}
