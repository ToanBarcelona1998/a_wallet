import 'package:data/core/base_response.dart';

abstract interface class NftService {
  Future<AuraBaseResponseV2> queryNFTs(
    Map<String, dynamic> body,
  );

  Future<AuraBaseResponseV2> queryNFTDetail(Map<String,dynamic> body);
}
