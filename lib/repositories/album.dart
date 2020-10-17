import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/album.dart';
import 'package:flutter/foundation.dart';

class AlbumRepository {
  Future<AlbumModel> get({
    @required int id,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/album/$id",
    );

    return AlbumModel.fromJson(response["data"]);
  }
}
