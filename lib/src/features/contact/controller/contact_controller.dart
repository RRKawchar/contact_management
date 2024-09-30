import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_management/src/core/helper/helper_method.dart';
import 'package:contact_management/src/core/service/connection_service.dart';
import 'package:contact_management/src/core/service/show_dialog_service.dart';
import 'package:contact_management/src/features/contact/model/contact_model.dart';
import 'package:contact_management/src/features/contact/model/social_model.dart';
import 'package:contact_management/src/features/contact/view/page/contact_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ContactController extends GetxController {
  RxList<SocialModel> socialMediaList = <SocialModel>[].obs;
  RxList<ContactModel> contactList = <ContactModel>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController communityController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  RxBool isLoading = false.obs;

  FirebaseFirestore fireStoreDB = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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
    super.onInit();
    fetchContactsFromFirebase();
    syncLocalDataWithFirestore();
    fetchContactsFromHive(); // Show local data when offline

    // Check if the user is connected to the internet
    ConnectionService.isConnectedToInternet().then((isConnected) {
      if (isConnected) {
        fetchContactsFromFirebase();
        syncLocalDataWithFirestore();
      } else {
        // Load data from Hive if offline
        fetchContactsFromHive();
      }
    });

    // Continuously listen for internet connection changes
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        final result = results.first;
        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
          syncLocalDataWithFirestore();
          fetchContactsFromFirebase();
        }else{
          fetchContactsFromHive(); // Show local data when offline
        }
      }
    });
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
      final uuid = const Uuid().v6();

      if (selectedPlatform.value != "" && urlController.text.isNotEmpty) {
        if (socialMediaList.any((element) => element.platform == platform)) {
          ShowDialogService.warningMessage("Platform '$platform' is already added.");
        } else {
          SocialModel socialModel = SocialModel(
            id: uuid,
            platform: platform,
            url: url,
          );
          socialMediaList.add(socialModel);
        }
      } else {
        ShowDialogService.warningMessage("Enter the social media content");
      }

      selectedPlatform.value = "";
      urlController.clear();
    } catch (e) {
      kPrint(e.toString());
    }
  }

  // Future<void> saveDataToFirebase() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final contactId = const Uuid().v4();
  //
  //     ContactModel contactModel = ContactModel(
  //       id: contactId,
  //       name: nameController.text,
  //       email: emailController.text,
  //       phone: phoneController.text,
  //       socialMedia: socialMediaList,
  //       community: communityController.text,
  //     );
  //
  //     bool isConnected = await ConnectionService.isConnectedToInternet();
  //
  //     if (isConnected) {
  //       await fireStoreDB.collection("contacts").doc(contactId).set(
  //           contactModel.toJson());
  //       ShowDialogService.successMessage("Contact saved successfully!");
  //     } else {
  //       var contactsBox = Hive.box('contactsBox');
  //       await contactsBox.put(contactId, contactModel.toJson());
  //       ShowDialogService.successMessage("Contact saved locally. Will sync when online.");
  //     }
  //
  //     await fetchContactsFromFirebase();
  //     Get.offAll(() => const ContactPage());
  //   } catch (e) {
  //     kPrint("Error while saving data to Firebase: $e");
  //     ShowDialogService.errorMessage("Failed to save contact. Please try again.");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> saveDataToFirebase() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final contactId = const Uuid().v4();
  //
  //     ContactModel contactModel = ContactModel(
  //       id: contactId,
  //       name: nameController.text,
  //       email: emailController.text,
  //       phone: phoneController.text,
  //       socialMedia: socialMediaList,
  //       community: communityController.text,
  //     );
  //
  //     bool isConnected = await ConnectionService.isConnectedToInternet();
  //
  //     if (isConnected) {
  //       await fireStoreDB.collection("contacts").doc(contactId).set(contactModel.toJson());
  //       ShowDialogService.successMessage("Contact saved successfully!");
  //     } else {
  //       var contactsBox = Hive.box('contactsBox');
  //       await contactsBox.put(contactId, contactModel.toJson());
  //       ShowDialogService.successMessage("Contact saved locally. Will sync when online.");
  //     }
  //
  //     // Update the contact list in the UI
  //     contactList.add(contactModel);
  //
  //     // Navigate back to the ContactPage
  //     Get.offAll(() => const ContactPage());
  //   } catch (e) {
  //     kPrint("Error while saving data to Firebase: $e");
  //     ShowDialogService.errorMessage("Failed to save contact. Please try again.");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }



  Future<void> saveDataToFirebase() async {
    try {
      isLoading.value = true;

      final contactId = const Uuid().v4();

      ContactModel contactModel = ContactModel(
        id: contactId,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        socialMedia: socialMediaList,
        community: communityController.text,
      );

      bool isConnected = await ConnectionService.isConnectedToInternet();

      if (await ConnectionService.hasInternet) {
        await fireStoreDB.collection("contacts").doc(contactId).set(contactModel.toJson());
        ShowDialogService.successMessage("Contact saved successfully!");
      } else {
        var contactsBox = Hive.box('contactsBox');
        await contactsBox.put(contactId, contactModel.toJson());
        ShowDialogService.successMessage("Contact saved locally. Will sync when online.");
        isLoading.value = false;
        Get.offAll(() => const ContactPage());
      }

      contactList.add(contactModel);

      Get.offAll(() => const ContactPage());
    } catch (e) {
      kPrint("Error while saving data to Firebase: $e");
      ShowDialogService.errorMessage("Failed to save contact. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchContactsFromFirebase() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot = await fireStoreDB.collection("contacts").get();
      contactList.clear();
      for (var doc in snapshot.docs) {
        ContactModel contact = ContactModel.fromJson(doc.data() as Map<String, dynamic>);
        contactList.add(contact);
      }
      kPrint("Success fetching data");
    } catch (e) {
      kPrint("Error while fetching data from Firebase: $e");
      ShowDialogService.errorMessage("Failed to load contacts. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void syncLocalDataWithFirestore() async {
    try {
      var contactsBox = Hive.box('contactsBox');

      if (contactsBox.isNotEmpty) {
        for (var key in contactsBox.keys) {
          var contactData = contactsBox.get(key);

          // Convert the stored data back to ContactModel
          ContactModel contact = ContactModel.fromJson(
              Map<String, dynamic>.from(contactData));

          // Sync with Firestore
          await fireStoreDB.collection("contacts").doc(contact.id).set(
              contact.toJson());

          // Remove the contact from local storage after syncing
          await contactsBox.delete(key);
        }

        ShowDialogService.successMessage("Local data synced with Firebase.");
      } else {
        kPrint("No local data found to sync.");
      }
    } catch (e) {
      kPrint("Error while syncing local data with Firebase: $e");
    }
  }


  Future<void> fetchContactsFromHive() async {
    try {
      isLoading.value = true;
      var contactsBox = Hive.box('contactsBox');

      if (contactsBox.isNotEmpty) {
        contactList.clear();
        for (var key in contactsBox.keys) {
          // Fetch data as Map<dynamic, dynamic> from Hive
          var contactData = contactsBox.get(key) as Map<dynamic, dynamic>;

          // Convert the data to Map<String, dynamic>
          Map<String, dynamic> contactMap = contactData.map((key, value) => MapEntry(key.toString(), value));

          // Convert to ContactModel and add to the contact list
          ContactModel contact = ContactModel.fromJson(contactMap);
          contactList.add(contact);
        }
        kPrint("Loaded data from local storage (Hive)");
      } else {
        kPrint("No local data found in Hive.");
      }
    } catch (e) {
      kPrint("Error while fetching data from local storage (Hive): $e");
    } finally {
      isLoading.value = false;
    }
  }


}
