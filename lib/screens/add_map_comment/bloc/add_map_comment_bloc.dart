import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/add_map_comment/add_map_comment_screen.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
    on<AddMapCommentAttachmentDelete>(_onAddMapCommentAttachmentDelete);
    on<AddMapCommentSaveEvent>(_onAddMapCommentSaveEvent);
  }

  final DatabaseServiceInterface _databaseService;
  final ImagePickerService _imagePickerService;

  FutureOr<void> _onAddMapCommentFileFromCamera(
    AddMapCommentFileFromCamera event,
    Emitter<AddMapCommentState> emit,
  ) async {
    XFile? xFile;
    if (event.fileType == FileType.image) {
      xFile = await _imagePickerService.takePhoto();
    } else {
      xFile = await _imagePickerService.recordVideo();
    }

    if (xFile == null) {
      return;
    }

    final file = File(xFile.path);

    final List<Attachment> newAttachments = List.from(state.attachments);
    final Attachment newAttachment;

    if (event.fileType == FileType.image) {
      newAttachment = Attachment(file, event.fileType);
    } else {
      final videoInfo = await FlutterVideoInfo().getVideoInfo(file.path);
      final videoDurationDouble = videoInfo?.duration;
      final videoDurationInt = videoDurationDouble != null
          ? (videoDurationDouble / 1000).round()
          : null;

      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: file.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 125,
        quality: 100,
      );
      final thumbnailFile = thumbnailPath != null ? File(thumbnailPath) : null;

      newAttachment = Attachment(
        file,
        event.fileType,
        videoDurationSec: videoDurationInt,
        videoPreview: thumbnailFile,
      );
    }

    newAttachments.add(newAttachment);

    emit(
      state.addFileSuccess(),
    );
    emit(
      state.copyWith(
        attachments: newAttachments,
      ),
    );
  }

  FutureOr<void> _onAddMapCommentFileFromGallery(
    AddMapCommentFileFromGallery event,
    Emitter<AddMapCommentState> emit,
  ) async {
    XFile? xFile;
    if (event.fileType == FileType.image) {
      xFile = await _imagePickerService.pickGalleryImage();
    } else {
      xFile = await _imagePickerService.pickGalleryVideo();
    }

    if (xFile == null) {
      return;
    }
    final File file = File(xFile.path);

    final List<Attachment> newAttachments = List.from(state.attachments);
    final Attachment newAttachment;

    if (event.fileType == FileType.image) {
      newAttachment = Attachment(file, event.fileType);
    } else {
      final videoInfo = await FlutterVideoInfo().getVideoInfo(file.path);
      final videoDurationDouble = videoInfo?.duration;
      final videoDurationInt = videoDurationDouble != null
          ? (videoDurationDouble / 1000).round()
          : null;

      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: file.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 125,
        quality: 100,
      );
      final thumbnailFile = thumbnailPath != null ? File(thumbnailPath) : null;

      newAttachment = Attachment(
        file,
        event.fileType,
        videoDurationSec: videoDurationInt,
        videoPreview: thumbnailFile,
      );
    }

    newAttachments.add(newAttachment);

    emit(
      state.addFileSuccess(),
    );
    emit(
      state.copyWith(
        attachments: newAttachments,
      ),
    );
  }

  FutureOr<void> _onAddMapCommentAttachmentDelete(
    AddMapCommentAttachmentDelete event,
    Emitter<AddMapCommentState> emit,
  ) {
    final currentState = state;
    final List<Attachment> newAttachments = List.from(currentState.attachments);
    newAttachments.removeWhere((element) => element.file.path == event.path);
    emit(state.copyWith(attachments: newAttachments));
  }

  FutureOr<void> _onAddMapCommentSaveEvent(
    AddMapCommentSaveEvent event,
    Emitter<AddMapCommentState> emit,
  ) async {
    final files = state.attachments.map((e) => e.file).toList();

    try {

      final mapCommentData = MapCommentData(
        text: event.text,
        latitude: event.latitude,
        longitude: event.longitude,
        category: event.category,
      );

      //TODO: Сделать метод для сохранения коментария в бд
      await _databaseService.saveMapComment(
        mapCommentData: mapCommentData,
        userId: event.userId,
        files: files,
      );

      emit(state.success());
    } catch (e) {
      print(e);
    }
  }
}

class MapCommentData {
  const MapCommentData({
    required this.text,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  final String text;
  final Category category;
  final double latitude;
  final double longitude;
}
