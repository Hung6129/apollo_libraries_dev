class MeshModel {
  String? schema;
  String? id;
  String? version;
  String? meshUUID;
  String? meshName;
  String? timestamp;
  bool? partial;
  List<NetKeys>? netKeys;
  List<AppKeys>? appKeys;

  MeshModel({
    this.schema,
    this.id,
    this.version,
    this.meshUUID,
    this.meshName,
    this.timestamp,
    this.partial,
    this.netKeys,
    this.appKeys,
  });

  MeshModel.fromJson(Map<String, dynamic> json) {
    schema = json['$schema'];
    id = json['id'];
    version = json['version'];
    meshUUID = json['meshUUID'];
    meshName = json['meshName'];
    timestamp = json['timestamp'];
    partial = json['partial'];
    if (json['netKeys'] != null) {
      netKeys = <NetKeys>[];
      json['netKeys'].forEach((v) {
        netKeys!.add(NetKeys.fromJson(v));
      });
    }
    if (json['appKeys'] != null) {
      appKeys = <AppKeys>[];
      json['appKeys'].forEach((v) {
        appKeys!.add(AppKeys.fromJson(v));
      });
    }
  }
}

class NetKeys {
  String? name;
  int? index;
  String? key;
  int? phase;
  String? minSecurity;
  String? timestamp;

  NetKeys({this.name, this.index, this.key, this.phase, this.minSecurity, this.timestamp});

  NetKeys.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    index = json['index'];
    key = json['key'];
    phase = json['phase'];
    minSecurity = json['minSecurity'];
    timestamp = json['timestamp'];
  }
}

class AppKeys {
  String? name;
  int? index;
  int? boundNetKey;
  String? key;

  AppKeys({this.name, this.index, this.boundNetKey, this.key});

  AppKeys.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    index = json['index'];
    boundNetKey = json['boundNetKey'];
    key = json['key'];
  }
}
