import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {

  final Function onImageSelect;
  ImageInput(this.onImageSelect);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File _fileSrc;

  Future<void> takeImage() async{
    var picker = ImagePicker();
    final imageFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 600, maxHeight: 600);

    if(imageFile == null){
      return;
    }
    setState(() {
      _fileSrc = File(imageFile.path);
    });

    final dir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile.path);
    final savedImage = await _fileSrc.copy('${dir.path}/$filename');

    widget.onImageSelect(savedImage);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 100,
          width:100,
          alignment: Alignment.center,
          child: _fileSrc != null
              ? Image.file(_fileSrc, fit: BoxFit.fill,)
              : Text(
                  'Add an image',
                  textAlign: TextAlign.center,
                ),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        ),
        SizedBox(width: 20),
        RaisedButton.icon(
          color: Colors.blueAccent,
          onPressed: takeImage,
          icon: Icon(
            Icons.camera,
            color: Colors.white,
          ),
          label: Text('Pick Image',style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}