import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/mou_partner/data/model/mou_model.dart';
import 'package:nelta/features/mou_partner/data/repository/mou_repository.dart';

class MouPartnerController
    extends StateNotifier<AsyncValue<List<MouPartnerModel>>> {
  final MouPartnerRepository mouPartnerRepository;
  MouPartnerController({required this.mouPartnerRepository})
      : super(const AsyncValue.loading()) {
    getMouPartner();
  }

  getMouPartner() async {
    final result = await mouPartnerRepository.getMouPartnerRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final mouPartnerControllerProvider = StateNotifierProvider<MouPartnerController,
    AsyncValue<List<MouPartnerModel>>>((ref) {
  return MouPartnerController(
      mouPartnerRepository: ref.read(mouPartnerRepositoryController));
});
