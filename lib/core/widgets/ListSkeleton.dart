import 'package:flutter/material.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) => const _SkeletonRow(),
    );
  }
}

class _SkeletonRow extends StatefulWidget {
  const _SkeletonRow();

  @override
  State<_SkeletonRow> createState() => _SkeletonRowState();
}

class _SkeletonRowState extends State<_SkeletonRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat(reverse: true);

  late final Animation<double> _opacity = Tween(begin: 0.3, end: 0.7).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _bar(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ListTile(
        title: Align(alignment: Alignment.centerLeft, child: _bar(90, 14)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Align(alignment: Alignment.centerLeft, child: _bar(140, 12)),
        ),
        trailing: _bar(50, 12),
      ),
    );
  }
}