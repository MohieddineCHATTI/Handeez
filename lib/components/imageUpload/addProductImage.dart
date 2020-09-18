import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:handeez/components/imageUpload/uploader.dart';

class AddImage extends StatefulWidget {
  final Function(int, String) setImageUrl;
  AddImage({this.setImageUrl});

  @override
  AddImageState createState() => AddImageState();
}

class AddImageState extends State<AddImage> {
  PickedFile _imageFile1;
  PickedFile _imageFile2;
  PickedFile _imageFile3;
  String _url1;
  String _url2;
  String _url3;


  Future<void> _pickImage(ImageSource source, i) async {
    PickedFile selected = await ImagePicker().getImage(source: source);
    switch (i) {
      case 1:
        setState(() {
          _imageFile1 = selected;
        });
        break;
      case 2:
        setState(() {
          _imageFile2 = selected;
        });
        break;
      case 3:
        setState(() {
          _imageFile3 = selected;
        });
        break;
    }
  }

  void _clear(int i) {
    switch (i) {
      case 1:
        setState(() {
          _imageFile1 = null;
        });
        break;
      case 2:
        setState(() {
          _imageFile2 = null;
        });
        break;
      case 3:
        setState(() {
          _imageFile3 = null;
        });
        break;
    }
  }

  void setUrl(int i, String url) {
    print(i);
    switch (i) {
      case 1:
        setState(() {
          _url1 = url;
          widget.setImageUrl(1, url);
        });
        break;
      case 2:
        setState(() {
          _url2 = url;
          widget.setImageUrl(2, url);
        });
        break;
      case 3:
        setState(() {
          _url3 = url;
          widget.setImageUrl(3, url);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(children: <Widget>[
          Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        if (_imageFile1 != null) ...[
                          Image.file(
                            File(_imageFile1.path),
                            width: 100,
                            height: 100,
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _clear(1);
                            },
                          ),
                          Uploader(
                            num: 1,
                            file: File(_imageFile1.path),
                            setUrl: setUrl,
                          )
                        ]
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            _pickImage(ImageSource.camera, 1);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () {
                            _pickImage(ImageSource.gallery, 1);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        if (_imageFile2 != null) ...[
                          Image.file(File(_imageFile2.path),
                              width: 100, height: 100),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _clear(2);
                            },
                          ),
                          Uploader(
                              num: 2,
                              file: File(_imageFile2.path),
                              setUrl: setUrl)
                        ]
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            _pickImage(ImageSource.camera, 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () {
                            _pickImage(ImageSource.gallery, 2);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        if (_imageFile3 != null) ...[
                          Image.file(File(_imageFile3.path),
                              width:
                                  MediaQuery.of(context).size.width * .25,
                              height: 100),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _clear(3);
                            },
                          ),
                          Uploader(
                              num: 3,
                              file: File(_imageFile3.path),
                              setUrl: setUrl)
                        ]
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            _pickImage(ImageSource.camera, 3);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () {
                            _pickImage(ImageSource.gallery, 3);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton.icon(
                onPressed: () async {

                },
                icon: Icon(Icons.add),
                label: Text('add'))
          ],
        ),
          ),
        ]));
  }
}
