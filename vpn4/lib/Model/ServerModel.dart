class ServerModel {
  String? id;
  String? serverName;
  String? flagURL;
  String? ovpnConfiguration;
  String? vpnUserName;
  String? vpnPassword;
  String? isFree;

  ServerModel(
      {this.id,
      this.serverName,
      this.flagURL,
      this.ovpnConfiguration,
      this.vpnUserName,
      this.vpnPassword,
      this.isFree});

  ServerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serverName = json['serverName'];
    flagURL = json['flagURL'];
    ovpnConfiguration = json['ovpnConfiguration'];
    vpnUserName = json['vpnUserName'];
    vpnPassword = json['vpnPassword'];
    isFree = json['isFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serverName'] = this.serverName;
    data['flagURL'] = this.flagURL;
    data['ovpnConfiguration'] = this.ovpnConfiguration;
    data['vpnUserName'] = this.vpnUserName;
    data['vpnPassword'] = this.vpnPassword;
    data['isFree'] = this.isFree;
    return data;
  }
}

class ServerModel2 {
  bool? error;
  List<Regions>? regions;

  ServerModel2({this.error, this.regions});

  ServerModel2.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(new Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.regions != null) {
      data['regions'] = this.regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  String? regionId;
  String? regionName;
  List<Servers>? servers;

  Regions({this.regionId, this.regionName, this.servers});

  Regions.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    regionName = json['region_name'];
    if (json['servers'] != null) {
      servers = <Servers>[];
      json['servers'].forEach((v) {
        servers!.add(new Servers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_id'] = this.regionId;
    data['region_name'] = this.regionName;
    if (this.servers != null) {
      data['servers'] = this.servers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Servers {
  String? id;
  String? serverName;
  String? flagURL, latitude, longitude;
  String? ovpnConfiguration;
  String? vpnUserName;
  String? vpnPassword;
  String? isFree;
  String? regionId;

  Servers(
      {this.id,
      this.serverName,
      this.flagURL,
      this.latitude,
      this.longitude,
      this.ovpnConfiguration,
      this.vpnUserName,
      this.vpnPassword,
      this.isFree,
      this.regionId});

  Servers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serverName = json['serverName'];
    flagURL = json['flagURL'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ovpnConfiguration = json['ovpnConfiguration'];
    vpnUserName = json['vpnUserName'];
    vpnPassword = json['vpnPassword'];
    isFree = json['isFree'];
    regionId = json['region_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serverName'] = this.serverName;
    data['flagURL'] = this.flagURL;
    data['ovpnConfiguration'] = this.ovpnConfiguration;
    data['vpnUserName'] = this.vpnUserName;
    data['vpnPassword'] = this.vpnPassword;
    data['isFree'] = this.isFree;
    data['region_id'] = this.regionId;
    return data;
  }
}
