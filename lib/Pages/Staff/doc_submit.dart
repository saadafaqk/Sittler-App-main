import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sittler_app/Pages/Staff/approval.dart';
import 'package:sittler_app/Widgets/button_widget.dart';
import 'package:sittler_app/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';



class docupload extends StatefulWidget {
  const docupload({ Key? key }) : super(key: key);

  @override
  State<docupload> createState() => _docuploadState();
  
}

class _docuploadState extends State<docupload> {
  
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    
    return Scaffold(
      appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff004aa0),
            elevation: 0,
          ),
          
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              const SizedBox(height: 8),
               Text(
                fileName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              const SizedBox(height: 25),
              
              task != null ? buildUploadStatus(task!) : Container(),

              const SizedBox(height: 20),
              ButtonWidget(
                text: 'Continue',
                icon: Icons.cloud_upload_outlined,
                onClicked: () { 
                  CircularPercentIndicator(
                    radius: 20,

                  );
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const splash()));
                },
              ),
              
            ],
          ),
          
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    
    print('Download-Link: $urlDownload');
    
    
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
    
          } else {
            return Container();
          }

    
        },

        
      );
  }


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
}