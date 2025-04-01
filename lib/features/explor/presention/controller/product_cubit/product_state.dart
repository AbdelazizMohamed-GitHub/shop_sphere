import 'package:shop_sphere/features/explor/domain/entity/proudct_entity.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductEntity> products;

  ProductSuccess({required this.products});
}



final class ProductFailure extends ProductState {
  final String errMessage;

  ProductFailure({required this.errMessage});
}
