import 'package:mma_poll/model.dart';

final List<FightPoll> polls = [
  new FightPoll(
    id: 1,
    title: "Canelo vs Floyd Money",
    pic:
        "https://cdn.vox-cdn.com/thumbor/p_wao1TF2wjq9u1HHuJ1Msa6fS8=/0x0:2579x1720/1200x800/filters:focal(1077x418:1489x830)/cdn.vox-cdn.com/uploads/chorus_image/image/58496539/848168204.jpg.0.jpg",
    status: true,
    drawNum: 2340,
    name1Num: 342,
    name2Num: 894,
    canceledNum: 83,
    name1Name: "Canelo",
    name2Name: "Floyd",
    postedDate: DateTime(2018,9,10),
  ),
  new FightPoll(
    id: 2,
    title: "Adie Alverez vs Thomas Edison",
    pic:
        "https://cdn.vox-cdn.com/thumbor/pptFvsxEXaFVlTD48Nqh4yMfYBA=/0x0:1920x1280/1200x800/filters:focal(1134x523:1440x829)/cdn.vox-cdn.com/uploads/chorus_image/image/59149525/050_Marlon_Moraes_vs_Raphael_Assuncao.0.jpg",
    status: false,
    drawNum: 748,
    name1Num: 3,
    name2Num: 23,
    canceledNum: 45,
    name1Name: "Adie",
    name2Name: "Thomas",
    postedDate: DateTime(2018,4,5),
  ),
  new FightPoll(
    id: 3,
    title: "Khabib Nermagemedov vs ...",
    pic:
        "https://www.onlinegambling.com/news/wp-content/uploads/2018/10/Nurmagomedov-Mayweather.jpg",
    status: false,
    drawNum: 902,
    name1Num: 23,
    name2Num: 3454,
    canceledNum: 1,
    name1Name: "Khabib",
    name2Name: "Floyd",
    postedDate: DateTime(2018,10,20),
  ),
  new FightPoll(
    id: 4,
    title: "Conor MCgregor vs Floyd ...",
    pic:
        "https://cdn.vox-cdn.com/thumbor/JjuTkmc4OMOB_tGeEfLwo0d_pi8=/0x0:3588x2392/1200x800/filters:focal(1497x648:2071x1222)/cdn.vox-cdn.com/uploads/chorus_image/image/56377393/GettyImages_839145416.0.jpg",
    status: true,
    drawNum: 98,
    name1Num: 10,
    name2Num: 81,
    canceledNum: 8,
    name1Name: "Conor",
    name2Name: "Floyd",
    postedDate: DateTime(2018,10,10),
  ),
  new FightPoll(
    id: 5,
    title: "Black Beast vs Mark Hunt",
    pic:
        "http://watchwrestling.in/wp-content/uploads/2017/06/C7oc0AgVwAE_JQ6.0.jpg",
    status: true,
    drawNum: 0,
    name1Num: 32,
    name2Num: 76,
    canceledNum: 65,
    name1Name: "Black",
    name2Name: "Mark",
    postedDate: DateTime(2018,10,1),
  ),
];
