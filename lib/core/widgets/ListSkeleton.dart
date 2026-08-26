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

class DetailSkeleton extends StatefulWidget {
  const DetailSkeleton({super.key});

  @override
  State<DetailSkeleton> createState() => _DetailSkeletonState();
}

class _DetailSkeletonState extends State<DetailSkeleton>
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

  Widget _detailSkeletonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: _bar(100, 14),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _bar(120, 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bar(110, 16),
          const SizedBox(height: 12),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          const SizedBox(height: 20),
          _bar(120, 16),
          const SizedBox(height: 12),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          const SizedBox(height: 20),
          _bar(130, 16),
          const SizedBox(height: 12),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
          _detailSkeletonRow(),
        ],
      ),
    );
  }
}