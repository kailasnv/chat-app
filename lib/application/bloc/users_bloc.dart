// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:chat_app/domain/repositories/current_user_repo.dart';
import 'package:chat_app/domain/repositories/search_user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial(isLoading: false)) {
    // events
    on<LoadCurrentUser>((event, emit) async {
      if (state.currentUser == null) {
        emit(UsersState(isLoading: true));
        final _userModal = await CurrentUserRepo.getUserData();
        emit(UsersState(isLoading: false, currentUser: _userModal));
      }
    });

    // on search event
    on<LoadOtherUsers>((event, emit) async {
      User? _user = FirebaseAuth.instance.currentUser;
      if (_user != null) {
        emit(UsersState(isLoading: true));

        final friendList = await SearchUsersRepo.fetchNewFriends(
            event.searchQuery, _user.email!);

        emit(UsersState(isLoading: false, otherUsers: friendList));
      }
    });
  }
}
