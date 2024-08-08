import 'package:data/core/base_response.dart';

abstract interface class NftService {
  Future<XWalletBaseResponseV2> queryNFTs(
    Map<String, dynamic> body,
  );

  Future<XWalletBaseResponseV2> queryNFTDetail(Map<String,dynamic> body);
}
