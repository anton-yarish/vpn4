class AdModel {
  String? response;
  List<Data>? data;

  AdModel({this.response, this.data});

  AdModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? admobID;
  String? bannerID;
  String? interstitialID;
  String? nativeID;
  String? rewardedID;
  String? adType;
  String? activeAd;

  Data(
      {this.id,
      this.admobID,
      this.bannerID,
      this.interstitialID,
      this.nativeID,
      this.rewardedID,
      this.adType,
      this.activeAd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admobID = json['admobID'];
    bannerID = json['bannerID'];
    interstitialID = json['interstitialID'];
    nativeID = json['nativeID'];
    rewardedID = json['RewardedID'];
    adType = json['adType'];
    activeAd = json['activeAd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admobID'] = this.admobID;
    data['bannerID'] = this.bannerID;
    data['interstitialID'] = this.interstitialID;
    data['nativeID'] = this.nativeID;
    data['RewardedID'] = this.rewardedID;
    data['adType'] = this.adType;
    data['activeAd'] = this.activeAd;
    return data;
  }
}
