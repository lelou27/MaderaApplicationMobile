import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madera_mobile/classes/Clients.dart';
import 'package:madera_mobile/components/DetailElement.dart';
import 'package:madera_mobile/components/MaderaAppBar.dart';
import 'package:path_provider/path_provider.dart';

import '../globals.dart' as globals;

class DetailClient extends StatefulWidget {
  final Client client;

  const DetailClient(this.client);

  @override
  _DetailClientState createState() => _DetailClientState();
}

class _DetailClientState extends State<DetailClient> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image = null;
  bool _isLoading = true;

  void initState() {
    super.initState();
    getImageByClient();
  }

  void pickImage(ImageSource imageSource) async {
    _image = (await _picker.pickImage(source: imageSource))!;
    setState(() {
      _image = _image;
    });

    sendImageApi();
  }

  Future<void> getImageByClient() async {
    Dio dio = new Dio();
    final directory = await getApplicationDocumentsDirectory();

    var response =
        await dio.get("${globals.apiUrl}/client-image/${widget.client.id}");

    if (response.data != null && response.data != "") {
      await dio.download(
          "${globals.apiUrl}/client-image/download/${widget.client.id}",
          "${directory.path}/assets/imgs/${widget.client.id}.jpg");

      setState(() {
        _image = XFile("${directory.path}/assets/imgs/${widget.client.id}.jpg");
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> sendImageApi() async {
    Dio dio = new Dio();

    var formData = FormData.fromMap({
      'idClient': widget.client.id,
      'image':
          await MultipartFile.fromFile(_image!.path, filename: 'upload.jpg')
    });

    await dio.post('${globals.apiUrl}/client-image/upload', data: formData);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SafeArea(
          child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    }

    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.black12),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    padding:
                        EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        _image == null
                            ? Container(
                                width: 190.0,
                                height: 190.0,
                                child: Image.asset("assets/imgs/default.jpg"),
                              )
                            : Container(
                                width: 190.0,
                                height: 190.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(
                                      File(_image!.path),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  this.pickImage(ImageSource.camera),
                              icon: Icon(Icons.camera),
                            ),
                            IconButton(
                              onPressed: () =>
                                  this.pickImage(ImageSource.gallery),
                              icon: Icon(Icons.image),
                            ),
                          ],
                        ),
                        Center(
                          child: Text(widget.client.first_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35)),
                        ),
                        Center(
                          child: Text(widget.client.mail,
                              style: TextStyle(
                                  height: 2,
                                  fontSize: 20,
                                  color: Colors.black38)),
                        ),
                        Center(
                          child: Text(widget.client.phone,
                              style: TextStyle(
                                  height: 2,
                                  fontSize: 20,
                                  color: Colors.black38)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        DetailElement(
                            title: 'Adresse', data: widget.client.address),
                        DetailElement(
                            title: 'Code postal',
                            data: widget.client.postal_code),
                        DetailElement(title: 'Ville', data: widget.client.city),
                        DetailElement(
                            title: 'Pays', data: widget.client.country),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
