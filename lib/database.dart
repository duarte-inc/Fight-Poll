import 'package:mma_poll/model.dart';

final List<FightPoll> polls = [
  new FightPoll(
    id: 1,
    drawNum: 298,
    canceledNum: 869,
    name2Num: 90,
    name1Num: 12,
  ),
  new FightPoll(
    id: 2,
    drawNum: 298,
    canceledNum: 869,
    name2Num: 90,
    name1Num: 12,
  ),
  new FightPoll(
    id: 3,
    drawNum: 298,
    canceledNum: 869,
    name2Num: 90,
    name1Num: 12,
  ),
  new FightPoll(
    id: 4,
    drawNum: 298,
    canceledNum: 869,
    name2Num: 90,
    name1Num: 12,
  ),
  new FightPoll(
    id: 5,
    drawNum: 298,
    canceledNum: 869,
    name2Num: 90,
    name1Num: 12,
  ),
];

final List<FightInfo> infos = [
  new FightInfo(
    id: 1,
    pollId: 5,
    title: "Canelo vs Floyd Money",
    pic:
        "https://cdn.vox-cdn.com/thumbor/p_wao1TF2wjq9u1HHuJ1Msa6fS8=/0x0:2579x1720/1200x800/filters:focal(1077x418:1489x830)/cdn.vox-cdn.com/uploads/chorus_image/image/58496539/848168204.jpg.0.jpg",
    status: true,
    name1Name: "Canelo",
    name2Name: "Floyd",
    postedDate: DateTime(2018, 9, 10),
  ),
  new FightInfo(
    id: 2,
    pollId: 3,
    title: "Adie Alverez vs Thomas Edison",
    pic:
        "https://cdn.vox-cdn.com/thumbor/pptFvsxEXaFVlTD48Nqh4yMfYBA=/0x0:1920x1280/1200x800/filters:focal(1134x523:1440x829)/cdn.vox-cdn.com/uploads/chorus_image/image/59149525/050_Marlon_Moraes_vs_Raphael_Assuncao.0.jpg",
    status: false,
    name1Name: "Adie",
    name2Name: "Thomas",
    postedDate: DateTime(2018, 4, 5),
  ),
  new FightInfo(
    id: 3,
    pollId: 4,
    title: "Khabib Nermagemedov vs ...",
    pic:
        "https://www.onlinegambling.com/news/wp-content/uploads/2018/10/Nurmagomedov-Mayweather.jpg",
    status: false,
    name1Name: "Khabib",
    name2Name: "Floyd",
    postedDate: DateTime(2018, 10, 20),
  ),
  new FightInfo(
    id: 4,
    pollId: 2,
    title: "Conor MCgregor vs Floyd ...",
    pic:
        "https://cdn.vox-cdn.com/thumbor/JjuTkmc4OMOB_tGeEfLwo0d_pi8=/0x0:3588x2392/1200x800/filters:focal(1497x648:2071x1222)/cdn.vox-cdn.com/uploads/chorus_image/image/56377393/GettyImages_839145416.0.jpg",
    status: true,
    name1Name: "Conor",
    name2Name: "Floyd",
    postedDate: DateTime(2018, 10, 10),
  ),
  new FightInfo(
    id: 5,
    pollId: 1,
    title: "Black Beast vs Mark Hunt",
    pic:
        "http://watchwrestling.in/wp-content/uploads/2017/06/C7oc0AgVwAE_JQ6.0.jpg",
    status: true,
    name1Name: "Black",
    name2Name: "Mark",
    postedDate: DateTime(2018, 10, 1),
  ),
];
