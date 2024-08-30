import 'package:flutter/material.dart';
import 'package:smart_farm_phone/common/const/colors.dart';
import 'package:smart_farm_phone/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '스마트팜',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Container(child: Text('재배관리')),
          Container(child: Text('장치관리')),
          Container(child: Text('CCTV')),
          Container(child: Text('설정')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: BUTTON_COLOR,
        unselectedItemColor: WHITE_TEXT_COLOR,
        backgroundColor: SUB_COLOR,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '재배관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.device_hub_outlined),
            label: '장치관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_indoor_outlined),
            label: 'CCTV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
