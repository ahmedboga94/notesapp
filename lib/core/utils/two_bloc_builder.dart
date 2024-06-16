import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwoBlocBuilder<C1 extends Cubit<S1>, S1, C2 extends Cubit<S2>, S2>
    extends StatelessWidget {
  final Widget Function(BuildContext, S1, S2) builder;

  const TwoBlocBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C1, S1>(
      builder: (context, state1) {
        return BlocBuilder<C2, S2>(
          builder: (context, state2) {
            return builder(context, state1, state2);
          },
        );
      },
    );
  }
}
