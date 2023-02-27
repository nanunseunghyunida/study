import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/model/webtoon_detail_model.dart';
import 'package:toonflix/model/webtoon_episode_model.dart';
import 'package:toonflix/model/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  static const String episode = "episode";

  // await를 사용하기 위해선 해당 함수가 async 함수가 되어야함
  // async 함수로 지정하면 return type은 future
  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');

    // http.get의 반환 타입은 Future<Response>임
    // Future는 제네릭 안에 있는 타입이 나중에 반환된다는 의미
    // dart는 기본적으로 비동기 처리가 되기 때문에 http.get 함수를 실행 후 바로 다음 명령을 실행함
    // await를 앞에 붙여주면 response가 올 때 까지 기다림 (동기식)
    // await가 없으면 response의 타입은 Future<Response>, await를 붙이면 response의 타입은 Response
    final response = await http.get(url);

    List<WebtoonModel> webtoonInstances = [];

    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesById(String id) async {
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    List<WebtoonEpisodeModel> episodesInstances = [];

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
