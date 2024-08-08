abstract class LocalDatabaseService<R> {
  Future<R> add<P>(P param);

  Future<void> delete(int id);

  Future<R> update<P>(P param);

  Future<R?> get(int id);

  Future<List<R>> getAll();

  Future<void> deleteAll();
}