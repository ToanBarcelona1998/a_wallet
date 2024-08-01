import 'package:data/src/dto/nft_dto.dart';
import 'package:data/src/dto/request/query_nft_request_dto.dart';
import 'package:data/src/resource/remote/nft_service.dart';
import 'package:domain/domain.dart';

final class NftRepositoryImpl implements NftRepository {
  final NftService _nftService;

  const NftRepositoryImpl(this._nftService);

  @override
  Future<NFTInformation> queryNFTDetail() {
    // TODO: implement queryNFTDetail
    throw UnimplementedError();
  }

  @override
  Future<List<NFTInformation>> queryNFTs(QueryNftRequest request) async {
    final response = await _nftService.queryNFTs(
      request.mapRequest.toMap(),
    );

    final data = response.handleResponse();

    final dataMaps = data[request.environment]['cw721_token'];

    final List<NFTInformationDto> nftSDto = [];

    for (final map in dataMaps) {
      final NFTInformationDto nft = NFTInformationDto.fromJson(map);

      nftSDto.add(nft);
    }

    return nftSDto
        .map(
          (e) => e.toEntity,
        )
        .toList();
  }
}
