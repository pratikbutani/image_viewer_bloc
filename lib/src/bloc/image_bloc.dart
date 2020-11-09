import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/image_api.dart';
import '../models/image_model.dart';

class ImageBloc {
  final ImageAPI api;

  Stream<List<Images>> _images = Stream.empty();

  ReplaySubject<String> _query = ReplaySubject<String>(maxSize: 3);

  Stream<List<Images>> get images => _images;

  Sink<String> get query => _query;

  ImageBloc(this.api) {
    _images = _query.asyncMap(api.makeRequest).asBroadcastStream();
  }

  void dispose() {
    _query.close();
  }
}
