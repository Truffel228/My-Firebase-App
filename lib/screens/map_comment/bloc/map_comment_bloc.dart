import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/file_helper/file_helper_service_interface.dart';
import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'map_comment_event.dart';
part 'map_comment_state.dart';

class MapCommentBloc extends Bloc<MapCommentEvent, MapCommentState> {
  MapCommentBloc({
    required DatabaseServiceInterface databaseService,
    required FileHelperServiceInterface fileHelper,
  })  : _databaseService = databaseService,
        _fileHelper = fileHelper,
        super(MapCommentLoading()) {
    on<MapCommentLoad>(_onMapCommentScreenLoadEvent);
  }

  final FileHelperServiceInterface _fileHelper;
  final DatabaseServiceInterface _databaseService;

  void _onMapCommentScreenLoadEvent(MapCommentLoad event, emit) async {
    emit(MapCommentLoading());

    final flutterVideoInfo = FlutterVideoInfo();

    try {
      final userData = await _databaseService.getUserData(event.userId);
      final mapComment =
          await _databaseService.getMapComment(event.mapCommentId);

      final images = mapComment.files
          .where((e) => e.fileType == FileType.image)
          .map((e) => MediaAttachment(e.fileUrl, e.fileType))
          .toList();
      emit(
        MapCommentLoaded(
          mapComment: mapComment,
          userData: userData,
          images: [],
          videos: [],
          mediaAttachmentLoading: true,
        ),
      );

      final List<MediaAttachment> videos = [];
      final videoFiles =
          mapComment.files.where((e) => e.fileType == FileType.video).toList();

      for (var video in videoFiles) {
        final videoUrl = video.fileUrl;

        final videoFile = await _fileHelper.getFileFromUrl(videoUrl);

        final videoInfo = await flutterVideoInfo.getVideoInfo(videoFile.path);
        final videoDurationDouble = videoInfo?.duration;
        final videoDurationInt = videoDurationDouble != null
            ? (videoDurationDouble / 1000).round()
            : null;

        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          //Not working with videoFile.path
          video: videoUrl,
          imageFormat: ImageFormat.JPEG,
          maxWidth: 125,
          quality: 100,
        );
        final videoThumbnail =
            thumbnailPath != null ? File(thumbnailPath) : null;

        final videoMediaAttachment = MediaAttachment(
          videoUrl,
          video.fileType,
          videoDurationSec: videoDurationInt,
          videoPreview: videoThumbnail,
        );

        videos.add(videoMediaAttachment);
      }

      emit(
        MapCommentLoaded(
          mapComment: mapComment,
          userData: userData,
          images: images,
          videos: videos,
          mediaAttachmentLoading: false,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
