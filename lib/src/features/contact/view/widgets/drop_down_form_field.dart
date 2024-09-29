import 'package:contact_management/src/core/extensions/build_context_extensions.dart';
import 'package:contact_management/src/core/utils/color.dart';
import 'package:contact_management/src/features/contact/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownFormField extends StatelessWidget {
  const DropDownFormField({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            errorStyle: const TextStyle(
              color: Colors.redAccent,
              fontSize: 16.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1.7,
              ),
            ),
          ),
          isEmpty: contactController.selectedPlatform.value == '',
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: kBackgroundColor,
                menuWidth: context.screenWidth / 3,
                value: contactController.selectedPlatform.value.isEmpty
                    ? null
                    : contactController.selectedPlatform.value,
                isDense: true,
                iconSize: 40,
                hint: const Text(
                  'Please select',
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
                onChanged: (String? newValue) {
                  contactController.updateSelectedPlatform(newValue!);
                  state.didChange(newValue);
                },
                items: contactController.socialMedias.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
