import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';

import 'media_desktop.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate( desktop: MediaDesktopScreen(),);
  }
}