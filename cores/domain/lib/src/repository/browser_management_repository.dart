import 'package:domain/src/entities/browser.dart';

import 'local_database_repository.dart';

abstract interface class BrowserManagementRepository implements LocalDatabaseRepository<Browser> {
  Future<Browser?> getActiveBrowser();
}
