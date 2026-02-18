import 'package:mobile_booking_online_doctor/features/home/domain/entities/doctor_entity.dart';

import '../../../../core/theming/styles.dart';
import '../../../confirm_appointment/UI/confirm_appointment_view.dart';
import '../widgets/review_card.dart';
import 'package:flutter/material.dart';
import '../widgets/doc_state_row.dart';
import '../widgets/doctor_header.dart';
import '../widgets/price_section.dart';
import '../widgets/review_header.dart';
import '../widgets/review_summry.dart';

class DoctorDetailsPage extends StatelessWidget {
  const DoctorDetailsPage({super.key, required this.doctorEntity});
  static const String routeName = '/doctorDetails';
  final DoctorEntity doctorEntity;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(width: screenWidth * 0.12),
            Text("Doctor Details", style: TextStyles.black20w700),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_outlined),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorHeader(doctorEntity: doctorEntity,),
            const SizedBox(height: 24),
            DoctorStatsRow(experienceYears: doctorEntity.experienceYears, rate: doctorEntity.rating,),
            const SizedBox(height: 24),
            Text("About Doctor", style: TextStyles.black23w700),
            const SizedBox(height: 8),
            Text(
              doctorEntity.about,
              style: TextStyles.grey19w400,
            ),
            const SizedBox(height: 24),
            ReviewHeader(),
            const SizedBox(height: 15),
            ReviewSummary(rate: doctorEntity.rating,),
            const SizedBox(height: 8),
            ReviewCard(),
            PriceSection(price: doctorEntity.pricePerHour,),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ConfirmAppointmentView.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Book Appointment", style: TextStyles.white20w700),
            )
          ],
        ),
      ),
    );
  }
}
