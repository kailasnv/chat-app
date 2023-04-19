import 'package:bloc/bloc.dart';
import 'package:chat_app/application/bloc_current_user/current_user_bloc.dart';
import 'package:chat_app/domain/repositories/search_user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(isLoading: false)) {
    // on search
    on<SearchOtherUsersEvent>((event, emit) async {
      emit(SearchState(isLoading: true, otherUsersList: []));

      /* fetch users from firebase collection */
      final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
      final userList = await SearchUsersRepo.fetchNewFriends(
          event.searchController, currentUserEmail!);

      emit(SearchState(isLoading: false, otherUsersList: userList));
    });
  }
}
