class HospitalModel {
  List<String>? serviceType;
  String? website;
  String? hospitalType;
  List<String>? facilitiesType;
  String? latitude;
  String? placeAddress;
  String? hospitalOwner;
  String? hospitalSize;
  String? phoneNumber;
  String? name;
  String? hospitalImage;
  String? userEmail;
  String? id;
  String? email;
  String? longitude;
  bool? isApprove;

  HospitalModel(
      {this.serviceType,
      this.website,
      this.hospitalType,
      this.facilitiesType,
      this.latitude,
      this.placeAddress,
      this.hospitalOwner,
      this.hospitalSize,
      this.phoneNumber,
      this.name,
      this.hospitalImage,
      this.userEmail,
      this.id,
      this.email,
      this.longitude,
      this.isApprove});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'].cast<String>();
    website = json['website'];
    hospitalType = json['hospitalType'];
    facilitiesType = json['facilitiesType'].cast<String>();
    latitude = json['latitude'];
    placeAddress = json['placeAddress'];
    hospitalOwner = json['hospitalOwner'];
    hospitalSize = json['hospitalSize'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    hospitalImage = json['hospitalImage'];
    userEmail = json['userEmail'];
    id = json['id'];
    email = json['email'];
    longitude = json['longitude'];
    isApprove = json['isApprove'];
  }
}
