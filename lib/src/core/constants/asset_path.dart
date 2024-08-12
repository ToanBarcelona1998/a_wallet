const String _baseAsset = 'assets/';

sealed class AssetLanguagePath{
  static const String _languagePath = '${_baseAsset}language/';

  static String localizationFullPath(String locale){
    return '$_languagePath$locale.json';
  }

  static String defaultLocalizationFullPath = localizationFullPath('vi');
}

sealed class AssetConfigPath{
  static const String config = '${_baseAsset}config/config.json';
  static const String configDev = '${_baseAsset}config/config.dev.json';
  static const String configStaging = '${_baseAsset}config/config.staging.json';
}

sealed class AssetLogoPath {
  static const String _baseLogoPath = '${_baseAsset}logo/';
  static const String logo = '${_baseLogoPath}logo.svg';
  static const String logo2 = '${_baseLogoPath}logo_2.svg';
}

sealed class AssetImagePath {
  static const String _baseImgPath = '${_baseAsset}image/';

  static const String yetiBot = '${_baseImgPath}img_yeti_bot.svg';


  static const String defaultAvatar1 = '${_baseImgPath}img_default_avatar1.jpeg';
  static const String defaultAvatar2 = '${_baseImgPath}img_default_avatar2.jpeg';
  static const String defaultAvatar3 = '${_baseImgPath}img_default_avatar3.jpeg';
}

sealed class AssetIconPath {
  static const String _baseIconPath = '${_baseAsset}icon/';

  static const String icCommonArrowBack = '${_baseIconPath}ic_common_arrow_back.svg';
  static const String icCommonClear = '${_baseIconPath}ic_common_clear.svg';
  static const String icCommonYetiHand = '${_baseIconPath}ic_common_yeti_hand.svg';
  static const String icCommonInputError = '${_baseIconPath}ic_common_input_error.svg';
  static const String icCommonClose = '${_baseIconPath}ic_common_close.svg';
  static const String icCommonPaste = '${_baseIconPath}ic_common_paste.svg';
  static const String icCommonCopy = '${_baseIconPath}ic_common_copy.svg';
  static const String icCommonCheckSuccess = '${_baseIconPath}ic_common_check_success.svg';
  static const String icCommonGoogle = '${_baseIconPath}ic_common_google.svg';
  static const String icCommonTwitter = '${_baseIconPath}ic_common_twitter.svg';
  static const String icCommonApple = '${_baseIconPath}ic_common_apple.svg';
  static const String icCommonArrowDown = '${_baseIconPath}ic_common_arrow_down.svg';
  static const String icCommonEye = '${_baseIconPath}ic_common_eye.svg';
  static const String icCommonEyeClose = '${_baseIconPath}ic_common_eye_close.svg';
  static const String icCommonScan = '${_baseIconPath}ic_common_scan.svg';
  static const String icCommonReceive = '${_baseIconPath}ic_common_receive.svg';
  static const String icCommonSend = '${_baseIconPath}ic_common_send.svg';
  static const String icCommonSwap = '${_baseIconPath}ic_common_swap.svg';
  static const String icCommonStake = '${_baseIconPath}ic_common_stake.svg';
  static const String icCommonAWallet = '${_baseIconPath}ic_common_a_wallet.svg';
  static const String icCommonContact = '${_baseIconPath}ic_common_contact.svg';
  static const String icCommonArrowNext = '${_baseIconPath}ic_common_arrow_next.svg';
  static const String icCommonDownloadImage = '${_baseIconPath}ic_common_download_image.svg';
  static const String icCommonQr = '${_baseIconPath}ic_common_qr.svg';
  static const String icCommonShare = '${_baseIconPath}ic_common_share.svg';
  static const String icCommonFeeEdit = '${_baseIconPath}ic_common_edit_fee.svg';
  static const String icCommonSearch = '${_baseIconPath}ic_common_search.svg';
  static const String icCommonSignMessage = '${_baseIconPath}ic_common_sign_message.svg';
  static const String icCommonViewHash = '${_baseIconPath}ic_common_view_hash.svg';
  static const String icCommonAdd = '${_baseIconPath}ic_common_add.svg';
  static const String icCommonInformation = '${_baseIconPath}ic_common_information.svg';
  static const String icCommonFilter = '${_baseIconPath}ic_common_filter.svg';
  static const String icCommonDelete = '${_baseIconPath}ic_common_delete.svg';
  static const String icCommonMore = '${_baseIconPath}ic_common_more.svg';
  static const String icCommonRefresh = '${_baseIconPath}ic_common_refresh.svg';
  static const String icCommonLock = '${_baseIconPath}ic_common_lock.svg';
  static const String icCommonEdit = '${_baseIconPath}ic_common_edit.svg';
  static const String icCommonAddressBook = '${_baseIconPath}ic_common_address_book.svg';
  static const String icCommonLanguage = '${_baseIconPath}ic_common_language.svg';

  static const String icHomeScreenBottomNavigationBarBrowser = '${_baseIconPath}ic_home_screen_bottom_navigation_bar_browser.svg';
  static const String icHomeScreenBottomNavigationBarWallet = '${_baseIconPath}ic_home_screen_bottom_navigator_bar_wallet.svg';
  static const String icHomeScreenBottomNavigationBarHistory = '${_baseIconPath}ic_home_screen_bottom_navigation_bar_history.svg';
  static const String icHomeScreenBottomNavigationBarSetting= '${_baseIconPath}ic_home_screen_bottom_navigation_bar_setting.svg';
  static const String icHomeScreenBottomNavigationBarHome= '${_baseIconPath}ic_home_screen_bottom_navigation_bar_home.svg';

  static const String icCommonConfirmViewMessage = '${_baseIconPath}ic_common_confirm_view_message.svg';

  /// Scanner
  static const String icScannerBack = '${_baseIconPath}ic_scanner_back.svg';
  static const String icScannerPhoto = '${_baseIconPath}ic_scanner_photo.svg';

  /// Browser page
  static const String icBrowserEcosystem =
      '${_baseIconPath}ic_browser_ecosystem.svg';
  static const String icBrowserEcosystemWhite =
      '${_baseIconPath}ic_browser_ecosystem_white.svg';

  /// Browser screen
  static const String icBrowserScreenBack = '${_baseIconPath}ic_browser_screen_back.svg';
  static const String icBrowserScreenBookmark = '${_baseIconPath}ic_browser_screen_bookmark.svg';
  static const String icBrowserScreenBookmarkActive = '${_baseIconPath}ic_browser_screen_bookmark_active.svg';
  static const String icBrowserScreenNext = '${_baseIconPath}ic_browser_screen_next.svg';
  static const String icBrowserScreenNextBold = '${_baseIconPath}ic_browser_screen_next_bold.svg';


  /// NFt screen
  static const String icNftScreenGrid = '${_baseIconPath}ic_nft_screen_grid.svg';
  static const String icNftScreenList = '${_baseIconPath}ic_nft_screen_list.svg';
}
