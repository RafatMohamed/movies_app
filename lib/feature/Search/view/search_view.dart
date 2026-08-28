import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_assets.dart';
import 'package:movies_app/feature/Search/view/widgets/custom_text_field.dart';
import '../../../core/utilities/app_padding.dart';
import '../../../core/widgets/custom_movie_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String>? moviesResult ;

  void onSubmittedSearch(String query) async{
    setState(() {
      if (query.trim().isEmpty) {
        moviesResult = null;
        return;
      } else {
        moviesResult = [
          "assets/images/png/onBoarding1.png",
          "assets/images/png/onBoarding1.png",
          "assets/images/png/onBoarding1.png",
        ];
      }
    });
  }
  void clearSearch() {
    onSubmittedSearch("");
  }
  @override
  Widget build(BuildContext context) {
     return SafeArea(
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p16),
             child: CustomTextField(
               onSubmitted: onSubmittedSearch,
               onClear:(p0) {
                 clearSearch();
               } ,
             ),
           ),
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(AppPadding.p16),
               child: moviesResult==null ? Center(
                 child: Image.asset(
                   AppAssets.emptyMoviesImage,
                   fit: .scaleDown,
                   alignment: .center,
                 ),
               ):GridView.builder(
                 padding: .zero,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: .7,
                   crossAxisSpacing: AppPadding.p20,
                   mainAxisSpacing: AppPadding.p16,
                 ),
                 itemCount: moviesResult!.length,
                 physics: const BouncingScrollPhysics(),
                 shrinkWrap: true,
                 itemBuilder: (context, index) {
                   return CustomMovieCard(
                     pathImage: moviesResult![index],
                     rate: "5",
                   );
                 },
               ),
             ),
           ),
         ],
       ),
     );
  }
}
