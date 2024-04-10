import 'dart:developer';

import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {


  Uint8List? _image;
  File? selectedIMage;
  @override
  TextEditingController textcontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  pickimage(ImageSource imageSource) async {
    final ImagePicker _imagepicker = ImagePicker();
    XFile? _file = await _imagepicker.pickImage(source: imageSource);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    log("No Image Selected");
  }

  selectimage() {

  }

  addData(String title, String desc, String url) {
    if (title == "" && desc == "") {
      log("Enter The data");
    }
    else {
      FirebaseFirestore.instance.collection("users").doc(title).set({
        "title": title,
        "Descriptiom": desc,
        "url":_image,
      }).then((value) {
        log("Data Uploaded");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello Jii'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textcontroller,
          ),
          SizedBox(height: 30,),
          TextField(
            controller: desccontroller,
          ),
          SizedBox(height: 30,),
          Row(
              children:
              [ElevatedButton(onPressed: () {
                _pickImageFromCamera();
              }, child: Text('Pick Image')),
                ElevatedButton(onPressed: () {
                  _pickImageFromCamera();
                }, child: Text('Pick Image')),
              ]


          ),
          ElevatedButton(onPressed: () {
            addData(
                textcontroller.text.toString(), desccontroller.text.toString(),
                desccontroller.text.toString());
          }, child: Text('Upload Data'),),

        ],
      ),
    );
  }


//Gallery


//Camera
  Future _pickImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(
        source: ImageSource.camera);
    print(returnImage);
  }
}