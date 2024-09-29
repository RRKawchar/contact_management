import 'package:flutter/cupertino.dart';

class SocialModel {
  String? id;
  String? url;
  String? platform;
  String? icon;

  SocialModel({
    this.id,
    this.url,
    this.platform,
    this.icon
  });

  SocialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    platform = json['platform'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['platform'] = platform;
    data['icon'] = icon;
    return data;
  }
}
