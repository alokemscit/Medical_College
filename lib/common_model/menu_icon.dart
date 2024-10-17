class MenuIconList {
  final String id;
  final String name;
  final String icon;
  MenuIconList({required this.id, required this.name, required this.icon});
}

List<MenuIconList> iconList = [
  MenuIconList(  id: '1',name: 'Appointment',icon: 'assets/icons/appointments.png'),
   MenuIconList(  id: '2',name: 'Registration',icon: 'assets/icons/registrations.png'),
    MenuIconList(  id: '3',name: 'Investigation Reports',icon: 'assets/icons/investigations.png'),
    MenuIconList(  id: '4',name: 'Prescription',icon: 'assets/icons/prescriptions.png'),
     MenuIconList(  id: '5',name: 'Health Package',icon: 'assets/icons/healthpakages.png'),
      MenuIconList(  id: '6',name: 'Pharmacy Order',icon: 'assets/icons/pharmacys.png'),
       MenuIconList(  id: '7',name: 'Online Payment',icon: 'assets/icons/onlinepayments.png'),
        MenuIconList(  id: '8',name: 'Location',icon: 'assets/icons/locations.png'),

];
