import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/provider/travelProvider.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:travel_guide/widgets/buttons.dart';
import 'package:travel_guide/widgets/form_Decoration.dart';
import 'package:travel_guide/widgets/notification.dart';
import 'package:travel_guide/widgets/static_variables.dart';
class AddTravelSpot extends StatefulWidget {
  const AddTravelSpot({Key? key}) : super(key: key);

  @override
  _AddTravelSpotState createState() => _AddTravelSpotState();
}

class _AddTravelSpotState extends State<AddTravelSpot> {
  String? selectTravelRegion;
  String? selectTravelSpot;
  ImagePicker picker = ImagePicker();
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TravelProvider travelProvider = Provider.of<TravelProvider>(context);
    return Scaffold(
      appBar: appBarDEcoration(context, 'Add New Spot'),
      body: _bodyUI(travelProvider),
    );
  }
  Widget _bodyUI(TravelProvider travelProvider){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        children: [
          ClipRRect(
              child: _imageFile !=null ?Image.file(
                _imageFile!,
                width: size.width,
                height: size.height * 0.3,
                fit: BoxFit.contain,
              ):Icon(Icons.image,size: size.height * 0.3,color: Theme.of(context).primaryColor,)

            // child:Image.asset('assets/images/Obaidul-Quader.jpg',height: 200,width: 200,),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _getImageFromGallery, icon: Icon(Icons.camera_front)),
              IconButton(onPressed: _getImageFromCamera, icon: Icon(Icons.image_outlined)),
            ],
          ),

          Divider(),

          Form(key: _formKey,child: Column(
            children: [Divider(),
              TextFormField(maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: FormDecoration.copyWith(
                  labelText: "Spot Name",

                ),
                validator: (value){
                if(value!.isEmpty){
                  return "Please Fill All Field";
                }
                  return null;
                },
                onChanged: (value){
                setState(() {
                  travelProvider.travelModel.spotname = value;
                });
                },
              ),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      )
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectTravelRegion,
                      hint: Container(
                        width: size.width*.75,
                        child: Text('Select Region',style: TextStyle(
                            color:Colors.grey[700],
                            fontSize: size.height*0.023
                        ),),
                      ),
                      items: StaticVariables.TravelRegion.map((selectTravelRegion){
                        return DropdownMenuItem(child: Container(
                          width: size.width*.75,
                          child: Text(selectTravelRegion,style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16,
                          ),),
                        ),
                          value: selectTravelRegion,) ;
                      },
                      ).toList(),
                      dropdownColor: Colors.white,
                      onChanged: (newValue)
                      {
                        setState(() {
                          selectTravelRegion = newValue as String?;
                          selectTravelSpot = null;
                          travelProvider.travelModel.travelspot = null;
                          travelProvider.travelModel.travelregion = newValue as String?;
                        });
                      },
                    ),

                  )
              ),
              SizedBox(height: 10,),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      )
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectTravelSpot,
                      hint: Container(
                        width: size.width*.75,
                        child: Text('Select Spot',style: TextStyle(
                            color:Colors.grey[700],
                            fontSize: size.height*0.023
                        ),),
                      ),
                      items:selectTravelRegion==null?null
                          :
                      selectTravelRegion== 'Travel Bangladesh'?
                      StaticVariables.TravelBD.map((selectTravelSpot){
                        return DropdownMenuItem(child: Container(
                          width: size.width*.75,
                          child: Text(selectTravelSpot,style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16,
                          ),),
                        ),
                          value: selectTravelSpot,) ;
                      },
                      ).toList()
                          :
                      selectTravelRegion== 'Travel World'?
                      StaticVariables.TravelWorld.map((selectTravelSpot){
                        return DropdownMenuItem(child: Container(
                          width: size.width*.75,
                          child: Text(selectTravelSpot,style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16,
                          ),),
                        ),
                          value: selectTravelSpot,) ;
                      },
                      ).toList():null,
                      dropdownColor: Colors.white,
                      onChanged: (newValue)
                      {
                        setState(() {
                          selectTravelSpot = newValue as String?;
                          travelProvider.travelModel.travelspot = null;
                          travelProvider.travelModel.travelspot = newValue as String?;
                        });
                      },
                    ),

                  )
              ),
              SizedBox(height: 10,),
              TextFormField(maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: FormDecoration.copyWith(
                  labelText: "Description",

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Please Fill All Field";
                  }
                  return null;
                },
                onChanged: (value){
                  setState(() {
                    travelProvider.travelModel.tdescrpition = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              InkWell(

                onTap: ()async{
                  if(_formKey.currentState!.validate()){
                    Center(child: CircularProgressIndicator(),
                  );
                    travelProvider.loadingMgs = 'Submitting Information....';
                    showLoadingDialog(context,travelProvider);
                    await travelProvider.addTravelSpot(context, travelProvider, travelProvider.travelModel, _imageFile!);
                    await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                      child: Text('New Spot Added',),
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      color: Colors.teal,
                    )));
                  }
                },
                child:  button(context,'Submit'),
              )
            ],
          ))
        ],
      ),
    );
  }
  Future<void> _getImageFromGallery()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,maxWidth: 300,maxHeight: 300);
    if(pickedFile!=null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }else {
      // showSnackBar(_scaffoldKey, 'No image selected', Colors.deepOrange);
      Navigator.pop(context);
    }
  }
  Future<void> _getImageFromCamera()async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera,maxWidth: 300,maxHeight: 300);
    if(pickedFile!=null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }else {
      // showSnackBar(_scaffoldKey, 'No image selected', Colors.deepOrange);
      Navigator.pop(context);
    }
  }


}

