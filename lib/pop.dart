// import 'package:flutter/material.dart';

// class PopupMenuContainer<T> extends StatefulWidget {
//   final Widget child;
//   final List<PopupMenuEntry<T>> items;
//   final void Function(T) onItemSelected;

//   PopupMenuContainer(
//       {required this.child,
//       required this.items,
//       required this.onItemSelected,
//       Key? key})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => PopupMenuContainerState<T>();
// }

// class PopupMenuContainerState<T> extends State<PopupMenuContainer<T>> {
//   Offset _tapDownPosition = const Offset(0, 0);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTapDown: (TapDownDetails details) {
//           _tapDownPosition = details.globalPosition;
//         },
//         onLongPress: () async {
//           final RenderObject? overlay =
//               Overlay.of(context)!.context.findRenderObject();

//           T? value = await showMenu<T>(
//             context: context,
//             items: widget.items,
//             position: RelativeRect.fromLTRB(
//               _tapDownPosition.dx,
//               _tapDownPosition.dy,
//               overlay!.width - _tapDownPosition.dx,
//               overlay.size.height - _tapDownPosition.dy,
//             ),
//           );

//           widget.onItemSelected(value!);
//         },
//         child: widget.child);
//   }
// }
