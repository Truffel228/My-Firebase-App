import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/map/widgets/map_widget.dart';
import 'package:fire_base_app/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(MapLoadEvent());
    userId = context.read<AppUser?>()!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state is MapUpdateUserProfile) {
          context.read<ProfileBloc>().add(ProfileFetchEvent(userId));
        }
      },
      builder: (context, state) {
        if (state is MapLoading) {
          return const Center(
            child: LoadingWidget(),
          );
        }
        // if (state is MapCommentSaving) {
        //   return MapWidget(
        //     cameraPosition: state.cameraPosition,
        //     isCommentSaving: true,
        //     mapComments: state.mapComments,
        //     userPosition: state.userPosition,
        //   );
        // }
        if (state is MapLoaded) {
          print('MapLoaded');

          /// Когда прокидываем MapLoaded в очередной раз после того как изменилась
          /// позиция юзера должен же рисоваться новый виджет и его поля
          /// bool isCommentOpen = false;
          /// bool isCommentShowInner = false;
          /// должны обращаться в false всякий раз когда мы прокидываем MapLoaded стейт
          /// но поля почему то не обновляются и CommentForm остаётся постоянно открытой
          /// даже в процессе постройки нового MapWidget
          return MapWidget(
            cameraPosition: state.cameraPosition,
            isCommentSaving: state.isCommentSaving,
            mapComments: state.mapComments,
            userPosition: state.userPosition,
          );
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
