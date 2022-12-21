// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'mesh.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
//       meshUUID: json['meshUUID'] as String,
//       meshName: json['meshName'] as String,
//       version: json['version'] as String,
//       timestamp: json['timestamp'] == null
//           ? null
//           : DateTime.parse(json['timestamp'] as String),
//     );

// Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
//       'meshUUID': instance.meshUUID,
//       'meshName': instance.meshName,
//       'version': instance.version,
//       'timestamp': instance.timestamp?.toIso8601String(),
//     };

// NetKey _$NetKeyFromJson(Map<String, dynamic> json) => NetKey(
//       name: json['name'] as String,
//       index: json['index'] as int,
//       key: json['key'] as String,
//       phase: json['phase'] as int,
//       minSecurity: json['minSecurity'] as bool,
//       timestamp: json['timestamp'] as int,
//     );

// Map<String, dynamic> _$NetKeyToJson(NetKey instance) => <String, dynamic>{
//       'name': instance.name,
//       'index': instance.index,
//       'key': instance.key,
//       'phase': instance.phase,
//       'minSecurity': instance.minSecurity,
//       'timestamp': instance.timestamp,
//     };

// AppKey _$AppKeyFromJson(Map<String, dynamic> json) => AppKey(
//       name: json['name'] as String,
//       index: json['index'] as int,
//       boundNetKey: json['boundNetKey'] as int,
//       key: json['key'] as String,
//     );

// Map<String, dynamic> _$AppKeyToJson(AppKey instance) => <String, dynamic>{
//       'name': instance.name,
//       'index': instance.index,
//       'boundNetKey': instance.boundNetKey,
//       'key': instance.key,
//     };

// Provisioner _$ProvisionerFromJson(Map<String, dynamic> json) => Provisioner(
//       provisionerName: json['provisionerName'] as String,
//       uuid: json['uuid'] as String,
//       allocatedUnicastRange:
//           json['allocatedUnicastRange'] as Map<String, dynamic>,
//       allocatedGroupRange: json['allocatedGroupRange'] as Map<String, dynamic>,
//       allocatedSceneRange: json['allocatedSceneRange'] as Map<String, dynamic>,
//     );

// Map<String, dynamic> _$ProvisionerToJson(Provisioner instance) =>
//     <String, dynamic>{
//       'provisionerName': instance.provisionerName,
//       'uuid': instance.uuid,
//       'allocatedUnicastRange': instance.allocatedUnicastRange,
//       'allocatedGroupRange': instance.allocatedGroupRange,
//       'allocatedSceneRange': instance.allocatedSceneRange,
//     };

// Node _$NodeFromJson(Map<String, dynamic> json) => Node(
//       name: json['name'] as String?,
//       context: json['context'] as int?,
//       netKeyIndex: json['netKeyIndex'] as int?,
//       appKeyIndex: json['appKeyIndex'] as int?,
//       advAddr: json['advAddr'] as String?,
//       advAddrType: json['advAddrType'] as int?,
//       gattSupported: json['gattSupported'] as int?,
//       rssi: json['rssi'] as int?,
//       uuid: json['uuid'] as String?,
//       address: json['address'] as String?,
//       deviceKey: json['deviceKey'] as String?,
//       networkKey: json['networkKey'] as String?,
//       appKey: json['appKey'] as String?,
//       numberOfElements: json['numberOfElements'] as int?,
//       elementAddress: json['elementAddress'] as String?,
//       devKeyHandle: json['devKeyHandle'] as String?,
//       addressHandle: json['addressHandle'] as String?,
//       cid: json['cid'] as String?,
//       pid: json['pid'] as String?,
//       vid: json['vid'] as String?,
//       crpl: json['crpl'] as String?,
//       relay: json['relay'] as bool?,
//       proxy: json['proxy'] as bool?,
//       friends: json['friends'] as bool?,
//       lowPower: json['lowPower'] as bool?,
//       loc: json['loc'] as String?,
//       models: json['models'] as List<dynamic>?,
//       effects: json['effects'] as List<dynamic>?,
//       bindModels: json['bindModels'] as List<dynamic>?,
//       public: json['public'] as Map<String, dynamic>,
//       hubConfig: json['hubConfig'] as Map<String, dynamic>?,
//     );

// Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
//       'name': instance.name,
//       'context': instance.context,
//       'netKeyIndex': instance.netKeyIndex,
//       'appKeyIndex': instance.appKeyIndex,
//       'advAddr': instance.advAddr,
//       'gattSupported': instance.gattSupported,
//       'advAddrType': instance.advAddrType,
//       'rssi': instance.rssi,
//       'uuid': instance.uuid,
//       'address': instance.address,
//       'deviceKey': instance.deviceKey,
//       'networkKey': instance.networkKey,
//       'appKey': instance.appKey,
//       'numberOfElements': instance.numberOfElements,
//       'elementAddress': instance.elementAddress,
//       'devKeyHandle': instance.devKeyHandle,
//       'addressHandle': instance.addressHandle,
//       'cid': instance.cid,
//       'pid': instance.pid,
//       'vid': instance.vid,
//       'crpl': instance.crpl,
//       'relay': instance.relay,
//       'proxy': instance.proxy,
//       'friends': instance.friends,
//       'lowPower': instance.lowPower,
//       'loc': instance.loc,
//       'models': instance.models,
//       'effects': instance.effects,
//       'bindModels': instance.bindModels,
//       'public': instance.public,
//       'hubConfig': instance.hubConfig,
//     };
