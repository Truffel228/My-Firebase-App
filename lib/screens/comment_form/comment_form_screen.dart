import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CommentFormScreen extends StatelessWidget {
  CommentFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 0,
                ),
                const AppTextField(
                  minLines: 2,
                  maxLines: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      AppButton(
                        color: Colors.red,
                        child: Text('Cancel'),
                      ),
                      AppButton(
                        color: Colors.green,
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
