import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_model_view_model.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/staggered_serias.dart';

class CarModelItem extends StatelessWidget {
  final CarModelViewModel model;
  final int index;
  final int totalCount;
  final bool isOpen;
  final VoidCallback onTap;
  final Future<void> Function() onHideCompleted;
  final void Function(String seria)? onSeriaTap;

  const CarModelItem({
    super.key,
    required this.model,
    required this.index,
    required this.totalCount,
    required this.isOpen,
    required this.onTap,
    required this.onHideCompleted,
    this.onSeriaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              model.name,
              style: TextStyle(
                color: isOpen ? Colors.blue : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (model.serias.isNotEmpty)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: isOpen 
                  ? Padding(
                      key: ValueKey('serias_$index'),
                      padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                      child: StaggeredSerias(
                        serias: model.serias,
                        open: isOpen,
                        onHideCompleted: onHideCompleted,
                      ),
                    )
                  : SizedBox(
                      key: ValueKey('empty_$index'),
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
        if (index != totalCount - 1)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(-0.2, 0),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              );
            },
            child: !isOpen 
                ? const Padding(
                    key: ValueKey('divider_visible'),
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.1,
                    ),
                  )
                : const SizedBox(
                    key: ValueKey('divider_hidden'),
                    height: 0,
                  ),
          ),
      ],
    );
  }
}
