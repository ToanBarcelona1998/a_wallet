import 'package:data/core/base_response.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:a_wallet/src/application/provider/service/api_service_path.dart';
import 'package:retrofit/http.dart';

part 'nft_service_impl.g.dart';

final class NftServiceImpl implements NftService {
  final NFTServiceGenerator _nftServiceGenerator;

  const NftServiceImpl(this._nftServiceGenerator);

  @override
  Future<XWalletBaseResponseV2> queryNFTDetail(Map<String, dynamic> body) {
    // TODO: implement queryNFTDetail
    throw UnimplementedError();
  }

  @override
  Future<XWalletBaseResponseV2> queryNFTs(Map<String, dynamic> body) {
    return _nftServiceGenerator.queryNFTs(body);
  }
}

@RestApi()
abstract class NFTServiceGenerator {
  factory NFTServiceGenerator(
    Dio dio, {
    String? baseUrl,
  }) = _NFTServiceGenerator;
  
  @POST(ApiServicePath.graphiql)
  Future<XWalletBaseResponseV2> queryNFTs(@Body() Map<String, dynamic> body);
}
