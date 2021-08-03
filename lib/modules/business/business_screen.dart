import 'package:first_flutter_app/layout/news_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/news_app/cubit/states.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (BuildContext context) {
              NewsCubit.get(context).setDesktop(false);
              return articleBuilder(list, context);
            },
          ),
          desktop: Builder(
            builder: (BuildContext context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: articleBuilder(list, context)),
                  if (list.length > 0)
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            // 'Desktop',
                            '${list[NewsCubit.get(context).selectedBusinessItem]['description']}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 700,
            tablet: 600,
            watch: 100,
          ),
        );
      },
    );
  }
}
