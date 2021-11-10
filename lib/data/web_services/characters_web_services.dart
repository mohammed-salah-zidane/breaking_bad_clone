import 'package:breaking_bad_clone/core/constants/strings.dart';
import 'package:breaking_bad_clone/data/models/character.dart';
import 'package:breaking_bad_clone/data/models/quote.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String name) async {
    try {
      Response response = await dio.get(
        'quote',
        queryParameters: {
          'author': name,
        },
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
