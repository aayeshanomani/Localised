const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

var msgData;
var tok = [];

exports.offerTrigger = functions.firestore
    .document('ChatRoom/{ChatRoomId}')
    .onCreate((snapshot, context)=>
    {
        msgData = snapshot.data();

        admin.firestore().collection('tokens')
            .get().then((snapshots)=>
            {
                if(snapshots.empty)
                {
                    console.log('no devices');
                }
                else if(snapshots.length==1)
                {
                    if(toke.data().username == msgData.users[0])
                        {
                            tok.push(toke.data().token)
                        }
                        var payload = 
                        {
                            "notification":
                            {
                                "title": msgData.users[1],
                                "body": "You have a new message from"+msgData.users[1],
                                "sound": "default"
                            },
                            "data":
                            {
                                "sender": msgData.users[1],
                                "message": "Open to check"
                            }
                        }
                }
                else
                {
                    for(var toke of snapshots.docs)
                    {
                        if(toke.data().username == msgData.users[0])
                        {
                            tok.push(toke.data().token)
                        }
                        var payload = 
                        {
                            "notification":
                            {
                                "title": msgData.users[1],
                                "body": "You have a new message from"+msgData.users[1],
                                "sound": "default"
                            },
                            "data":
                            {
                                "sender": msgData.users[1],
                                "message": "Open to check"
                            }
                        }
                    }
                    return admin.messaging().sendToDevice(tok, payload)
                        .then((response)=>
                        {
                            console.log("pushed");
                        }).catch((e)=>
                        {
                            console.log(e);
                        });
                }
            });
    });

    exports.offerTrigger = functions.firestore
    .document('ChatRoom/{ChatRoomId}')
    .onUpdate((snapshot, context)=>
    {
        msgData = snapshot.data();

        admin.firestore().collection('tokens')
            .get().then((snapshots)=>
            {
                if(snapshots.empty)
                {
                    console.log('no devices');
                }
                else
                {
                    for(var toke of snapshots)
                    {
                        if(toke.data().username == msgData.users[0])
                        {
                            tok.push(toke.data().token)
                        }
                        var payload = 
                        {
                            "notification":
                            {
                                "title": msgData.users[1],
                                "body": "You have a new message from"+msgData.users[1],
                                "sound": "default"
                            },
                            "data":
                            {
                                "sender": msgData.users[1],
                                "message": "Open to check"
                            }
                        }
                        return admin.messaging().sendToDevice(tok, payload)
                            .then((response)=>
                            {
                                console.log("pushed");
                            }).catch((e)=>
                            {
                                console.log(e);
                            });
                    }
                }
            });
    });