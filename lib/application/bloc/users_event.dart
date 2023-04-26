part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class LoadCurrentUser extends UsersEvent {}

class LoadOtherUsers extends UsersEvent {
  final String searchQuery;

  LoadOtherUsers({required this.searchQuery});
}

class UpdateProfilePhoto extends UsersEvent {
  final BuildContext context;
  UpdateProfilePhoto({required this.context});
}
