import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/states.dart';
import 'package:first_flutter_app/models/shop_app/favorites_model.dart';
import 'package:first_flutter_app/models/shop_app/home_model.dart';
import 'package:first_flutter_app/shared/components/components.dart';
import 'package:first_flutter_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesStates,
            builder: (BuildContext context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildListProduct(cubit.favoritesModel.data.data[index].product, context,isOldPrice: true),
                separatorBuilder: (context, index) =>myDivider(),
                itemCount: cubit.favoritesModel.data.data.length,
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      );

  }
}
