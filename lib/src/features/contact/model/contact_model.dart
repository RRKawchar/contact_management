import 'package:contact_management/src/features/contact/model/social_model.dart';

class ContactModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  List<SocialModel>? socialMedia;
  String? community;

  ContactModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.socialMedia,
    this.community,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];

    if (json['socialMedia'] != null) {
      // Check if socialMedia is already a list of SocialModel objects
      socialMedia = (json['socialMedia'] as List).map((item) {
        // If item is already a SocialModel, return it, otherwise convert from JSON
        if (item is SocialModel) {
          return item;
        } else {
          return SocialModel.fromJson(item as Map<String, dynamic>);
        }
      }).toList();
    }

    community = json['community'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    if (socialMedia != null) {
      data['socialMedia'] = socialMedia!.map((item) => item.toJson()).toList();
    } else {
      data['socialMedia'] = null;
    }

    data['community'] = community;
    return data;
  }
}
