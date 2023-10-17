import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_response_model.dart';
import 'package:nelta/features/profile/data/model/location_model/getdistrict_model.dart';
import 'package:nelta/features/profile/data/model/location_model/getmuni_model.dart';
import 'package:nelta/features/profile/data/model/location_model/getpradesh_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_update_response_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_update_request_model.dart';
import 'package:nelta/features/profile/data/model/user_models/profile_response_model.dart';
import 'package:nelta/features/profile/data/model/user_models/update_profile_response_model.dart';

abstract class ProfileDataSource {
  //Member
  Future<MemberProfileResponseModel> getMemberProfileDS();
  Future<MemberProfileUpdateResponseModel> updateMemberProfileDS(
      MemberUpdateRequestModel memberUpdateRequestModel);
  Future<MemberProfileUpdateResponseModel> updateMemberProfileFormDataDS(
      FormData formData);
  //Address
  Future<District> getDistrictDS();
  Future<PradeshModel> getPradeshDS();
  Future<MunicipalityModel> getMunicpalityDS();

//AddressList
  Future<List<PradeshModel>> getPradeshListDS();
  Future<List<District>> getDistrictListDS(String id);
  Future<List<MunicipalityModel>> getMunicipalityListDs(String id);

  //User
  Future<ProfileResponseModel> getUserProfileDS();
  // Future<ProfileUpdateResponseModel> updateUserProfileDS(
  //     UpdateProfileRestModel updateProfileRestModel);
  Future<ProfileUpdateResponseModel> updateUserProfileDS(FormData formData);
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiClient apiClient;
  ProfileDataSourceImpl(this.apiClient);
  @override
  Future<ProfileResponseModel> getUserProfileDS() async {
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    final result = await apiClient.request(
        path: ApiConst.userID + loginResponseModel.id.toString());
    // final user = result['user'];
    // if (user == "") {
    //   return ProfileResponseModel(
    //     id: 0,
    //     fullName: "",
    //     address: "",
    //     email: "",
    //     password: "",
    //     enrollment: "",
    //     userType: "",
    //     lifeMember: "",
    //     status: "",
    //     memberId: "",
    //     registerDate: "",
    //     countryId: 0,
    //     fcmToken: "",
    //   );
    // } else {
    //   return ProfileResponseModel.fromMap(user);
    // }
    return ProfileResponseModel.fromMap(
        result['user'] == "" ? {} : result['user']);
    // return ProfileResponseModel.fromMap(result["user"]);
  }

  @override
  Future<ProfileUpdateResponseModel> updateUserProfileDS(
      FormData formData) async {
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    final result = await apiClient.requestFormData(
        path: ApiConst.updateProfileID + loginResponseModel.id.toString(),
        formData: formData);
    return ProfileUpdateResponseModel.fromMap(result);
  }

  @override
  Future<MemberProfileResponseModel> getMemberProfileDS() async {
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    ;
    final result = await apiClient.request(
        path: ApiConst.getmemberID + loginResponseModel.id.toString());
    return MemberProfileResponseModel.fromMap(result["user"]);
  }

  @override
  Future<District> getDistrictDS() async {
    final String data = await DbClient().getData(dbKey: "memberData");
    final MemberProfileResponseModel memberProfileResponseModel =
        MemberProfileResponseModel.fromJson(data);
    final result = await apiClient.request(
        path: ApiConst.getDistrictbyID +
            memberProfileResponseModel.districtId.toString());

    return District.fromMap(result["district"]);
  }

  @override
  Future<PradeshModel> getPradeshDS() async {
    final String data = await DbClient().getData(dbKey: "memberData");
    final MemberProfileResponseModel memberProfileResponseModel =
        MemberProfileResponseModel.fromJson(data);

    final result = await apiClient.request(
        path: ApiConst.getPradeshByID +
            memberProfileResponseModel.provinceId.toString());

    return PradeshModel.fromMap(result["pradesh"]);
  }

  @override
  Future<MunicipalityModel> getMunicpalityDS() async {
    final String data = await DbClient().getData(dbKey: "memberData");
    final MemberProfileResponseModel memberProfileResponseModel =
        MemberProfileResponseModel.fromJson(data);
    log(memberProfileResponseModel.muniId.toString() + "sdsds");
    final result = await apiClient.request(
        path: ApiConst.getMunicipalitybyID +
            memberProfileResponseModel.muniId.toString());

    return MunicipalityModel.fromMap(result["muni"]);
  }

  @override
  Future<MemberProfileUpdateResponseModel> updateMemberProfileDS(
      MemberUpdateRequestModel memberUpdateRequestModel) async {
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    final result = await apiClient.request(
        path: ApiConst.updateMemberbyID + loginResponseModel.id.toString(),
        type: "post",
        data: memberUpdateRequestModel.toMap());
    return MemberProfileUpdateResponseModel.fromMap(result);
  }

  @override
  Future<List<PradeshModel>> getPradeshListDS() async {
    final result = await apiClient.request(path: ApiConst.getpradeshList);
    List data = result["pradesh"];
    return data.map((e) => PradeshModel.fromMap(e)).toList();
  }

  @override
  Future<List<District>> getDistrictListDS(String id) async {
    final result = await apiClient.request(path: ApiConst.getdistrictList + id);
    List data = result["district"];
    return data.map((e) => District.fromMap(e)).toList();
  }

  @override
  Future<List<MunicipalityModel>> getMunicipalityListDs(String id) async {
    final result =
        await apiClient.request(path: ApiConst.getmunipalityList + id);
    List data = result["muni"];
    return data.map((e) => MunicipalityModel.fromMap(e)).toList();
  }

  @override
  Future<MemberProfileUpdateResponseModel> updateMemberProfileFormDataDS(
      FormData formData) async {
    final String data = await DbClient().getData(dbKey: "memberData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    final result = await apiClient.requestFormData(
        path: ApiConst.updateMemberbyID + loginResponseModel.id.toString(),
        formData: formData);
    return MemberProfileUpdateResponseModel.fromMap(result);
  }
}

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  return ProfileDataSourceImpl(ref.read(apiClientProvider));
});
