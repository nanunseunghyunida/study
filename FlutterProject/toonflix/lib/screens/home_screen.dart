import 'package:flutter/material.dart';
import 'package:toonflix/model/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widget/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // FutureBuilder 사용시 StatelessWidget에서도 Future의 데이터 상태에 따라서 UI 변경 가능
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                width: 20,
              ),
              Text(
                "Today`s Webtoon",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
            future: webtoons,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 300,
                  child: makeList(snapshot),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                  strokeWidth: 10,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ListView.builder: ListView보다 더 많은 기능을 갖고있는 named constructor
  // Item의 갯수를 정하고 화면에 그려지지 않은 아이템들은 메모리에서 제거함 (Android의 recyclerview와 비슷한듯)

  // ListView.separated: ListView.builder + separatorBuilder
  // ListView의 item들 사이에 들어가는 위젯이 필수로 들어가야되는 named construtor
  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonWidget(webtoon: webtoon);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 35,
      ),
    );
  }
}
