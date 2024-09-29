import 'package:contact_management/src/core/service/show_dialog_service.dart';
import 'package:contact_management/src/core/utils/assets_path.dart';
import 'package:contact_management/src/core/utils/color.dart';
import 'package:contact_management/src/features/contact/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());

    return Obx(
      () => contactController.socialMediaList.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: contactController.socialMediaList.length,
              itemBuilder: (context, index) {
                 if(contactController.socialMediaList.contains(contactController.socialMedias)){
                   ShowDialogService.warningMessage("Already added");
                 }else{
                   return Container(
                     padding: const EdgeInsets.all(2),
                     margin: const EdgeInsets.only(bottom: 3),
                     decoration: BoxDecoration(
                       border: Border.all(
                         color: kGrey.withOpacity(0.2),
                         width: 1.7,
                       ),
                       borderRadius: BorderRadius.circular(8),
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         SvgPicture.asset(
                           contactController.socialMediaList[index].platform == "Facebook"
                               ? AssetsPath.facebook
                               : contactController.socialMediaList[index].platform =="Instagram"
                               ? AssetsPath.instagram
                               : contactController.socialMediaList[index].platform  =="Whatsapp"
                               ? AssetsPath.whatsapp
                               : contactController.socialMediaList[index].platform  =="Twitter"
                               ? AssetsPath.twitter
                               : contactController.socialMediaList[index].platform  =="LinkedIn"
                               ? AssetsPath.linkedIn
                               : "",
                           width: 30,
                           height: 30,
                         ),
                         const SizedBox(width: 10),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(contactController.socialMediaList[index].url ??""),
                             Text(contactController.socialMediaList[index].platform ??""),
                           ],
                         ),
                         const Spacer(),
                         // Edit Button
                         IconButton(
                           onPressed: () {
                             // Handle Edit button press
                           },
                           icon: const Icon(
                             Icons.edit,
                             color: Colors.black45,
                           ),
                         ),
                         // Remove Button
                         IconButton(
                           onPressed: () {
                             contactController.socialMediaList.removeAt(index);
                           },
                           icon: const Icon(
                             Icons.close,
                             color: Colors.black45,
                           ),
                         ),
                       ],
                     ),
                   );
                 }




              },
            )
          : Container(),
    );
  }
}
