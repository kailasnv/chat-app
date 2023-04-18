part of 'search_bloc.dart';

class SearchState {
  final bool isLoading;
  final List<Map<String, dynamic>>? usersList;
  SearchState({
    required this.isLoading,
    this.usersList,
  });
}

class SearchInitial extends SearchState {
  SearchInitial({required super.isLoading});
}
