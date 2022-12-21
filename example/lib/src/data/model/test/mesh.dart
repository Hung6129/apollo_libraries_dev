// import 'package:json_annotation/json_annotation.dart';
// part 'mesh.g.dart';

// @JsonSerializable(explicitToJson: true)
// class Header {
//   String meshUUID;
//   String meshName;
//   String version;
//   DateTime? timestamp;

//   Header({
//     required this.meshUUID,
//     required this.meshName,
//     required this.version,
//     required this.timestamp,
//   });

//   factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
//   Map<String, dynamic> toJson() => _$HeaderToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class NetKey {
//   String name;
//   int index;
//   String key;
//   int phase;
//   bool minSecurity;
//   int timestamp;

//   NetKey({
//     required this.name,
//     required this.index,
//     required this.key,
//     required this.phase,
//     required this.minSecurity,
//     required this.timestamp,
//   });

//   factory NetKey.fromJson(Map<String, dynamic> json) => _$NetKeyFromJson(json);
//   Map<String, dynamic> toJson() => _$NetKeyToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class AppKey {
//   String name;
//   int index;
//   int boundNetKey;
//   String key;

//   AppKey({
//     required this.name,
//     required this.index,
//     required this.boundNetKey,
//     required this.key,
//   });

//   factory AppKey.fromJson(Map<String, dynamic> json) => _$AppKeyFromJson(json);
//   Map<String, dynamic> toJson() => _$AppKeyToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class Provisioner {
//   String provisionerName;
//   String uuid;
//   Map allocatedUnicastRange;
//   Map allocatedGroupRange;
//   Map allocatedSceneRange;

//   Provisioner({
//     required this.provisionerName,
//     required this.uuid,
//     required this.allocatedUnicastRange,
//     required this.allocatedGroupRange,
//     required this.allocatedSceneRange,
//   });

//   factory Provisioner.fromJson(Map<String, dynamic> json) => _$ProvisionerFromJson(json);
//   Map<String, dynamic> toJson() => _$ProvisionerToJson(this);
// }

// // @JsonSerializable(explicitToJson: true)
// // class GatewayProperties{
// //   String name;
// //   String ip;
// //   int host;
// //   String apikey;
// //   String documentPath;
// //   String projectid;
// //   Map<String, dynamic>? properties = {};

// //   GatewayProperties({
// //     required this.name,
// //     required this.ip,
// //     required this.host,
// //     required this.apikey,
// //     required this.documentPath,
// //     required this.projectid,
// //     required this.properties,
// //   });

// //   factory GatewayProperties.fromJson(Map<String, dynamic> json) => _$GatewayPropertiesFromJson(json);
// //   Map<String, dynamic> toJson() => _$GatewayPropertiesToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class GatewayTCPConfig{
// //   String apiKey;
// //   String projectId;
// //   String? email;
// //   String? password;
// //   String documentPath;

// //   GatewayTCPConfig({
// //     required this.apiKey,
// //     required this.projectId,
// //     required this.email,
// //     required this.password,
// //     required this.documentPath,
// //   });

// //   factory GatewayTCPConfig.fromJson(Map<String, dynamic> json) => _$GatewayTCPConfigFromJson(json);
// //   Map<String, dynamic> toJson() => _$GatewayTCPConfigToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class BaseTCP{
// //   String? topic;
// //   Map<String, dynamic>? payload;

// //   BaseTCP({
// //     required this.topic,
// //     required this.payload,
// //   });

// //   factory BaseTCP.fromJson(Map<String, dynamic> json) => _$BaseTCPFromJson(json);
// //   Map<String, dynamic> toJson() => _$BaseTCPToJson(this);
// // }

// // gateway config for TCP
// @JsonSerializable(explicitToJson: true)
// class Node {
//   String? name;
//   int? context;
//   int? netKeyIndex;
//   int? appKeyIndex;
//   String? advAddr;
//   int? gattSupported;
//   int? advAddrType;
//   int? rssi;
//   String? uuid;
//   String? address;
//   String? deviceKey;
//   String? networkKey;
//   String? appKey;
//   int? numberOfElements;
//   String? elementAddress;
//   String? devKeyHandle;
//   String? addressHandle;
//   String? cid;
//   String? pid;
//   String? vid;
//   String? crpl;
//   bool? relay;
//   bool? proxy;
//   bool? friends;
//   bool? lowPower;
//   String? loc;
//   List<dynamic>? models;
//   List<dynamic>? effects;
//   List<dynamic>? bindModels;
//   Map<String, dynamic> public;
//   Map<String, dynamic>? hubConfig;

//   Node({
//     required this.name,
//     required this.context,
//     required this.netKeyIndex,
//     required this.appKeyIndex,
//     required this.advAddr,
//     required this.advAddrType,
//     required this.gattSupported,
//     required this.rssi,
//     required this.uuid,
//     required this.address,
//     required this.deviceKey,
//     required this.networkKey,
//     required this.appKey,
//     required this.numberOfElements,
//     required this.elementAddress,
//     required this.devKeyHandle,
//     required this.addressHandle,
//     required this.cid,
//     required this.pid,
//     required this.vid,
//     required this.crpl,
//     required this.relay,
//     required this.proxy,
//     required this.friends,
//     required this.lowPower,
//     required this.loc,
//     required this.models,
//     required this.effects,
//     required this.bindModels,
//     required this.public,
//     required this.hubConfig,
//   });

//   factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
//   Map<String, dynamic> toJson() => _$NodeToJson(this);
// }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class Model{
// //   int modelId;
// //   List<int>? bind;
// //   List<int>? subscribe;
// //   List<Public>? public;

// //   Model({
// //     required this.modelId,
// //     required this.bind,
// //     required this.subscribe,
// //     required this.public,
// //   });

// // factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
// // Map<String, dynamic> toJson() => _$ModelToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class Public{
// //   int address;
// //   int index;
// //   int ttl;
// //   int credentials;
// //   Map<String, int>? period;
// //   Map<String, int>? transmit;

// //   Public({
// //     required this.address,
// //     required this.index,
// //     required this.ttl,
// //     required this.credentials,
// //     required this.period,
// //     required this.transmit
// //   });

// //   factory Public.fromJson(Map<String, dynamic> json) => _$PublicFromJson(json);
// //   Map<String, dynamic> toJson() => _$PublicToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class Element{
// //   String name;
// //   int index;
// //   int location;
// //   List<Model> models;

// //   Element({
// //     required this.name,
// //     required this.index,
// //     required this.location,
// //     required this.models,
// //   });

// //   factory Element.fromJson(Map<String, dynamic> json) => _$ElementFromJson(json);
// //   Map<String, dynamic> toJson() => _$ElementToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class UnProvisioning{
// //   int context;
// //   int netKeyIndex;
// //   String uuid;
// //   String address;


// //   UnProvisioning({
// //     required this.context,
// //     required this.netKeyIndex,
// //     required this.uuid,
// //     required this.address
// //   });

// //   factory UnProvisioning.fromJson(Map<String, dynamic> json) => _$UnProvisioningFromJson(json);
// //   Map<String, dynamic> toJson() => _$UnProvisioningToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class EffectJson{
// //   String name;
// //   String opcode;
// //   int id;
// //   int speed;
// //   int lightness;

// //   EffectJson({
// //     required this.name,
// //     required this.opcode,
// //     required this.id,
// //     required this.speed,
// //     required this.lightness
// //   });

// //   factory EffectJson.fromJson(Map<String, dynamic> json) => _$EffectJsonFromJson(json);
// //   Map<String, dynamic> toJson() => _$EffectJsonToJson(this);
// // }

// // // gateway config for TCP
// // @JsonSerializable(explicitToJson: true)
// // class HubSetting{
// //   String opcode;
// //   String address;
// //   int type;
// //   int chanel;
// //   int amount;
// //   int row;
// //   int column;
// //   int speed;
// //   int lightness;

// //   int zigzac;
// //   int coordinator;
// //   int direction;

// //   List<dynamic> portNumber;

// //   HubSetting({
// //     required this.opcode,
// //     required this.address,
// //     required this.type,
// //     required this.chanel,
// //     required this.amount,
// //     required this.row,
// //     required this.column,
// //     required this.speed,
// //     required this.lightness,
// //     required this.zigzac,
// //     required this.coordinator,
// //     required this.direction,
// //     required this.portNumber,
// //   });

// //   factory HubSetting.fromJson(Map<String, dynamic> json) => _$HubSettingFromJson(json);
// //   Map<String, dynamic> toJson() => _$HubSettingToJson(this);
// // }












