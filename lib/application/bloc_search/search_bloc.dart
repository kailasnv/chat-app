import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:chat_app/domain/repositories/search_user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(isLoading: false)) {
    // on search
    on<SearchOtherUsersEvent>((event, emit) async {
      emit(SearchState(isLoading: true, usersList: []));

      /* fetch users from firebase collection */

      final userList = await SearchUsersRepo.fetchNewFriends(event.searchQuery);

      emit(SearchState(isLoading: false, usersList: userList));
    });
  }
}
