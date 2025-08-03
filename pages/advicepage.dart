import 'package:flutter/material.dart';
import 'videotipspage.dart';

class Advicepage extends StatefulWidget {
const Advicepage({super.key});

@override
State<Advicepage> createState() => _AdvicePageState();
}
class _AdvicePageState extends State<Advicepage> {
int? expandedIndex;

final List<Map<String, dynamic>> adviceList = [
{
'title': 'افصل الأجهزة غير المستخدمة من الكهرباء',
'detail':
'تأكد من فصل الأجهزة الكهربائية عند عدم استخدامها لتجنب استهلاك الكهرباء بدون فائدة',
'color': const Color(0xFFFF1BB3),
},
{
'title': 'استخدم الإضاءة الموفرة للطاقة ',
'detail':
'الإضاءة LED توفر طاقة أكثر بكثير مقارنة بالأنواع التقليدية وتدوم لفترة أطول',
'color': const Color(0xFFC451C9),
},
{
'title': 'لا تترك المكيف يعمل دون داعي',
'detail': 'قم بإطفاء المكيف عندما لا تكون في الغرفة لتقليل استهلاك الكهرباء',
'color': const Color(0xFFFF1BB3),
},
{
'title': 'اختَر أجهزة بكفاءة طاقة عالية',
'detail':
'الأجهزة ذات كفاءة الطاقة العالية تستهلك كهرباء أقل وتوفر عليك التكاليف',
'color': const Color(0xFFC451C9),
},
{
'title': 'استخدم الغسالة وقت الحمل الكامل فقط',
'detail':
'تشغيل الغسالة مع حمولة كاملة يقلل من عدد مرات التشغيل وبالتالي يوفّر الكهرباء',
'color': const Color(0xFFFF1BB3),
},
];

@override
Widget build(BuildContext context) {
return SafeArea(
child: Scaffold(
body: Container(
color: const Color.fromARGB(255, 6, 3, 27),
child: OrientationBuilder(
builder: (context, orientation) {
return Stack(
children: [
Positioned(
top: 30,
left: 20,
child: IconButton(
icon: const Icon(Icons.arrow_back,
color: Colors.white, size: 30),
onPressed: () {
Navigator.pop(context);
},
),
),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 24),
child: orientation == Orientation.portrait
? buildPortraitLayout()
: buildLandscapeLayout(),
),
],
);
},
),
),
),
);
}

Widget buildPortraitLayout() {
return Column(
children: [
const SizedBox(height: 100),
const Text(
"نصائح لتوفير الكهرباء",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
color: Colors.white,
fontFamily: "myfont2",
),
textAlign: TextAlign.center,
),
const SizedBox(height: 30),
Expanded(child: buildAdviceList()),
const SizedBox(height: 10),
TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (_) => const VideoTipsPage()),
);
},
child: const Text(
"🎥 شاهد فيديو توعوي",
style: TextStyle(
fontSize: 16,
color: Colors.white,
fontFamily: "myfont2",
),
),
),
const SizedBox(height: 80),
],
);
}

Widget buildLandscapeLayout() {
return Row(
children: [
Expanded(
flex: 4,
child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
const SizedBox(height: 60),
const Text(
"نصائح لتوفير الكهرباء",
style: TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
color: Colors.white,
fontFamily: "myfont2",
),
textAlign: TextAlign.right,
),
const SizedBox(height: 20),
TextButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (_) => const VideoTipsPage()),
);
},
child: const Text(
"🎥 شاهد فيديو توعوي",
style: TextStyle(
fontSize: 16,
color: Colors.white,
fontFamily: "myfont2",
),
),
),
],
),
),
const SizedBox(width: 20),
Expanded(
flex: 6,
child: buildAdviceList(),
),
],
);
}

Widget buildAdviceList() {
return ListView.builder(
itemCount: adviceList.length,
itemBuilder: (context, index) {
final item = adviceList[index];
final isExpanded = index == expandedIndex;
return AdviceExpandableBox(
title: item['title'],
detail: item['detail'],
color: item['color'],
isExpanded: isExpanded,
onTap: () {
setState(() {
expandedIndex = isExpanded ? null : index;
});
},
);
},
);
}
}

class AdviceExpandableBox extends StatefulWidget {
final String title;
final String detail;
final Color color;
final bool isExpanded;
final VoidCallback onTap;

const AdviceExpandableBox({
super.key,
required this.title,
required this.detail,
required this.color,
required this.isExpanded,
required this.onTap,
});

@override
State<AdviceExpandableBox> createState() => _AdviceExpandableBoxState();
}

class _AdviceExpandableBoxState extends State<AdviceExpandableBox>
with SingleTickerProviderStateMixin {
late AnimationController _controller;
late Animation<double> _iconRotation;

@override
void initState() {
super.initState();
_controller =
AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
_iconRotation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
}

@override
void didUpdateWidget(covariant AdviceExpandableBox oldWidget) {
super.didUpdateWidget(oldWidget);
if (widget.isExpanded) {
_controller.forward();
} else {
_controller.reverse();
}
}

@override
void dispose() {
_controller.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Container(
margin: const EdgeInsets.symmetric(vertical: 8),
decoration: BoxDecoration(
color: const Color.fromARGB(160, 40, 40, 40),
borderRadius: BorderRadius.circular(12),
),
child: Column(
children: [
InkWell(
borderRadius: BorderRadius.circular(12),
onTap: widget.onTap,
child: Padding(
padding:
const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
child: Row(
children: [
Expanded(
child: Text(
widget.title,
textAlign: TextAlign.right,
style: const TextStyle(
color: Colors.white,
fontSize: 16,
fontFamily: "myfont2",
),
),
),
RotationTransition(
turns: _iconRotation,
child: Icon(
Icons.keyboard_arrow_down,
color: widget.color,
size: 28,
),
),
],
),
),
),
if (widget.isExpanded)
Padding(
padding:
const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
child: Text(
widget.detail,
textAlign: TextAlign.right,
style: const TextStyle(
color: Colors.white70,
fontSize: 14,
fontFamily: "myfont2",
),
),
),
],
),
);
}
}
