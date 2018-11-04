import 'package:mma_poll/model.dart';

//----------------------infos------------------------
final List<Info> infos = [
  Info(
    id: 1,
    userId: 1,
    pollId: 5,
    title: "Canelo vs Floyd Money",
    pic:
        "https://cdn.vox-cdn.com/thumbor/p_wao1TF2wjq9u1HHuJ1Msa6fS8=/0x0:2579x1720/1200x800/filters:focal(1077x418:1489x830)/cdn.vox-cdn.com/uploads/chorus_image/image/58496539/848168204.jpg.0.jpg",
    status: true,
    name1: "Canelo",
    name2: "Floyd",
    postedDate: DateTime(2018, 9, 10),
  ),
  Info(
    id: 2,
    userId: 2,
    pollId: 3,
    title: "Adie Alverez vs Thomas Edison",
    pic:
        "https://cdn.vox-cdn.com/thumbor/pptFvsxEXaFVlTD48Nqh4yMfYBA=/0x0:1920x1280/1200x800/filters:focal(1134x523:1440x829)/cdn.vox-cdn.com/uploads/chorus_image/image/59149525/050_Marlon_Moraes_vs_Raphael_Assuncao.0.jpg",
    status: false,
    name1: "Adie",
    name2: "Thomas",
    postedDate: DateTime(2018, 4, 5),
  ),
  Info(
    id: 3,
    userId: 3,
    pollId: 4,
    title: "Khabib Nermagemedov vs Floyd Maywhether",
    pic:
        "https://www.onlinegambling.com/news/wp-content/uploads/2018/10/Nurmagomedov-Mayweather.jpg",
    status: false,
    name1: "Khabib",
    name2: "Floyd",
    postedDate: DateTime(2018, 10, 20),
  ),
  Info(
    id: 4,
    userId: 4,
    pollId: 2,
    title: "Conor MCgregor vs Floyd Maywhether",
    pic:
        "https://cdn.vox-cdn.com/thumbor/JjuTkmc4OMOB_tGeEfLwo0d_pi8=/0x0:3588x2392/1200x800/filters:focal(1497x648:2071x1222)/cdn.vox-cdn.com/uploads/chorus_image/image/56377393/GettyImages_839145416.0.jpg",
    status: true,
    name1: "Conor",
    name2: "Floyd",
    postedDate: DateTime(2018, 10, 10),
  ),
  Info(
    id: 5,
    userId: 5,
    pollId: 1,
    title: "Black Beast vs Mark Hunt",
    pic:
        "http://watchwrestling.in/wp-content/uploads/2017/06/C7oc0AgVwAE_JQ6.0.jpg",
    status: true,
    name1: "Black",
    name2: "Mark",
    postedDate: DateTime(2018, 10, 1),
  ),
];

//----------------------polls------------------------

final List<FightPoll> polls = [
  FightPoll(
    id: 1,
    userId: 1,
    drawNum: 23,
    canceledNum: 334,
    name2Num: 343,
    name1Num: 7788,
  ),
  FightPoll(
    id: 2,
    userId: 2,
    drawNum: 0,
    canceledNum: 90,
    name2Num: 536,
    name1Num: 24,
  ),
  FightPoll(
    id: 3,
    userId: 3,
    drawNum: 3,
    canceledNum: 23,
    name2Num: 1,
    name1Num: 2,
  ),
  FightPoll(
    id: 4,
    userId: 4,
    drawNum: 298,
    canceledNum: 2,
    name2Num: 3223,
    name1Num: 433,
  ),
  FightPoll(
    id: 5,
    userId: 5,
    drawNum: 4,
    canceledNum: 2,
    name2Num: 4,
    name1Num: 3,
  ),
];

//----------------------lists------------------------

final List<User> users = [
  User(
    id: 1,
    email: "eyoel@gmail.com",
    pic:
        "https://ichef.bbci.co.uk/news/660/cpsprodpb/BC3A/production/_92868184_gettyimages-494848232.jpg",
    password: "dsh23772378237827ydshjsdhjbdsh88923i",
    username: "eyoel",
  ),
  User(
    id: 2,
    email: "jas@gmail.com",
    pic:
        "https://yt3.ggpht.com/a-/AN66SAxPfKnfHAnAs0rOqaSwINOxDYJsyj-gPBP0OQ=s900-mo-c-c0xffffffff-rj-k-no",
    password: "27ydshjsdhjbdsh88923ishjsdhjbddsjkjk",
    username: "jas",
  ),
  User(
    id: 3,
    email: "adam@gmail.com",
    pic:
        "https://cdn3-www.musicfeeds.com.au/assets/uploads/justin-bieber-2016-press-pic-supplied-671x377.jpg",
    password: "723782378237827ydshjsdhjbdsjsdhjbjsd",
    username: "adam",
  ),
  User(
    id: 4,
    email: "sam@gmail.com",
    pic:
        "https://static1.squarespace.com/static/56a44a68cbced66ef85f1331/56a8cc40df40f3b3891c89a0/56a8d60fa976afa6650bc5e5/1453906043205/MIKE+TYSON.jpg",
    password: "sdhjbds7827ydshjsdhjbdsh889sdjjwe7ej",
    username: "sam",
  ),
  User(
    id: 5,
    email: "sally@gmail.com",
    pic: "https://pbs.twimg.com/profile_images/762515266525761536/HHvPiuIl.jpg",
    password: "2378237827ydshjsdhshjsdhjbdsh88923ds",
    username: "sally",
  ),
];

//----------------------comments------------------------

final List<Comment> comments = [
  Comment(
    id: 1,
    userId: 1,
    date: DateTime(2018, 06, 13),
    likes: 342,
    comment:
        "Pew Research Center is a nonpartisan fact tank that informs the public about the issues, attitudes and trends shaping the world.",
  ),
  Comment(
    id: 2,
    userId: 1,
    date: DateTime(2018, 1, 14),
    likes: 788,
    comment: "No Problem have been detected in the workspace so far!",
  ),
  Comment(
    id: 3,
    userId: 2,
    date: DateTime(2018, 6, 25),
    likes: 34,
    comment: "No Problem have been detected in the workspace so far!",
  ),
  Comment(
    id: 4,
    userId: 2,
    date: DateTime(2018, 5, 7),
    likes: 9087,
    comment:
        "Respondents in the landline sample were selected by randomly asking for the youngest adult male or female who is now at home.",
  ),
  Comment(
    id: 5,
    userId: 3,
    date: DateTime(2018, 6, 18),
    likes: 45,
    comment:
        "Respondents in the landline sample were selected by randomly asking for the youngest adult male or female who is now at home.",
  ),
  Comment(
    id: 6,
    userId: 3,
    date: DateTime(2018, 8, 3),
    likes: 764,
    comment:
        "The survey was conducted by interviewers at Princeton Data Source under the direction of Princeton Survey Research Associates International. A combination of landline and cell phone random digit dial samples were used; both samples were provided by Survey Sampling. International. ",
  ),
  Comment(
    id: 7,
    userId: 3,
    date: DateTime(2018, 10, 3),
    likes: 90,
    comment:
        "The analysis presented here is based on 996 respondents who received Form 2 of the survey; the margin of error for this subset of respondents is plus or minus 3.6 percentage points. ",
  ),
  Comment(
    id: 8,
    userId: 4,
    date: DateTime(2018, 10, 13),
    likes: 34,
    comment:
        "The survey was conducted by interviewers at Princeton Data Source under the direction of Princeton Survey Research Associates International. A combination of landline and cell phone random digit dial samples were used; both samples were provided by Survey Sampling. International. ",
  ),
  Comment(
    id: 9,
    userId: 5,
    date: DateTime(2018, 10, 23),
    likes: 23,
    comment:
        "Respondents in the landline sample were selected by randomly asking for the youngest adult male or female who is now at home.",
  ),
  Comment(
    id: 10,
    userId: 5,
    date: DateTime(2018, 11, 23),
    likes: 34,
    comment:
        "The analysis presented here is based on 996 respondents who received Form 2 of the survey; the margin of error for this subset of respondents is plus or minus 3.6 percentage points. ",
  ),
];

//----------------------notifications------------------------

List<InfoNotification> pollNotifications = [
  InfoNotification(
    id: 1,
    infoId: 1,
    date: DateTime(2018, 8, 5),
  ),
  InfoNotification(
    id: 2,
    infoId: 1,
    date: DateTime(2018, 9, 7),
  ),
  InfoNotification(
    id: 3,
    infoId: 2,
    date: DateTime(2018, 10, 2),
  ),
  InfoNotification(
    id: 4,
    infoId: 3,
    date: DateTime(2018, 10, 20),
  ),
  InfoNotification(
    id: 5,
    infoId: 4,
    date: DateTime(2018, 10, 29),
  ),
];

final List<ReplyNotification> replyNotifications = [
  ReplyNotification(
    id: 1,
    senderUserId: 2,
    date: DateTime(2018, 10, 23),
    message: "I am not watching this fight, sorry",
  ),
  ReplyNotification(
    id: 2,
    senderUserId: 1,
    date: DateTime(2018, 10, 23),
    message: "Are you watching this fight",
  ),
  ReplyNotification(
    id: 3,
    senderUserId: 3,
    date: DateTime(2018, 10, 23),
    message: "Nice, Love this fight!",
  ),
  ReplyNotification(
    id: 4,
    senderUserId: 5,
    date: DateTime(2018, 10, 23),
    message:
        "The best part about this fight is that its a draw so I won't lose any cash",
  ),
  ReplyNotification(
    id: 5,
    senderUserId: 3,
    date: DateTime(2018, 10, 23),
    message: "This fight is going to be epic",
  ),
  ReplyNotification(
    id: 6,
    senderUserId: 5,
    date: DateTime(2018, 10, 23),
    message: "Are you attending this fight or na?",
  ),
  ReplyNotification(
    id: 7,
    senderUserId: 4,
    date: DateTime(2018, 10, 23),
    message: "hey there, I think you are wrong on this poll my friend.",
  ),
];
