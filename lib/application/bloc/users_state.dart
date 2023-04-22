part of 'users_bloc.dart';

class UsersState {
  final bool isLoading;
  final UserModal? currentUser;
  final List<Map<String, dynamic>>? otherUsers;

  UsersState({
    required this.isLoading,
    this.currentUser,
    this.otherUsers,
  });
}

class UsersInitial extends UsersState {
  UsersInitial({required super.isLoading});
}
