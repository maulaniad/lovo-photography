import 'package:flutter/material.dart';
import 'package:lovo_photography/screens/preview_page.dart';

class ClickableImageBox extends StatelessWidget {
  const ClickableImageBox({
    required this.imageTitle,
    required this.imageUrl,
    required this.selectedHandler,
    Key? key
  }) : super(key: key);

  final String imageTitle;
  final String imageUrl;
  final ValueChanged<bool> selectedHandler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PreviewPage.routeName,
          arguments: imageUrl,
        );
      },
      onLongPress: () {
        selectedHandler(true);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              width: double.maxFinite,
              height: 90,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              image: NetworkImage(imageUrl),
            ),
            Text(imageTitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ],
        ),
      ),
    );
  }
}
