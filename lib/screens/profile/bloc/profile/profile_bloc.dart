import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseServiceInterface _databaseService;
  ProfileBloc({required databaseService})
      : _databaseService = databaseService,
        super(const ProfileLoading()) {
    on<ProfileFetchEvent>(_onProfileFetchEvent);
    on<ProfileSaveEvent>(_onProfileSaveEvent);
    on<ProfileDeleteCommentEvent>(_onProfileSaveAfterDeleteCommentEvent);
  }
  void _onProfileFetchEvent(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) {
      emit(const ProfileLoading());
    }

    final userData = await _databaseService.getUserData(event.uuid);
    emit(ProfileLoaded(userData: userData));
  }

  void _onProfileSaveEvent(
      ProfileSaveEvent event, Emitter<ProfileState> emit) async {
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
            userId: event.userId, userData: event.userData);
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

  void _onProfileSaveAfterDeleteCommentEvent(
      ProfileDeleteCommentEvent event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) {
      return;
    }
    try {
      final newCommentList = currentState.userData.mapComments
        ..removeWhere((element) => element.id == event.deletedCommentId);
      final newUserData =
          currentState.userData.copyWith(mapComments: newCommentList);

      emit(
        ProfileSaving(userData: newUserData),
      );
      await _databaseService.deleteMapComment(
        event.userId,
        event.deletedCommentId,
      );
      emit(ProfileCommentDeleteSuccess());
      emit(ProfileLoaded(userData: newUserData));
      print('dfafadf');
    } catch (e) {}
  }
}
