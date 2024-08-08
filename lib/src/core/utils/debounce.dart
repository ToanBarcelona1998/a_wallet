import 'dart:async';

typedef DenounceObserver<T> = void Function(T value);

final class Denounce<T>{
  final Duration _duration;

  Denounce(this._duration);

  Timer ?_timer;

  final List<DenounceObserver<T>> _observers = List.empty(growable: true);

  void addObserver(DenounceObserver<T> observer){
    if(!_observers.contains(observer)){
      _observers.add(observer);
    }
  }

  void removeObserver(DenounceObserver<T> observer){
    if(_observers.contains(observer)){
      _observers.remove(observer);
    }
  }

  void onDenounce(T value){
    disPose();

    _timer = Timer(_duration, () {
      _broadCast(value);
    });
  }

  void disPose(){
    if(_timer?.isActive ?? false){
      _timer?.cancel();
    }
  }

  void _broadCast(T value){
    for(final observer in _observers){
      observer(value);
    }
  }

}
