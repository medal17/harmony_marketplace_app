
/*import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
final picker = ImagePicker();
Future chooseFile() async{
  final pickedFile = picker.getImage(source: ImageSource.gallery).then((image) {
  setState((){
   _image = image;
  });
});
}


Future<File> pickImage({ImageSource source, 
double maxWidth, double maxHeight, 
int imageQuality, 
CameraDevice preferredCameraDevice = CameraDevice.rear}){
  source = ImageSource.gallery;
  maxWidth = 80;
  maxHeight = 60;
  return ;
}

Future uploadFile() async{
    StorageReference storageReference = FirebaseStorage.instance.ref()
    .child('products/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask =storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Upload Successful');
    storageReference.getDownloadURL().then((fileURL){
      setState((){
        _uploadedFileURL = fileURL;
      });
    });
}*/