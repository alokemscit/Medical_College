// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asgar_ali_hospital/constant/string.dart';

class DoctorImage {
  final String? id;
  final String? image;
  DoctorImage({
    this.id,
    this.image,
  });
}

class GetDoctorImage {
  Set<DoctorImage> imageList = doc_image.map((item) {
    return DoctorImage(
      id: item['doctor_unique_id'].toString(),
      image: item['image'].toString(),
    );
  }).toSet();

  // ignore: non_constant_identifier_names
  List<DoctorImage> ImageList() => imageList.toList();
}

Future<List<DoctorImage>> getDoctorImageList() async{
  Set<DoctorImage> imageList = doc_image.map((item) {
    return DoctorImage(
      id: item['doctor_unique_id'].toString(),
      image: appDocImageUrl+ item['image'].toString(),
    );
  }).toSet();
  return imageList.toList();
}

List<dynamic> doc_image = [
  {
    "doctor_unique_id": "3520",
    "image": "doctors/Y6d8SL7K1yg5q4zY7yrne1yjN.webp"
  },
  {
    "doctor_unique_id": "1774",
    "image": "doctors/6PdvnL5IVQOr3zKwbsEkzQZRV.webp"
  },
  {
    "doctor_unique_id": "4188",
    "image": "doctors/AmqOfnNou4HaRpow1DY8BEEYx.webp"
  },
  {
    "doctor_unique_id": "3442",
    "image": "doctors/lyGca05mO9gzPYlulJpbkvC3M.webp"
  },
  {
    "doctor_unique_id": "3447",
    "image": "doctors/GE2flVg2jXSyyabENgW7XY0Vg.webp"
  },
  {
    "doctor_unique_id": "1849",
    "image": "doctors/83cfEFgGyMFI5Ucc9G6zClc3c.webp"
  },
  {
    "doctor_unique_id": "5240",
    "image": "doctors/ry0SAiJQLASlBNmsZQjaMJgmD.webp"
  },
  {
    "doctor_unique_id": "52403",
    "image": "doctors/vczm1a75nsZZfBfxqpXWvZzDI.webp"
  },
  {
    "doctor_unique_id": "1708",
    "image": "doctors/XbjnN49G15GZ0NG9ifnCm9isL.webp"
  },
  {
    "doctor_unique_id": "4918",
    "image": "doctors/Jo0JTZbKiS5aL64S6QI2Fu875.png"
  },
  {
    "doctor_unique_id": "3111",
    "image": "doctors/ZKlX6KpDNXBCemjJMW0zQcVzq.png"
  },
  {
    "doctor_unique_id": "2182",
    "image": "doctors/KKAAkjsIJ7X2pIHfntBM4qhbP.png"
  },
  {
    "doctor_unique_id": "3792",
    "image": "doctors/Q2a7GwLFfOX1PoSczG2ZnqpUM.png"
  },
  {
    "doctor_unique_id": "1309",
    "image": "doctors/306FJ6o6zYECj94YcyZqUF04c.png"
  },
  {
    "doctor_unique_id": "3140",
    "image": "doctors/M3lEzLk31IDTiMy4vo9p6NDQ1.png"
  },
  {
    "doctor_unique_id": "3113",
    "image": "doctors/TLaGEG4XD0DaTICsYQMDn4xaI.png"
  },
  {
    "doctor_unique_id": "1562",
    "image": "doctors/9YeztyGX1pxOzG7UcFBoBUTHx.png"
  },
  {
    "doctor_unique_id": "2358",
    "image": "doctors/fTn0mFYz32Lpt62LPHx0sQOyC.png"
  },
  {
    "doctor_unique_id": "3576",
    "image": "doctors/kJppzrY3IIes7yaM2lf9f1q5r.jpg"
  },
  {
    "doctor_unique_id": "1479",
    "image": "doctors/OqiLT3uZvqnFQwf2JtYp8dCEg.png"
  },
  {
    "doctor_unique_id": "1579",
    "image": "doctors/WscaabSM5ot4LZKCl1Mogg92K.png"
  },
  {
    "doctor_unique_id": "1500",
    "image": "doctors/lpGq1SiYSxvKVMEK18vgER28U.png"
  },
  {
    "doctor_unique_id": "3516",
    "image": "doctors/35yZIdhSa4CvNaKxWYTDNZ0yw.png"
  },
  {
    "doctor_unique_id": "4974",
    "image": "doctors/rSzKY19axVJK3HeuthitNRTY4.png"
  },
  {
    "doctor_unique_id": "2365",
    "image": "doctors/khBjxOpPoh3amQdYYgsdUeMwt.png"
  },
  {
    "doctor_unique_id": "3804",
    "image": "doctors/loGVhEtzELKblqYAlFy8tnPVD.png"
  },
  {
    "doctor_unique_id": "3857",
    "image": "doctors/U0FvgqbAPFT76i2qlm0NNSw0y.png"
  },
  {
    "doctor_unique_id": "3395",
    "image": "doctors/alMr81TT5C4BJbJuQ8tePtx47.png"
  },
  {
    "doctor_unique_id": "2819",
    "image": "doctors/2pEHJZYCv1P5lQ2zUUf0llQTT.png"
  },
  {
    "doctor_unique_id": "1674",
    "image": "doctors/N3n72fk36T206FDUM1GljrHKA.png"
  },
  {
    "doctor_unique_id": "1175",
    "image": "doctors/UWsATBbFtk6woGrNSXYvCBlF9.png"
  },
  {
    "doctor_unique_id": "3473",
    "image": "doctors/Qox433vXD3GjQKAQ3niUbSU12.png"
  },
  {
    "doctor_unique_id": "4187",
    "image": "doctors/uMo7jwMMfHXnkOPM9VhDPRLCY.png"
  },
  {
    "doctor_unique_id": "1893",
    "image": "doctors/yMMcfHPgSWf4us4TmzrI6EIXj.png"
  },
  {
    "doctor_unique_id": "1479",
    "image": "doctors/yGKCMs9f53jTAk4kCROWu91Pc.png"
  },
  {
    "doctor_unique_id": "1565",
    "image": "doctors/G2TghoiTwxRgJ6s7dMphhMi9x.png"
  },
  {
    "doctor_unique_id": "2598",
    "image": "doctors/H06OXBboPrPX9nsUCyk4GX6GB.png"
  },
  {
    "doctor_unique_id": "1623",
    "image": "doctors/TKtCHBmRSFSBOFpmHdOEHKgW4.png"
  },
  {
    "doctor_unique_id": "1725",
    "image": "doctors/VyWaVhg89LH7DS3ALpnWRx5Bn.png"
  },
  {
    "doctor_unique_id": "1769",
    "image": "doctors/m3Gb4lfR97vqB2uoGP0RQzd0q.png"
  },
  {
    "doctor_unique_id": "4896",
    "image": "doctors/9UMUadwTXwVUnDSuA7sOeIGdK.png"
  },
  {
    "doctor_unique_id": "2813",
    "image": "doctors/MUVBDMakSzYZZaGymGIp6v1S6.png"
  },
  {
    "doctor_unique_id": "3519",
    "image": "doctors/WTw7zEGl6ts8narwlFu846P1f.png"
  },
  {
    "doctor_unique_id": "2748",
    "image": "doctors/g2fDHKwl0ZYSjsQShcbf5gWRY.png"
  },
  {
    "doctor_unique_id": "1046",
    "image": "doctors/xYjX38Gk86caeU1U18G3ZE1vY.png"
  },
  {
    "doctor_unique_id": "3456",
    "image": "doctors/p299eKZFxXWOaw3zxf1DmoUkf.png"
  },
  {
    "doctor_unique_id": "4039",
    "image": "doctors/0r9ocqSxkUqYqR7ru3vOdMhJ2.png"
  },
  {
    "doctor_unique_id": "4056",
    "image": "doctors/0G1JSWuv3E7HWFYBWPCh3jY4c.png"
  },
  {
    "doctor_unique_id": "3402",
    "image": "doctors/q4aWqt46biYgg3EeyO0lDKk56.png"
  },
  {
    "doctor_unique_id": "2790",
    "image": "doctors/uyVmJlNyRa5hqFDlg7I3PJ6JL.png"
  },
  {
    "doctor_unique_id": "2241",
    "image": "doctors/2ru5R7bjuYJqqRLMrS4MqEujI.png"
  },
  {
    "doctor_unique_id": "1193",
    "image": "doctors/MahuTJjBUkmdRtyUxDTddQT9b.png"
  },
  {
    "doctor_unique_id": "3923",
    "image": "doctors/cVUFUrWcML97LoK3q7HeItHQR.png"
  },
  {
    "doctor_unique_id": "3822",
    "image": "doctors/QPb73OzUxBy3r4FsqX7d7arq0.png"
  },
  {
    "doctor_unique_id": "1267",
    "image": "doctors/wcN2AbbJNNgMSzsb931PihtpF.png"
  },
  {
    "doctor_unique_id": "1576",
    "image": "doctors/PA6c1DaIWBxPok9axhNNPmHC0.png"
  },
  {
    "doctor_unique_id": "1660",
    "image": "doctors/jRWf0GlrMgEBXJKh8S2Zm6DXK.png"
  },
  {
    "doctor_unique_id": "1670",
    "image": "doctors/NgiXmzlMRz3oRBHH38TJc14Ji.png"
  },
  {
    "doctor_unique_id": "2174",
    "image": "doctors/L0Gl2TKIsN7QnFyV8z5NstEc5.png"
  },
  {
    "doctor_unique_id": "4667",
    "image": "doctors/E05tkevnHEDoQgEnEHb4Myz6e.png"
  },
  {
    "doctor_unique_id": "3826",
    "image": "doctors/2aDgjBtHNAd9tcSfWKMgPVKmj.png"
  },
  {
    "doctor_unique_id": "4049",
    "image": "doctors/ibAoRxuQmy8j2tKOuc1DPcGQQ.png"
  },
  {
    "doctor_unique_id": "4817",
    "image": "doctors/grIuBuYbvJU6TG4pNTeJzXGlb.png"
  },
  {
    "doctor_unique_id": "2916",
    "image": "doctors/RhetR5B2ceFFwMZmZZDdgo8A6.png"
  },
  {
    "doctor_unique_id": "4897",
    "image": "doctors/6nK9zBySTKaV00sZxaRzfL7zV.png"
  },
  {
    "doctor_unique_id": "2129",
    "image": "doctors/61183HZOaXwUIAiwx56NycySw.png"
  },
  {
    "doctor_unique_id": "4251",
    "image": "doctors/PauFpQebmdRB8SoIR2d3kTeJ3.png"
  },
  {
    "doctor_unique_id": "5028",
    "image": "doctors/yzxFixPmDBBIPuQvwRerHsTCh.png"
  },
  {
    "doctor_unique_id": "5068",
    "image": "doctors/GZPFRvoE8IFjFwzo026oeh8CI.png"
  },
  {
    "doctor_unique_id": "5089",
    "image": "doctors/punisSkN7FpfV12z8qS91VZOo.png"
  },
  {
    "doctor_unique_id": "4896",
    "image": "doctors/RWsk3REIgBo32r4ZwZlFP2TLO.png"
  },
  {
    "doctor_unique_id": "1910",
    "image": "doctors/chMFC1Pc0GQjPWNdHgb9x1ryy.png"
  },
  {
    "doctor_unique_id": "2705",
    "image": "doctors/I5bRmV5VCARbm6INF3QZiedLi.png"
  },
  {
    "doctor_unique_id": "3903",
    "image": "doctors/1S0aVEDR3PuYun4ICJF6s6ndY.png"
  },
  {
    "doctor_unique_id": "3022",
    "image": "doctors/CzdRpKpZHOSbqJyj4zVMjv6Un.png"
  },
  {
    "doctor_unique_id": "4193",
    "image": "doctors/RExmENblNmDuokKu1sBtj1ejQ.png"
  },
  {
    "doctor_unique_id": "5175",
    "image": "doctors/OH8jxm3H2SaBnIRe7skEcjWbQ.png"
  },
  {
    "doctor_unique_id": "1628",
    "image": "doctors/7Pg5fR3jpw7n1T2c72toMdbTO.png"
  },
  {"doctor_unique_id": "5390", "image": "doctors/07fvlPO9GNu6uEPJTw5W72Syt.png"}
];
