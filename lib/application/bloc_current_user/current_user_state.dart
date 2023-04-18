part of 'current_user_bloc.dart';

class CurrentUserState {
  final bool isLoading;
  final UserModal? userData;

  CurrentUserState({
    required this.isLoading,
    this.userData,
  });
}

class CurrentUserInitial extends CurrentUserState {
  CurrentUserInitial({required super.isLoading});
}
