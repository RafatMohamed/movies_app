import '../utilities/app_assets.dart';

class ImgProfileModel {
 final String imgPath;
 ImgProfileModel({required this.imgPath});


 static  List<ImgProfileModel> avatars = [
   ImgProfileModel(imgPath: AppAssets.person1),
   ImgProfileModel(imgPath: AppAssets.person2),
   ImgProfileModel(imgPath: AppAssets.person3),
   ImgProfileModel(imgPath: AppAssets.person4),
   ImgProfileModel(imgPath: AppAssets.person5),
   ImgProfileModel(imgPath: AppAssets.person6),
   ImgProfileModel(imgPath: AppAssets.person7),
   ImgProfileModel(imgPath: AppAssets.person8),
   ImgProfileModel(imgPath: AppAssets.person9),
 ];
}