part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchOtherUsersEvent extends SearchEvent {
  final TextEditingController searchController;
  SearchOtherUsersEvent({required this.searchController});
}
