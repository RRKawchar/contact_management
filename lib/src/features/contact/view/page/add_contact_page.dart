import 'package:contact_management/src/core/extensions/build_context_extensions.dart';
import 'package:contact_management/src/core/utils/color.dart';
import 'package:contact_management/src/core/widgets/k_primary_button.dart';
import 'package:contact_management/src/core/widgets/k_text_field.dart';
import 'package:contact_management/src/features/contact/controller/contact_controller.dart';
import 'package:contact_management/src/features/contact/view/widgets/drop_down_form_field.dart';
import 'package:contact_management/src/features/contact/view/widgets/social_media_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());

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
              KTextField(
                controller: contactController.nameController,
                titleText: "Name",
                isTitleNeed: true,
              ),
              const SizedBox(height: 20),
              KTextField(
                controller: contactController.emailController,
                titleText: "Email",
                isTitleNeed: true,
              ),
              const SizedBox(height: 20),
              KTextField(
                controller: contactController.phoneController,
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
              const SocialMediaCard(),
              Obx(
                () => SizedBox(
                  height: contactController.socialMediaList.isNotEmpty ? 10 : 0,
                ),
              ),
              const DropDownFormField(),
              const SizedBox(height: 10),
              KTextField(
                controller: contactController.urlController,
                hintText: "URL",
              ),
              const SizedBox(height: 20),
              KPrimaryButton(
                buttonText: 'Add',
                fontSize: 20,
                onTap: () {
                  contactController.addSocial(
                    platform: contactController.selectedPlatform.value,
                    url: contactController.urlController.text,
                  );
                },
              ),
              const SizedBox(height: 20),
              KTextField(
                isTitleNeed: true,
                controller: contactController.communityController,
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
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => contactController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : KPrimaryButton(
                        buttonText: 'Add Contact',
                        fontSize: 20,
                        onTap: () {
                          contactController.saveDataToFirebase();
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
