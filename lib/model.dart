//-----------------FIGHT INFO------------------
class Info {
  final int id;
  final int userId;
  final int pollId;
  final String title, pic, name1, name2;
  final DateTime postedDate;
  final bool status;

  Info({
    this.id,
    this.pollId,
    this.userId,
    this.title,
    this.pic,
    this.postedDate,
    this.name1,
    this.name2,
    this.status,
  });
}

//------------------FIGHT POLL-----------------
class FightPoll {
  final int id;
  final int drawNum, name1Num, name2Num, canceledNum;

  FightPoll({
    this.id,
    this.drawNum,
    this.name2Num,
    this.name1Num,
    this.canceledNum,
  });
}

// -----------------USER MODEL----------------
class User {
  final int id;
  final String email;
  final String username;
  final String pic;
  final String password;

  User({
    this.id,
    this.email,
    this.username,
    this.pic,
    this.password,
  });
}

//------------------COMMENTS MODEL------------
class Comment {
  final int id;
  final int userId;
  final DateTime date;
  final String comment;
  final int likes;

  Comment({
    this.id,
    this.userId,
    this.comment,
    this.date,
    this.likes,
  });
}

//----------------NOTIFICATION MODEL-----------
class Notification {
  final int id;
  final int userId;
  final int infoId;
  final String subtitle;
  final DateTime date;

  Notification({
    this.id,
    this.userId,
    this.infoId,
    this.date,
    this.subtitle,
  });
}
