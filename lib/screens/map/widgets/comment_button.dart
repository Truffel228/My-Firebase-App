import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentButton extends StatefulWidget {
  const CommentButton({Key? key}) : super(key: key);

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: Container(
          width: 170,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.comment,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                'Leave a comment',
                style: theme.textTheme.bodyText1!
                    .copyWith(color: theme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
