import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/screens/add_map_comment/add_map_comment_screen.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:meta/meta.dart';

part 'add_map_comment_event.dart';
part 'add_map_comment_state.dart';

class AddMapCommentBloc extends Bloc<AddMapCommentEvent, AddMapCommentState> {
  AddMapCommentBloc({
    required DatabaseServiceInterface databaseService,
    required ImagePickerService imagePickerService,
  })  : _databaseService = databaseService,
        _imagePickerService = imagePickerService,
        super(const AddMapCommentState()) {
    on<AddMapCommentFileFromCamera>(_onAddMapCommentFileFromCamera);
    on<AddMapCommentFileFromGallery>(_onAddMapCommentFileFromGallery);
  }

  final DatabaseServiceInterface _databaseService;
  final ImagePickerService _imagePickerService;

  FutureOr<void> _onAddMapCommentFileFromCamera(
    AddMapCommentFileFromCamera event,
    Emitter<AddMapCommentState> emit,
  ) {
    
  }

  FutureOr<void> _onAddMapCommentFileFromGallery(
    AddMapCommentFileFromGallery event,
    Emitter<AddMapCommentState> emi,
  ) {}
}
