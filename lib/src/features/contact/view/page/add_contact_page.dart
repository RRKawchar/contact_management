import 'package:contact_management/src/core/extensions/build_context_extensions.dart';
import 'package:contact_management/src/core/utils/color.dart';
import 'package:contact_management/src/core/widgets/k_primary_button.dart';
import 'package:contact_management/src/core/widgets/k_text_field.dart';
import 'package:contact_management/src/features/contact/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController=Get.put(ContactController());

    final TextEditingController platform=TextEditingController();
    final TextEditingController urlController=TextEditingController();

    RxBool isAddSocial = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Contact",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const KTextField(
                titleText: "Name",
                isTitleNeed: true,
              ),
              const SizedBox(height: 20),
              const KTextField(
                titleText: "Email",
                isTitleNeed: true,
              ),
              const SizedBox(height: 20),
              const KTextField(
                titleText: "Phone",
                isTitleNeed: true,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Social Media",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              Obx(
                () => isAddSocial.value?Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border(
                        left: BorderSide(
                          color: kGrey.withOpacity(0.2),
                          width: 1.7,
                        ),
                        right: BorderSide(
                          color: kGrey.withOpacity(0.2),
                          width: 1.7,
                        ),
                        bottom: BorderSide(
                          color: kGrey.withOpacity(0.2),
                          width: 1.7,
                        ),
                        top: BorderSide(
                          color: kGrey.withOpacity(0.2),
                          width: 1.7,
                        ),
                      )),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.facebook,size: 40,color: Colors.black54,),
                       SizedBox(width: 10),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("https://facebook.com") ,
                           Text("Facebook") ,
                         ],
                       ),
                       Spacer(),
                      IconButton(onPressed: (){
                      }, icon: Icon(Icons.edit,color: Colors.black45,)),
                      IconButton(onPressed: (){
                        isAddSocial.value=false;
                      }, icon: Icon(Icons.close,color: Colors.black45,)),
                    ],
                  ),
                ):Container(),
              ),
             Obx(()=> SizedBox(height:isAddSocial.value? 10:0),),
               KTextField(
                controller: platform,
                hintText: "Platform",
              ),
              const SizedBox(height: 10),
               KTextField(
                controller: urlController,
                hintText: "URL",
              ),
              const SizedBox(height: 20),
              KPrimaryButton(
                buttonText: 'Add',
                fontSize: 20,
                onTap: () {
                  contactController.addSocial(platform: platform.text, url: urlController.text);
                  isAddSocial.value=true;
                },
              ),
              const SizedBox(height: 20),
              const KTextField(
                isTitleNeed: true,
                titleText: "Communities",
                hintText: "Community",
              ),
              const SizedBox(height: 10),
              KPrimaryButton(
                buttonText: 'Add',
                fontSize: 20,
                onTap: () {},
              ),
              SizedBox(height: context.screenHeight / 18),
              Container(
                height: 50,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: context.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                        color: kGrey.withOpacity(0.2),
                        width: 1.7,
                      ),
                      right: BorderSide(
                        color: kGrey.withOpacity(0.2),
                        width: 1.7,
                      ),
                      bottom: BorderSide(
                        color: kGrey.withOpacity(0.2),
                        width: 1.7,
                      ),
                      top: BorderSide(
                        color: kGrey.withOpacity(0.2),
                        width: 1.7,
                      ),
                    )),
                child: const Text("Cancel",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              KPrimaryButton(
                buttonText: 'Add Contact',
                fontSize: 20,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
