import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
   List<ProductEntity> products;
   List<ProductEntity> popularProducts; 

  ProductSuccess({required this.products, required this.popularProducts});
}



final class ProductFailure extends ProductState {
  final String errMessage;

  ProductFailure({required this.errMessage});
}
