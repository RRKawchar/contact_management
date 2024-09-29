import 'package:contact_management/src/core/extensions/build_context_extensions.dart';
import 'package:contact_management/src/core/widgets/k_primary_button.dart';
import 'package:contact_management/src/core/widgets/k_text_field.dart';
import 'package:contact_management/src/features/contact/view/page/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
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
                        () => AddContactPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
