import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Uploader extends StatefulWidget {

  final File file;
  final int num ;
  final Function(int , String) setUrl;
  Uploader({Key key, this.file, this.setUrl, this.num}): super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://handeez.appspot.com");
  StorageUploadTask _uploadTask;
  dynamic imageUrl;
  Future _startUpload () async{
    String filePath = "images/${DateTime.now()}.png";
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
    StorageTaskSnapshot storageOnComplete = await _uploadTask.onComplete;
    dynamic url = await storageOnComplete.ref.getDownloadURL();
    setState(()  {
      imageUrl = url;
    });
    widget.setUrl(widget.num, url);
    print(url);

  }
  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot){
          var event = snapshot?.data?.snapshot;
          double progressPercent = event != null
              ? event.bytesTransferred / event.totalByteCount : 0;
          return Column (
            children: <Widget>[
              if(_uploadTask.isComplete) Text(" done !!"),
              if(_uploadTask.isInProgress) FlatButton(child: Icon(Icons.pause),onPressed: (){ _uploadTask.pause();},),
              if(_uploadTask.isPaused) FlatButton(child: Icon(Icons.play_arrow),onPressed: (){ _uploadTask.resume();},),
              Container(child: LinearProgressIndicator(value: progressPercent), width: MediaQuery.of(context).size.width*.25,),
              Text("${(progressPercent*100).toStringAsFixed(2)} % "),
              FlatButton(child: Text("click me"),onPressed: (){widget.setUrl(widget.num, imageUrl);},),


            ],
          );
        },
      );
    }else{
      return Column(
        children: <Widget>[
          FlatButton.icon(onPressed: _startUpload, icon: Icon(Icons.cloud_upload), label: Text("Upload")),
        ],
      );
    }
  }
}
