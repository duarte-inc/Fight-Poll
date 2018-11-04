//-----------------FIGHT INFO------------------
class Info {
  final int id;
  final int userId;
  final int pollId; //this is for the numbers
  final String title, pic, name1, name2;
  final DateTime postedDate;
  final bool status; //closed or not

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
  final int id, userId;
  final int drawNum, name1Num, name2Num, canceledNum;

  FightPoll({
    this.id,
    this.userId, //to get the person who created the poll
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
  final int userId; //the person who created the comment
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

//----------------Info NOTIFICATION MODEL-----------
class InfoNotification {
  final int id;
  final int infoId; //To get the poll names and creator pf the poll
  final int recieverUserId; //the user recieving the notification
  final DateTime date;

  InfoNotification({
    this.id,
    this.infoId,
    this.recieverUserId,
    this.date,
  });
}

//-------------Reply Notification-----------------

class ReplyNotification {
  final int id;
  final int commentId; // so we can insert the reply at this comment
  final int senderUserId;
  final int infoId;
  final DateTime date;
  final String message;

  ReplyNotification({
    this.id,
    this.commentId,
    this.senderUserId,
    this.infoId,
    this.date,
    this.message,
  });
}
