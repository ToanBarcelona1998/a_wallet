import 'package:domain/src/entities/nft.dart';
import 'package:domain/src/entities/request/query_nft_request.dart';
import 'package:domain/src/repository/nft_repository.dart';

final class NftUseCase {
  final NftRepository _nftRepository;

  const NftUseCase(this._nftRepository);

  Future<List<NFTInformation>> queryNFTs(QueryNftRequest request){
    return _nftRepository.queryNFTs(request);
  }
}