
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool editShow;
  const AvatarWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.editShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          editShow ? Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ) : Positioned(
            bottom: 0,
            right: 4,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = AssetImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}