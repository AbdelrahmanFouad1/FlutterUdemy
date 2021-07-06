import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:first_flutter_app/layout/shop_app/cubit/states.dart';
import 'package:first_flutter_app/models/shop_app/favorites_model.dart';
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
                itemBuilder: (context, index) => buildFavItem(cubit.favoritesModel.data.data[index], context),
                separatorBuilder: (context, index) =>myDivider(),
                itemCount: cubit.favoritesModel.data.data.length,
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      );

  }
  Widget buildFavItem(FavoritesData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model.product.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product.discount != 0)
                      Text(
                        '${model.product.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.product.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:ShopCubit.get(context).favorites[model.product.id] ? defaultColor : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
