import 'package:contact_management/src/features/contact/model/social_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ContactController extends GetxController{
  RxList<SocialModel> socialMediaList=<SocialModel>[].obs;

  final uuid=Uuid().v6();


  addSocial({required String platform,required String url}){
     try{
       SocialModel socialModel=SocialModel(
         id: uuid,
         platform: platform,
         url: url,
       );

       socialMediaList.add(socialModel);

       print("$socialMediaList");

     }catch(e){
       print(e.toString());
     }
  }
}