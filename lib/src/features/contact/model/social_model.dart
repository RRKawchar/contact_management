class SocialModel {
  String? id;
  String? url;
  String? platform;

  SocialModel({
    this.id,
    this.url,
    this.platform,
  });

  SocialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['platform'] = platform;
    return data;
  }
}
