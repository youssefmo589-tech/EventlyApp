import 'package:eventlyapp/MODELS/CategoryData.dart';
import 'package:flutter/material.dart';

import '../core/gen/assets.gen.dart';

class CategoryDataSource {
  static final List<CategoryData> Categories = [
    CategoryData(
      id: "1",
      name: "Sport",
      image: Assets.images.sport1.path,
      icon: Icons.directions_bike_outlined,
      darkimage: Assets.images.sportDark.path,
    ),

    CategoryData(
      id: "2",
      name: "BirhDay",
      image: Assets.images.birthday1.path,
      icon: Icons.cake_outlined,
      darkimage: Assets.images.birthdaydark.path,
    ),

    CategoryData(
      id: "3",
      name: "Book Club",
      image: Assets.images.bookClub1.path,
      icon: Icons.chrome_reader_mode_outlined,
      darkimage: Assets.images.bookClubDark.path,
    ),

    CategoryData(
      id: "4",
      name: "Metting",
      image: Assets.images.meeting1.path,
      icon: Icons.meeting_room_outlined,
      darkimage: Assets.images.meetingDark.path,
    ),

    CategoryData(
      id: "5",
      name: "Exhibition",
      image: Assets.images.exhibition1.path,
      icon: Icons.meeting_room_outlined,
      darkimage: Assets.images.exhibitionDark.path,
    ),
  ];

  static CategoryData getcategorybuid(String categoryID) {
    return Categories.firstWhere((element) => element.id == categoryID);
  }
}
