import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RetriveData extends StatefulWidget {
  const RetriveData({Key? key}) : super(key: key);

  @override
  _RetriveDataState createState() => _RetriveDataState();
}

class _RetriveDataState extends State<RetriveData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, 'Crud'),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){

              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  primary: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index) {
                QueryDocumentSnapshot networkData = snapshot.data!.docs[index];

                return Card(
                  child: ListTile(title: Text(networkData['name']),
                  subtitle: Text(networkData['email']),
                  ),
                );
              },
              );
            }
            return Center(
              child: CircularProgressIndicator()
            );
          },

        ),
      ),
    );
  }
}
