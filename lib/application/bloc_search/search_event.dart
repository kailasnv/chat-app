part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchOtherUsersEvent extends SearchEvent {
  final String searchQuery;
  SearchOtherUsersEvent({required this.searchQuery});
}
