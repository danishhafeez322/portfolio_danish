import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_danish/bloc/home_bloc.dart';
import 'package:portfolio_danish/utils/app_enum.dart';
import 'package:portfolio_danish/utils/app_extentions.dart';
import 'package:portfolio_danish/utils/app_theme.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "<Danish Hafeez>",
          style: textTheme.headlineMedium!.copyWith(
              color: PortfolioAppTheme.white, fontWeight: FontWeight.w400),
        ),
        context.width > DeviceType.ipad.getMaxWidth()
            ? const HorizontalHeaders()
            : const SizedBox(),
      ],
    );
  }
}

class HorizontalHeaders extends StatelessWidget {
  const HorizontalHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: List.generate(
            AppBarHeaders.values.length,
            (index) => CustomHeaderBtn(headerIndex: index),
          ),
        );
      },
    );
  }
}

class CustomHeaderBtn extends StatelessWidget {
  const CustomHeaderBtn({super.key, required this.headerIndex});
  final int headerIndex;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: () {
        context.read<HomeBloc>().add(ChangeAppBarHeadersIndex(headerIndex));
      },
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        child: Text(
          AppBarHeaders.values[headerIndex].getString(),
          style: textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w800,
            color: _getHeaderColor(
              currentIndex: context.read<HomeBloc>().appBarHeaderIndex,
              headerIndex: headerIndex,
            ),
          ),
        ),
      ),
    );
  }

  Color _getHeaderColor({required currentIndex, required int headerIndex}) {
    if (currentIndex == headerIndex) {
      return PortfolioAppTheme.nameColor;
    } else {
      return PortfolioAppTheme.white;
    }
  }
}
