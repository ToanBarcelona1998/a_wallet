import 'package:domain/domain.dart';

extension NFTInformationDtoMapper on NFTInformationDto {
  NFTInformation get toEntity {
    return NFTInformation(
      id: id,
      tokenId: tokenId,
      mediaInfo: mediaInfo.toEntity,
      lastUpdatedHeight: lastUpdatedHeight,
      createdAt: createdAt,
      cw721Contract: cw721Contract.toEntity,
    );
  }
}

extension NFTMediaInfoDtoMapper on NFTMediaInfoDto {
  NFTMediaInfo get toEntity {
    return NFTMediaInfo(
      onChain: onChain.toEntity,
      offChain: offChain.toEntity,
    );
  }
}

extension NFTOnChainMediaInfoDtoMapper on NFTOnChainMediaInfoDto {
  NFTOnChainMediaInfo get toEntity {
    return NFTOnChainMediaInfo(
      tokenUri: tokenUri,
      metadata: metadataDto?.toEntity,
    );
  }
}

extension NFTOnChainMediaInfoMetadataDtoMapper
    on NFTOnChainMediaInfoMetadataDto {
  NFTOnChainMediaInfoMetadata get toEntity => NFTOnChainMediaInfoMetadata(
        name: name,
        description: description,
      );
}

extension NFTOffChainMediaInfoDtoMapper on NFTOffChainMediaInfoDto {
  NFTOffChainMediaInfo get toEntity {
    return NFTOffChainMediaInfo(
      image: image.toEntity,
      animation: animation?.toEntity,
    );
  }
}

extension NFTImageInfoDtoMapper on NFTImageInfoDto {
  NFTImageInfo get toEntity {
    return NFTImageInfo(
      url: url,
      contentType: contentType,
    );
  }
}

extension NFTAnimationInfoDtoMapper on NFTAnimationInfoDto {
  NFTAnimationInfo get toEntity {
    return NFTAnimationInfo(
      url: url,
      contentType: contentType,
    );
  }
}

extension CW721ContractDtoMapper on NFTCW721ContractDto {
  NFTCW721Contract get toEntity {
    return NFTCW721Contract(
      name: name,
      symbol: symbol,
      smartContract: smartContract.toEntity,
    );
  }
}

extension NFTSmartContractDtoMapper on NFTSmartContractDto {
  NFTSmartContract get toEntity {
    return NFTSmartContract(
      address: address,
    );
  }
}

final class NFTInformationDto {
  final int id;
  final String tokenId;
  final NFTMediaInfoDto mediaInfo;
  final int lastUpdatedHeight;
  final DateTime createdAt;
  final NFTCW721ContractDto cw721Contract;

  const NFTInformationDto({
    required this.id,
    required this.tokenId,
    required this.mediaInfo,
    required this.lastUpdatedHeight,
    required this.createdAt,
    required this.cw721Contract,
  });

  factory NFTInformationDto.fromJson(Map<String, dynamic> json) {
    return NFTInformationDto(
      id: json['id'],
      tokenId: json['token_id'],
      mediaInfo: NFTMediaInfoDto.fromJson(
        json['media_info'],
      ),
      lastUpdatedHeight: json['last_updated_height'],
      createdAt: DateTime.parse(
        json['created_at'],
      ),
      cw721Contract: NFTCW721ContractDto.fromJson(
        json['cw721_contract'],
      ),
    );
  }
}

final class NFTMediaInfoDto {
  final NFTOnChainMediaInfoDto onChain;
  final NFTOffChainMediaInfoDto offChain;

  const NFTMediaInfoDto({
    required this.onChain,
    required this.offChain,
  });

  factory NFTMediaInfoDto.fromJson(Map<String, dynamic> json) {
    return NFTMediaInfoDto(
      onChain: NFTOnChainMediaInfoDto.fromJson(
        json['onchain'],
      ),
      offChain: NFTOffChainMediaInfoDto.fromJson(
        json['offchain'],
      ),
    );
  }
}

final class NFTOnChainMediaInfoDto {
  final String? tokenUri;
  final NFTOnChainMediaInfoMetadataDto? metadataDto;

  const NFTOnChainMediaInfoDto({
    required this.tokenUri,
    this.metadataDto,
  });

  factory NFTOnChainMediaInfoDto.fromJson(Map<String, dynamic> json) {
    return NFTOnChainMediaInfoDto(
      tokenUri: json['token_uri'],
      metadataDto: json['metadata'] != null
          ? NFTOnChainMediaInfoMetadataDto.fromJson(
              json['metadata'],
            )
          : null,
    );
  }
}

final class NFTOnChainMediaInfoMetadataDto {
  final String name;
  final String description;

  const NFTOnChainMediaInfoMetadataDto({
    required this.name,
    required this.description,
  });

  factory NFTOnChainMediaInfoMetadataDto.fromJson(Map<String, dynamic> json) {
    return NFTOnChainMediaInfoMetadataDto(
      name: json['name'],
      description: json['description'],
    );
  }
}

final class NFTOffChainMediaInfoDto {
  final NFTImageInfoDto image;
  final NFTAnimationInfoDto? animation;

  const NFTOffChainMediaInfoDto({
    required this.image,
    this.animation,
  });

  factory NFTOffChainMediaInfoDto.fromJson(Map<String, dynamic> json) {
    return NFTOffChainMediaInfoDto(
      image: NFTImageInfoDto.fromJson(
        json['image'],
      ),
      animation: json['animation'] != null
          ? NFTAnimationInfoDto.fromJson(
              json['animation'],
            )
          : null,
    );
  }
}

final class NFTImageInfoDto {
  final String? url;
  final String? contentType;

  const NFTImageInfoDto({
    this.url,
    this.contentType,
  });

  factory NFTImageInfoDto.fromJson(Map<String, dynamic> json) {
    return NFTImageInfoDto(
      url: json['url'],
      contentType: json['content_type'],
    );
  }
}

final class NFTAnimationInfoDto {
  final String? url;
  final String? contentType;

  const NFTAnimationInfoDto({this.url, this.contentType});

  factory NFTAnimationInfoDto.fromJson(Map<String, dynamic> json) {
    return NFTAnimationInfoDto(
      url: json['url'],
      contentType: json['content_type'],
    );
  }
}

final class NFTCW721ContractDto {
  final String name;
  final String symbol;
  final NFTSmartContractDto smartContract;

  const NFTCW721ContractDto({
    required this.name,
    required this.symbol,
    required this.smartContract,
  });

  factory NFTCW721ContractDto.fromJson(Map<String, dynamic> json) {
    return NFTCW721ContractDto(
      name: json['name'],
      symbol: json['symbol'],
      smartContract: NFTSmartContractDto.fromJson(json['smart_contract']),
    );
  }
}

final class NFTSmartContractDto {
  final String address;

  const NFTSmartContractDto({
    required this.address,
  });

  factory NFTSmartContractDto.fromJson(Map<String, dynamic> json) {
    return NFTSmartContractDto(
      address: json['address'],
    );
  }
}
