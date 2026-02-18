import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_booking_online_doctor/features/home/domain/entities/doctor_entity.dart';

import '../../../../core/helpers/assets.dart';
import '../../../../core/theming/styles.dart';

class DoctorHeader extends StatelessWidget {
  const DoctorHeader({super.key, required this.doctorEntity});
  final DoctorEntity doctorEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: Image.network(
            doctorEntity.image,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(Assets.assetsImagesDoctor3);
            },
          ).image,
        ),
        const SizedBox(width: 19),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(doctorEntity.name, style: TextStyles.black20w700),
              Text(doctorEntity.specialtyNameEn, style: TextStyles.black14w400),
              Row(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Image.asset(Assets.assetsIconsLocation, height: 18, width: 18),
                  Expanded(
                    child: Text(
                      doctorEntity.location,
                      style: TextStyles.grey14w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
