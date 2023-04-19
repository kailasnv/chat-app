part of 'search_bloc.dart';

class SearchState {
  final bool isLoading;
  final List<Map<String, dynamic>>? otherUsersList;
  SearchState({
    required this.isLoading,
    this.otherUsersList,
  });
}

class SearchInitial extends SearchState {
  SearchInitial({required super.isLoading});
}
