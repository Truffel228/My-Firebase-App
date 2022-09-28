import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DisconnectedScreen extends StatelessWidget {
  const DisconnectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.faceSadTear,
              size: MediaQuery.of(context).size.width * 0.4,
            ),
            const SizedBox(),
            Text(
              'No internet connection',
              style: theme.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
