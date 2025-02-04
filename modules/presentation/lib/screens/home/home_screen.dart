import 'package:domain/model/repo.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/extensions/column_padded_extension.dart';
import 'package:presentation/screens/home/bloc/home_bloc.dart';
import 'package:presentation/screens/repo_details/repo_details_argument.dart';
import 'package:presentation/screens/repo_details/repo_details_screen.dart';
import 'package:presentation/widgets/my_list_tile.dart';
import 'package:presentation/widgets/my_generic_empty_page.dart';
import 'package:presentation/widgets/my_generic_error_page.dart';
import 'package:presentation/widgets/my_paged_list.dart';
import 'package:presentation/widgets/my_scaffold.dart';
import 'package:presentation/widgets/my_text.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.type != current.type || previous.pagingController != current.pagingController,
      builder: (_, state) => SafeArea(
        child: Column(
          children: [
            _SearchInput(),
            Expanded(
              child: state.type.mapOrElse(
                error: () => const MyGenericErrorPage(),
                orElse: () => _ReposList(state: state),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchInput extends HookWidget {
  const _SearchInput();

  static const _debounceTimerDuration = Duration(milliseconds: 800);
  static const _easyDebounceId = 'search-debouncer';

  static const _clearIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => previous.searchValue != current.searchValue,
      listener: (context, state) {
        final text = state.searchValue ?? '';
        if (text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => controller.clear(),
          );
        } else {
          controller.value = controller.value.copyWith(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
        }
      },
      builder: (context, state) => TextField(
        controller: controller,
        onTapOutside: (_) => FocusScope.of(context).requestFocus(FocusNode()),
        decoration: InputDecoration(
          suffixIcon: state.searchValue == null
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: _clearIconSize,
                    color: Colors.black,
                  ),
                  onPressed: () => context.read<HomeBloc>().add(const HomeEvent.onSearchCleared()),
                ),
          hintText: context.strings.homeScreenSearchInputHint,
        ),
        onChanged: (value) => EasyDebounce.debounce(
          _easyDebounceId,
          _debounceTimerDuration,
          () => context.read<HomeBloc>()
            ..add(value.isEmpty ? HomeEvent.onSearchCleared() : HomeEvent.onSearchChanged(value: value))
            ..add(HomeEvent.onReposRequested()),
        ),
      ),
    ).columnPadded;
  }
}

class _ReposList extends StatelessWidget {
  const _ReposList({
    required this.state,
  });

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return MyPagedList<Repo>(
      pagingController: state.pagingController,
      onLoadMore: (page) => context.read<HomeBloc>().add(HomeEvent.onReposRequested(page: page)),
      noItemsFoundIndicatorBuilder: (_) => MyGenericEmptyPage(),
      itemBuilder: (_, item, __) => MyListTile(
        title: item.name,
        description: item.description,
        onPressed: () => context.push(
          RepoDetailsScreen.routeName,
          extra: RepoDetailsArgument(repo: item),
        ),
        footer: MyText(
          context.strings.repoListTileAuthor(item.owner.login),
          style: AppTextStyles.information,
        ),
      ),
      padding: EdgeInsets.all(Insets.xLarge),
    );
  }
}
