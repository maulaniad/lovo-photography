import 'package:flutter/material.dart';
import 'package:lovo_photography/services/base_client.dart';
import 'package:lovo_photography/models/photo.dart';
import 'package:lovo_photography/widgets/clickable_image_box.dart';
import 'package:lovo_photography/widgets/selectable_image_box.dart';

class PhotoGridView extends StatefulWidget {
  const PhotoGridView({
    required this.listPhoto,
    required this.listSelectedPhoto,
    required this.addSelectedPhotoHandler,
    required this.removeSelectedPhotoHandler,
    required this.clearSelectedPhotoHandler,
    Key? key
  }) : super(key: key);

  final List<Photo> listPhoto;
  final List<Photo> listSelectedPhoto;
  final Function addSelectedPhotoHandler;
  final Function removeSelectedPhotoHandler;
  final Function clearSelectedPhotoHandler;

  @override
  State<PhotoGridView> createState() => _PhotoGridViewState();
}

class _PhotoGridViewState extends State<PhotoGridView> {
  bool isSelectableMode = false;
  int firstSelection = 0;

  void changeMode() {
    setState(() {
      isSelectableMode = !isSelectableMode;
    });
  }

  void changeFirstSelection(int index) {
    setState(() {
      firstSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemCount: widget.listPhoto.length,
      itemBuilder: (context, index) {
        return isSelectableMode
        ? WillPopScope(
          onWillPop: () async {
            widget.clearSelectedPhotoHandler();
            changeMode();

            return false;
          },
          child: SelectableImageBox(
            imageTitle: "IMG_${widget.listPhoto[index].idPhoto}.${widget.listPhoto[index].url?.split(".").last}",
            imageUrl: "${BaseClient.apiUrl}/${widget.listPhoto[index].url}",
            isSelected: index == firstSelection ? true : false,
            selectedHandler: (bool isSelected) {
              if (isSelected) {
                widget.addSelectedPhotoHandler(index);
              }
              else {
                widget.removeSelectedPhotoHandler(index);

                if (widget.listSelectedPhoto.isEmpty) {
                  changeMode();
                }
              }
            },
            key: Key(widget.listPhoto[index].idPhoto.toString()),
          ),
        )
        : ClickableImageBox(
          imageTitle: "IMG_${widget.listPhoto[index].idPhoto}.${widget.listPhoto[index].url?.split(".").last}",
          imageUrl: "${BaseClient.apiUrl}/${widget.listPhoto[index].url}",
          selectedHandler: (_) {
            widget.addSelectedPhotoHandler(index);
            changeMode();
            changeFirstSelection(index);
          },
        );
      }
    );
  }
}
