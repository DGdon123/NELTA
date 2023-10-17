import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/contact_us/data/data_source/contact_us_source.dart';
import 'package:nelta/features/contact_us/data/model/contactus_model.dart';

abstract class ContactUsRepository {
  Future<Either<AppError, ContactUsModel>> getContactUsRepo();
}

class ContactUsRepositoryImpl implements ContactUsRepository {
  final ContactUsModelDataSource contactUsModelDataSource;
  ContactUsRepositoryImpl(this.contactUsModelDataSource);

  @override
  Future<Either<AppError, ContactUsModel>> getContactUsRepo() async {
    try {
      final result = await contactUsModelDataSource.getContactUsDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final contactUsRepositoryController = Provider<ContactUsRepository>((ref) {
  return ContactUsRepositoryImpl(ref.read(contactUsModelDataSourceProvider));
});
