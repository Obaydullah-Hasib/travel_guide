import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';

class imagePickerClass extends StatefulWidget {
  const imagePickerClass({Key? key}) : super(key: key);

  @override
  _imagePickerClassState createState() => _imagePickerClassState();
}

class _imagePickerClassState extends State<imagePickerClass> {
  ImagePicker image = ImagePicker();
  File? file;
  String url = "";
Future CameraImage() async{
  var img = await  image.pickImage(source: ImageSource.camera);
  setState(() {

    file = File(img!.path);
  });
}
  Future GalleryImage() async{
    var img = await  image.pickImage(source: ImageSource.gallery);
    setState(() {

      file = File(img!.path);
    });
  }

  Future UploadImage() async{
   String imageName = DateTime.now().microsecondsSinceEpoch.toString();
   String id = imageName;
   var imageFile = FirebaseStorage.instance.ref().child(imageName).child("$imageName");
   UploadTask task = imageFile.putFile(file!);
   TaskSnapshot snapshot = await task;
   //for download image
    url = await snapshot.ref.getDownloadURL();
   ////store the image url into the fireshore database
    await FirebaseFirestore.instance.collection("images").doc(id).set({"img":url});
    print(url);
  }
  Future<void> deleteImage(String id,BuildContext context)async{
    await FirebaseFirestore.instance.collection('images').doc(id).delete().then((value) {
      FirebaseStorage.instance.ref().child('imageName').child(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Delete Successfully',
          )));
      // Navigator.pop(context);
    },onError: (error){
      Navigator.pop(context);
    });
  }
  Future <void> UpdateImg(String id) async {
    var imagefile = FirebaseStorage.instance.ref().child('imageName').child(id);
    TaskSnapshot snapshot = await imagefile.putFile(file!);
    /// for download the image
    url = await snapshot.ref.getDownloadURL();
    /// store the image url into the firestore database
    await FirebaseFirestore.instance
        .collection("images")
        .doc(id)
        .set({"img": url});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Successfully Updated',
        )));
    // print(url);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, 'Pick Images'),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: file == null
                    ? AssetImage("assets/images/Obaidul-Quader.jpg")
                    : FileImage(File(file!.path)) as ImageProvider,
              ),
            ),
            // ClipRRect(
            //   child: file == null ? Image.asset("assets/images/Obaidul-Quader.jpg"):
            //   ,
            // )
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      GalleryImage();
                    },
                    child: Text("Gallery"),
                  ),
                  SizedBox(width: 5.0,),
                  ElevatedButton(
                    onPressed: () {
                      CameraImage();
                    },
                    child: Text("Camera"),
                  ),
                  SizedBox(width: 5.0,),
                  ElevatedButton(
                    onPressed: () {
                      UploadImage();
                    },
                    child: Text("Upload Image"),
                  ),
                  SizedBox(width: 5.0,),

                ],
              ),
            ),
            SizedBox( height: 5,),
            ///show the image into the app
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("images").snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                if(snapshot.hasData){
              return GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  QueryDocumentSnapshot querysnapshot = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  View(
                                    url: querysnapshot['img'],
                                  )));
                    }
                    ,
                    child: Hero(
                      tag: querysnapshot['img'],
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(querysnapshot['img'],fit: BoxFit.fill,height: 200,),
                            Row(
                              children: [
                                RaisedButton(onPressed: ()async{
                                  await deleteImage(querysnapshot.id, context);
                                },child: Text('Delete'),),
                                RaisedButton(onPressed: ()async{
                                  await UpdateImg(querysnapshot.id);
                                },child: Text('Update'),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
                }
                return Center(child: CircularProgressIndicator());
              },
            )

          ],
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  final url;

  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: url, child: Image.network(url));
  }
}

