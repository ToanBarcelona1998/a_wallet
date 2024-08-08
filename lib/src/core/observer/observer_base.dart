abstract class ObserverBase<T,P> {
  final List<T> _listeners = List.empty(growable: true);
  List<T> get listeners => _listeners;

  void addListener(T listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(T listener){
    if (_listeners.contains(listener)) {
      _listeners.remove(listener);
    }
  }

  void clear(){
    _listeners.clear();
  }

  void emit({required P emitParam});
}
