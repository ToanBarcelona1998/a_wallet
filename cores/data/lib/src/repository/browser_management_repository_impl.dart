import 'package:data/src/dto/browser_dto.dart';
import 'package:data/src/dto/request/add_browser_parameter_dto.dart';
import 'package:data/src/dto/request/update_browser_parameter_dto.dart';
import 'package:data/src/resource/local/browser_database_service.dart';
import 'package:domain/domain.dart';

final class BrowserManagementRepositoryImpl
    implements BrowserManagementRepository {
  final BrowserDatabaseService _browserDatabaseService;

  const BrowserManagementRepositoryImpl(this._browserDatabaseService);

  @override
  Future<Browser> add<P>(P param) async {
    final browserDto = await _browserDatabaseService.add(
      (param as AddBrowserParameter).mapRequest,
    );

    return browserDto.toEntity;
  }

  @override
  Future<void> delete(int id) {
    return _browserDatabaseService.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _browserDatabaseService.deleteAll();
  }

  @override
  Future<Browser?> get(int id) async{
    final browserDto = await _browserDatabaseService.get(id);

    return browserDto?.toEntity;
  }

  @override
  Future<Browser?> getActiveBrowser() async{
    final browserDto = await _browserDatabaseService.getActiveBrowser();

    return browserDto?.toEntity;
  }

  @override
  Future<List<Browser>> getAll() async{
    final browsersDto = await _browserDatabaseService.getAll();

    return browsersDto.map((e) => e.toEntity,).toList();
  }

  @override
  Future<Browser> update<P>(P param) async{
    final browserDto = await _browserDatabaseService.add(
      (param as UpdateBrowserParameter).mapRequest,
    );

    return browserDto.toEntity;
  }
}
