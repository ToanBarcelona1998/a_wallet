final class NFTInformation {
  final int id;
  final String tokenId;
  final NFTMediaInfo mediaInfo;
  final int lastUpdatedHeight;
  final DateTime createdAt;
  final NFTCW721Contract cw721Contract;

  const NFTInformation({
    required this.id,
    required this.tokenId,
    required this.mediaInfo,
    required this.lastUpdatedHeight,
    required this.createdAt,
    required this.cw721Contract,
  });
}

final class NFTMediaInfo {
  final NFTOnChainMediaInfo onChain;
  final NFTOffChainMediaInfo offChain;

  const NFTMediaInfo({
    required this.onChain,
    required this.offChain,
  });
}

final class NFTOnChainMediaInfo {
  final String? tokenUri;
  final NFTOnChainMediaInfoMetadata? metadata;

  const NFTOnChainMediaInfo({
    required this.tokenUri,
    this.metadata,
  });
}

final class NFTOnChainMediaInfoMetadata {
  final String name;
  final String description;

  const NFTOnChainMediaInfoMetadata({
    required this.name,
    required this.description,
  });
}

final class NFTOffChainMediaInfo {
  final NFTImageInfo image;
  final NFTAnimationInfo? animation;

  const NFTOffChainMediaInfo({
    required this.image,
    this.animation,
  });
}

final class NFTImageInfo {
  final String? url;
  final String? contentType;

  const NFTImageInfo({
    this.url,
    this.contentType,
  });
}

final class NFTAnimationInfo {
  final String? url;
  final String? contentType;

  const NFTAnimationInfo({this.url, this.contentType});
}

final class NFTCW721Contract {
  final String name;
  final String symbol;
  final NFTSmartContract smartContract;

  const NFTCW721Contract({
    required this.name,
    required this.symbol,
    required this.smartContract,
  });
}

final class NFTSmartContract {
  final String address;

  const NFTSmartContract({
    required this.address,
  });
}
