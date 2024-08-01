import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:a_wallet/src/application/provider/service/nft/nft_service_impl.dart';

NftUseCase nftUseCaseFactory(Dio dio) {
  return NftUseCase(
    NftRepositoryImpl(
      NftServiceImpl(
        NFTServiceGenerator(dio),
      ),
    ),
  );
}
