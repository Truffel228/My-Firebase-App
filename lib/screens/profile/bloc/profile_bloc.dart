import 'package:bloc/bloc.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseServiceInterface _databaseService;
  ProfileBloc({required databaseService})
      : _databaseService = databaseService,
        super(ProfileLoading()) {
    on<ProfileFetchEvent>(_onProfileFetchEvent);
    on<ProfileSaveEvent>(_onProfileSaveEvent);
  }
  void _onProfileFetchEvent(ProfileFetchEvent event, emit) async {
    final userData = await _databaseService.getUserData(event.uuid);
    //TODO: For testing
    await Future.delayed(
      Duration(seconds: 1),
    );
    emit(ProfileLoaded(userData: userData));
  }

  void _onProfileSaveEvent(ProfileSaveEvent event, emit) async {
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
        await _databaseService.updateUserData(
            uid: event.uuid, userData: event.userData);
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
