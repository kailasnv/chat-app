// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:chat_app/domain/repositories/current_user_repo.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitial(isLoading: false)) {
    //
    on<GetCurrentUserDataEvent>((event, emit) async {
      emit(CurrentUserState(isLoading: true));
      final _userData = await CurrentUserRepo.getUserData();

      emit(CurrentUserState(isLoading: false, userData: _userData));
    });
  }
}
