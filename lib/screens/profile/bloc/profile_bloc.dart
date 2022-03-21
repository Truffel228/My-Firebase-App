import 'package:bloc/bloc.dart';
import 'package:fire_base_app/models/user_data/user_data.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileFetchEvent>(_onProfileFetchEvent);
    on<ProfileSaveEvent>(_onProfileSaveEvent);
  }
  void _onProfileFetchEvent(event, emit) async {
    final userData =

        ///Dependencies injection in bloc
        await locator.get<DatabaseService>().getUserData(event.uid);
    //TODO: For testing
    await Future.delayed(
      Duration(seconds: 1),
    );
    emit(ProfileLoaded(userData: userData));
  }

  void _onProfileSaveEvent(event, emit) async {
    final state = this.state;
    if (state is ProfileLoaded) {
      var userData = state.userData;
      try {
        print('ProfileSaving');
        emit(ProfileSaving(userData: event.userData));
        //TODO: For testing
        await Future.delayed(
          Duration(seconds: 1),
        );
        await locator
            .get<DatabaseService>()
            .updateUserData(uid: event.uid, userData: event.userData);
        emit(
          ProfileLoaded(
              userData: event.userData, message: 'Your data has been saved'),
        );
      } catch (e) {
        emit(
          ProfileError(userData: userData, message: 'Couldn\'t save your data'),
        );
        emit(
          ProfileLoaded(userData: state.userData),
        );
      }
    }
  }
}
