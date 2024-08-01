import 'package:data/src/dto/browser_dto.dart';

import 'local_database_service.dart';

abstract interface class BrowserDatabaseService
    implements LocalDatabaseService<BrowserDto> {
  Future<BrowserDto?> getActiveBrowser();
}
