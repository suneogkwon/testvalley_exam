part of '../product_detail_page.dart';

class CommonInfoList extends StatefulWidget {
  const CommonInfoList({Key? key}) : super(key: key);

  @override
  State<CommonInfoList> createState() => _CommonInfoListState();
}

class _CommonInfoListState extends State<CommonInfoList> {
  final List<String> menus = [
    '구매시 주의사항',
    '상품결제 정보',
    '배송정보',
    '교환 및 반품정보',
  ];
  int openedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          openedIndex = panelIndex == openedIndex ? -1 : panelIndex;
        });
      },
      expandedHeaderPadding: EdgeInsets.zero,
      children: List.generate(
        menus.length,
        (index) => ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.centerLeft,
              child: Text(menus[index]),
            );
          },
          body: Container(
            height: 100,
          ),
          isExpanded: index == openedIndex,
        ),
      ),
    );
  }
}
