import 'package:domain/src/entities/browser.dart';
import 'package:domain/src/entities/request/add_browser_parameter.dart';
import 'package:domain/src/entities/request/update_browser_parameter.dart';
import 'package:domain/src/repository/browser_management_repository.dart';

final class BrowserManagementUseCase {
  final BrowserManagementRepository _browserManagementRepository;

  const BrowserManagementUseCase(this._browserManagementRepository);

  Future<Browser> add(AddBrowserParameter param){
    return _browserManagementRepository.add(param);
  }

  Future<void> delete(int id){
    return _browserManagementRepository.delete(id);
  }

  Future<Browser> update(UpdateBrowserParameter param){
    return _browserManagementRepository.update(param);
  }

  Future<Browser?> get(int id){
    return _browserManagementRepository.get(id);
  }

  Future<List<Browser>> getAll(){
    return _browserManagementRepository.getAll();
  }

  Future<void> deleteAll(){
    return _browserManagementRepository.deleteAll();
  }

  Future<Browser?> getActiveBrowser() {
    return _browserManagementRepository.getActiveBrowser();
  }
}