import 'package:flutter/material.dart';

const Color kVoidColor = Color(0xFF060612);
const Color kSurfaceColor = Color(0x08FFFFFF);
const Color kBorderColor = Color(0x1F00F5D4);
const Color kBorderStrong = Color(0x4000F5D4);
const Color kTextColor = Color(0xFFEEF0FF);
const Color kMutedColor = Color(0x73B4B9FF);
const Color kMutedFaint = Color(0x40B4B9FF);
const Color kCyanColor = Color(0xFF00F5D4);
const Color kVioletColor = Color(0xFF9D4EDD);
const Color kLimeColor = Color(0xFFB5FF5A);
const Color kCoralColor = Color(0xFFFF4F6D);

class TrackerShell extends StatelessWidget {
  const TrackerShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.3,
          colors: <Color>[Color(0xFF132137), kVoidColor],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kVoidColor,
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: const Color(0x2E00F5D4)),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color(0x66000000),
                      blurRadius: 40,
                      offset: Offset(0, 24),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Stack(
                    children: <Widget>[
                      const Positioned.fill(child: _GridGlow()),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 1,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 44,
                              ),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.transparent,
                                    kCyanColor,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: kMutedColor,
            fontSize: 9,
            letterSpacing: 1.8,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[Color(0x3300F5D4), Colors.transparent],
              ),
            ),
            child: SizedBox(height: 1),
          ),
        ),
      ],
    );
  }
}

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: kMutedFaint,
            fontSize: 10,
            letterSpacing: 1.1,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class _GridGlow extends StatelessWidget {
  const _GridGlow();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridGlowPainter());
  }
}

class _GridGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 20.0;
    final paint = Paint()
      ..color = const Color(0x0A00F5D4)
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height * 0.32), paint);
    }
    for (double y = 0; y <= size.height * 0.32; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
