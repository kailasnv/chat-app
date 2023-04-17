import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/modals/user_modal.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc() : super(CurrentUserInitial()) {
    on<CurrentUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
