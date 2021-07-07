import 'package:first_flutter_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:first_flutter_app/modules/shop_app/search/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: Column(
                    children: [
                      defaultTextField(
                        controller: searchController,
                        textInputType: TextInputType.text,
                        preFix: Icons.search,
                        label: 'Search',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          cubit.search(text);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingStates) LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessStates)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            cubit.searchModel.data.data[index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.searchModel.data.data.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
