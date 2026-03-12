import '../models/department.dart';

class HospitalData {
  static final List<Department> departments = [
    Department(
      id: 'ent',
      name: 'Ears, Nose, Throat OPD',
      shortName: 'ENT OPD',
      isActive: true,
      services: [
        ServiceItem(
          id: 'ent_1',
          name: 'Ear (Otology &\nNeurotology)',
          departmentId: 'ent',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ent_2',
          name: 'Nose (Rhinology)',
          departmentId: 'ent',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ent_3',
          name: 'Throat\n(Laryngology &\nPharyngology)',
          departmentId: 'ent',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ent_4',
          name: 'Audiology Services',
          departmentId: 'ent',
          isAvailable: false,
        ),
        ServiceItem(
          id: 'ent_5',
          name: 'Head and Neck',
          departmentId: 'ent',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ent_6',
          name: 'Minor ENT\nProcedures\n(OPD-based)',
          departmentId: 'ent',
          isAvailable: true,
        ),
      ],
    ),
    Department(
      id: 'rehab',
      name: 'Rehab Medicine OPD',
      shortName: 'Rehab Medicine OPD',
      isActive: true,
      services: [
        ServiceItem(
          id: 'rehab_1',
          name: 'Physical Therapy',
          departmentId: 'rehab',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'rehab_2',
          name: 'Occupational Therapy',
          departmentId: 'rehab',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'rehab_3',
          name: 'Speech Therapy',
          departmentId: 'rehab',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'rehab_4',
          name: 'Cardiac Rehab',
          departmentId: 'rehab',
          isAvailable: false,
        ),
        ServiceItem(
          id: 'rehab_5',
          name: 'Pulmonary Rehab',
          departmentId: 'rehab',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'rehab_6',
          name: 'Neuro Rehab',
          departmentId: 'rehab',
          isAvailable: true,
        ),
      ],
    ),
    Department(
      id: 'ophthal',
      name: 'Ophthalmology OPD',
      shortName: 'Ophthalmology OPD',
      isActive: true,
      services: [
        ServiceItem(
          id: 'ophthal_1',
          name: 'General Eye\nConsultation',
          departmentId: 'ophthal',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ophthal_2',
          name: 'Cataract Services',
          departmentId: 'ophthal',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ophthal_3',
          name: 'Glaucoma Clinic',
          departmentId: 'ophthal',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ophthal_4',
          name: 'Pediatric\nOphthalmology',
          departmentId: 'ophthal',
          isAvailable: false,
        ),
        ServiceItem(
          id: 'ophthal_5',
          name: 'Retina Services',
          departmentId: 'ophthal',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ophthal_6',
          name: 'Laser Eye\nProcedures',
          departmentId: 'ophthal',
          isAvailable: true,
        ),
      ],
    ),
    Department(
      id: 'ortho',
      name: 'Orthopedic OPD',
      shortName: 'Orthopedic OPD',
      isActive: true,
      services: [
        ServiceItem(
          id: 'ortho_1',
          name: 'Bone & Joint\nConsultation',
          departmentId: 'ortho',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ortho_2',
          name: 'Sports Medicine',
          departmentId: 'ortho',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ortho_3',
          name: 'Spine Care',
          departmentId: 'ortho',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ortho_4',
          name: 'Fracture Clinic',
          departmentId: 'ortho',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'ortho_5',
          name: 'Joint Replacement\nConsultation',
          departmentId: 'ortho',
          isAvailable: false,
        ),
        ServiceItem(
          id: 'ortho_6',
          name: 'Pediatric\nOrthopedics',
          departmentId: 'ortho',
          isAvailable: true,
        ),
      ],
    ),
    Department(
      id: 'dental',
      name: 'Dental Clinic OPD',
      shortName: 'Dental Clinic OPD',
      isActive: true,
      services: [
        ServiceItem(
          id: 'dental_1',
          name: 'General Dentistry',
          departmentId: 'dental',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'dental_2',
          name: 'Oral Surgery',
          departmentId: 'dental',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'dental_3',
          name: 'Orthodontics',
          departmentId: 'dental',
          isAvailable: false,
        ),
        ServiceItem(
          id: 'dental_4',
          name: 'Periodontics',
          departmentId: 'dental',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'dental_5',
          name: 'Pediatric\nDentistry',
          departmentId: 'dental',
          isAvailable: true,
        ),
        ServiceItem(
          id: 'dental_6',
          name: 'Dental\nProsthetics',
          departmentId: 'dental',
          isAvailable: true,
        ),
      ],
    ),
  ];

  static final Map<String, String> doctorAssignments = {
    'ent': 'Dr. Maria Santos',
    'rehab': 'Dr. Jose Reyes',
    'ophthal': 'Dr. Ana Lim',
    'ortho': 'Dr. Pedro Cruz',
    'dental': 'Dr. Rosa Garcia',
  };

  static final Map<String, String> roomAssignments = {
    'ent': 'Room 101',
    'rehab': 'Room 202',
    'ophthal': 'Room 305',
    'ortho': 'Room 410',
    'dental': 'Room 115',
  };

  static int _ticketCounter = 45;

  static int nextTicketNumber() {
    return ++_ticketCounter;
  }

  static String currentPatientNumber = '0045';
}
