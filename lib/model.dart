class FightInfo {
  final int id, pollId;
  final String title, pic, name1Name, name2Name;
  final DateTime postedDate;
  final bool status;

  FightInfo({
    this.id,
    this.pollId,
    this.title,
    this.pic,
    this.postedDate,
    this.name1Name,
    this.name2Name,
    this.status,
  });
}

//------------------FIGHT POLL---------------
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

//---------------CREATE POLL------------------

class CreatePoll {
  final int id;
  final String title;
  final User user_id;
  final DateTime date;
  final String pic;
  final int drawNum, name1Num, name2Num, canceledNum;
  final String name1, name2;

  CreatePoll({
    this.id,
    this.title,
    this.user_id,
    this.date,
    this.pic,
    this.drawNum,
    this.name1Num,
    this.name2Num,
    this.canceledNum,
    this.name1,
    this.name2,
  });
}

// ------------USER MODEL-----------
class User {
  final int id;
  final String email;
  final String username;
  final String password;

  User({
    this.id,
    this.email,
    this.username,
    this.password,
  });
}
