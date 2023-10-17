import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/contact_us/data/model/contactus_model.dart';
import 'package:nelta/features/contact_us/data/repository/contact_us_repository.dart';

class ContactUsController extends StateNotifier<AsyncValue<ContactUsModel>> {
  final ContactUsRepository contactUsRepository;
  ContactUsController({required this.contactUsRepository})
      : super(const AsyncValue.loading()) {
    getContactUs();
  }

  getContactUs() async {
    final result = await contactUsRepository.getContactUsRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final contactUsControllerProvider =
    StateNotifierProvider<ContactUsController, AsyncValue<ContactUsModel>>(
        (ref) {
  return ContactUsController(
      contactUsRepository: ref.read(contactUsRepositoryController));
});
