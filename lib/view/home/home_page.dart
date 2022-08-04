import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testvalley/widgets/app_bar/home_app_bar.dart';
import 'package:testvalley/widgets/layout/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: HomeAppBar(
        title: const Text('테스트벨리'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 40.0,
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFDDDDDD),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF121212),
                ),
                hintText: '살까말까 고민된다면 검색해보세요!',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                Text(
                  '인기 검색어',
                  style: GoogleFonts.notoSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  height: 32.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ActionChip(
                      label: Text('label'),
                      backgroundColor: const Color(0xFFF7F7F7),
                      elevation: 0,
                      onPressed: () {},
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 9.0,
                    ),
                    itemCount: 4,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
