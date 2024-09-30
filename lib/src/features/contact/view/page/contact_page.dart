import 'package:contact_management/src/core/extensions/build_context_extensions.dart';
import 'package:contact_management/src/core/utils/color.dart';
import 'package:contact_management/src/core/widgets/k_primary_button.dart';
import 'package:contact_management/src/core/widgets/k_text_field.dart';
import 'package:contact_management/src/features/contact/controller/contact_controller.dart';
import 'package:contact_management/src/features/contact/view/page/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    ContactController contactController = Get.put(ContactController());
    return GestureDetector(
      onTap: context.unFocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Management",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: KTextField(
                    controller: _controller,
                    hintText: "Search Contacts",
                  )),
                  const SizedBox(width: 12),
                  KPrimaryButton(
                    buttonText: "Add Contact",
                    fontWeight: FontWeight.w400,
                    icon: Icons.add,
                    isNeedIcon: true,
                    onTap: () {
                      Get.to(
                        () => const AddContactPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () {
                    if (contactController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (contactController.contactList.isEmpty) {
                      return const Center(child: Text("No contacts found"));
                    }

                    return ListView.builder(
                      itemCount: contactController.contactList.length,
                      itemBuilder: (context, index) {
                        final contact = contactController.contactList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: context.screenWidth,

                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 3,
                            semanticContainer: true,
                            color: kBackgroundColor,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: kSocialMediaColor,
                                child: Text(
                                  contact.name!.substring(0, 2),
                                  style: GoogleFonts.poppins(
                                      color: kBackgroundColor),
                                ),
                              ),
                              title: Text(
                                 contact.name ?? "Unknown",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                contact.phone ?? "",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w300),
                              ),
                              trailing: const Icon(Icons.call,color: kSuccessColor,size: 30,),
                            ),
                          ),
                        );
                  /// this is important code for showing social media
                        // ListTile(
                        //   title: Text(contact.name ?? ""),
                        //   subtitle: contact.socialMedia != null &&
                        //           contact.socialMedia!.isNotEmpty
                        //       ? ListView.builder(
                        //           physics: const NeverScrollableScrollPhysics(),
                        //           shrinkWrap: true,
                        //           itemCount: contact.socialMedia!.length,
                        //           itemBuilder: (context, socialIndex) {
                        //             final social =
                        //                 contact.socialMedia![socialIndex];
                        //             return Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(social.platform ?? ""),
                        //                 Text(social.url ?? "",
                        //                     style: const TextStyle(
                        //                         color: Colors.blue)),
                        //               ],
                        //             );
                        //           },
                        //         )
                        //       : const Text("No social media"),
                        //   trailing: Text(contact.phone ?? ""),
                        //   onTap: () {
                        //     // Handle tap on contact
                        //   },
                        // );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
