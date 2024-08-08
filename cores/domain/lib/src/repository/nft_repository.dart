import 'package:domain/src/entities/nft.dart';
import 'package:domain/src/entities/request/query_nft_request.dart';

abstract interface class NftRepository {
  Future<List<NFTInformation>> queryNFTs(
    QueryNftRequest request,
  );

  Future<NFTInformation> queryNFTDetail();
}
