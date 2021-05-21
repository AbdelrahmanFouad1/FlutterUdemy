import 'package:first_flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/news_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    preFix:  Icons.search,
                    label: 'Search',
                    onchange: (value){
                      list.getSearch(value);
                    },
                    validator: (String value){
                      if(value.isEmpty){
                        return 'search must not be empty';
                      }
                      return null;
                    }
                ),
              ),
              Expanded(child: articleBuilder(list.search, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
