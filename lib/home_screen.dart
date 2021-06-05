import 'dart:io';

import 'package:flutter/material.dart';

import 'image_picker_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Center(
          child: _image == null
              ? Stack(
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundColor: const Color(0xFF778899),
                      ),
                    ),
                    Center(
                      child:  Image.asset("assets/photo_camera.png"),
                    ),
                  ],
                )
              : CircleAvatar(
                  radius: 80.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.file(_image),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
