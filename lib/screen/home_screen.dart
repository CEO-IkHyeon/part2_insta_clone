import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          StoryArea(),
          FeedList(),
        ],
      ),
    );
  }
}

class StoryArea extends StatelessWidget {
  const StoryArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          // 10개 유저를 생성하기 위해 list 활용
          children: List.generate(10, (index) => UserStory(userName: 'User ${index + 1}',),),
      ),
    );
  }
}

class UserStory extends StatelessWidget {
  final String userName;

  const UserStory({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          Text(userName),
        ],
      ),
    );
  }
}

class FeedData {
  final String userName;
  final int likeCount;
  final String content;

  FeedData(
      {required this.userName, required this.likeCount, required this.content});
}

final feedDataList = [
  FeedData(userName: 'User1', likeCount: 50, content: '오늘 점심은 제육볶음'),
  FeedData(userName: 'User2', likeCount: 10, content: '어제 점심은 햄버거'),
  FeedData(userName: 'User3', likeCount: 89, content: '오늘 저녁은 치킨이다'),
  FeedData(userName: 'User4', likeCount: 78, content: '오늘 공부하기 딱 좋은 날이네'),
  FeedData(
      userName: 'User5', likeCount: 1, content: '내가 flutter로 앱을 배포할 수 있을까'),
  FeedData(userName: 'User6', likeCount: 96, content: '제발 이번 프로젝트 성공했으면 좋겠다'),
  FeedData(userName: 'User7', likeCount: 53, content: '캡스톤 디자인까지 가면 좋겠다'),
  FeedData(userName: 'User8', likeCount: 34, content: '취업 가즈아!!!'),
  FeedData(userName: 'User9', likeCount: 11, content: '야 이게 맞냐 ㅋ'),
];

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  // 목작업 : 서버나 데베에서 데이터 가져올 정보를 클라에서 미리 만들어놓은 정보를 통해 미리 UI를 꾸미는 것

  @override
  Widget build(BuildContext context) {
    // feedDataList의 데이터를 기반으로 FeedItem 위젯의 ListView를 생성함
    // 목록은 하위 항목에 맞게 축소되어 스크롤 할 수 없다.
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //최대 몇 개까지 보여줄지 -> 에러 발생 가능
      itemCount: feedDataList.length,
      itemBuilder: (context, index) => FeedItem(feedData: feedDataList[index]),
    );
  }
}

class FeedItem extends StatelessWidget {
  final FeedData feedData;

  const FeedItem({required this.feedData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(feedData.userName),
                ],
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 280,
          color: Colors.indigo.shade300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            // 아이콘 3개와 북마크 아이콘 떨어뜨리기 위해서 3개, 1개로 묶고 또 Row로 wrap하고 둘 사이를 spaceBetween으로 떨구기
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.chat_bubble)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.paperplane)),
                ],
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(CupertinoIcons.bookmark)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '좋아요 ${feedData.likeCount}개',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: feedData.userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: feedData.content,
              ),
            ],
            style: TextStyle(
              color: Colors.black,
            ),
          )),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
