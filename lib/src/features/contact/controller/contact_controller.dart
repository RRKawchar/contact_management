import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_management/src/core/helper/helper_method.dart';
import 'package:contact_management/src/core/service/show_dialog_service.dart';
import 'package:contact_management/src/features/contact/model/contact_model.dart';
import 'package:contact_management/src/features/contact/model/social_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ContactController extends GetxController {
  RxList<SocialModel> socialMediaList = <SocialModel>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController communityController = TextEditingController();
  TextEditingController urlController = TextEditingController();


  FirebaseFirestore fireStoreDB=FirebaseFirestore.instance;

  final uuid = const Uuid().v6();

  var socialMedias = [
    "Facebook",
    "Instagram",
    "Whatsapp",
    "Twitter",
    "LinkedIn",
  ];

  var selectedPlatform = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    urlController.dispose();
    communityController.dispose();
  }



  void updateSelectedPlatform(String value) {
    selectedPlatform.value = value;
  }

  addSocial({required String platform, required String url}) {
    try {

      if(selectedPlatform.value !="" && urlController.text.isNotEmpty){

        if(socialMediaList.any((element)=>element.platform==platform)){
          ShowDialogService.warningMessage("Platform '$platform' is already added.");
        }else{
          SocialModel socialModel = SocialModel(
            id: uuid,
            platform: platform,
            url: url,
          );
          socialMediaList.add(socialModel);
        }

      }else{

        ShowDialogService.warningMessage("Enter the social media content");

      }

      selectedPlatform.value="";
       urlController.clear();
    } catch (e) {
      kPrint(e.toString());
    }
  }


  Future<void> saveDataToFirebase()async{
    try{

      ContactModel contactModel=ContactModel(
        id: uuid,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        socialMedia: socialMediaList,
        community: communityController.text
      );

      await fireStoreDB.collection("contacts").doc(uuid).set(
          contactModel.toJson()
      );

    }catch(e){
      kPrint("Error while save data to firebase : $e");
      throw "Error while save data to firebase : $e";
    }

  }



}
