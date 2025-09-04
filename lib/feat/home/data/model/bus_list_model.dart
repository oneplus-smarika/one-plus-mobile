class BusModel {
  final String busName;
  final String busType;
  final String price;
  final String seatsLeft;
  final String departure;
  final String arrival;

  BusModel({
    required this.busName,
    required this.busType,
    required this.price,
    required this.seatsLeft,
    required this.departure,
    required this.arrival,
  });
}
final List<BusModel> busList = [
  BusModel(
    busName: "One Plus Yatayat",
    busType: "Sleeper Bus",
    price: "NPR 2,500",
    seatsLeft: "25 Seats Left",
    departure: "BIR 5:00 PM",
    arrival: "KTM 6:00 AM",
  ),
  BusModel(
    busName: "Smarika Yatayat",
    busType: "Day Bus",
    price: "NPR 1,750",
    seatsLeft: "37 Seats Left",
    departure: "KTM 6:00 AM",
    arrival: "BIR 5:00 PM",
  ),
  BusModel(
    busName: "Smarika Yatayat Nepal Express",
    busType: "Night Bus",
    price: "NPR 1,750",
    seatsLeft: "37 Seats Left",
    departure: "BIR 4:00 PM",
    arrival: "KTM 5:00 AM",
  ),
];