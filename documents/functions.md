# Cloud Functions 仕様書

## onCreateFeeling

feeling ドキュメントが作成されたときに動作する。

onCreateFeeling 内でやるべきことは次の通り。

1. その votingEvent ドキュメントに作成されたはじめての feeling ドキュメントである場合のみ、その votingEvent ドキュメントの room.userIds を votingUserIds にコピーする
2. 同じく、その votingEvent ドキュメントに作成されたはじめての feeling ドキュメントである場合のみ、現在の votingEvent ドキュメントの status が peace であれば、waiting に変更する
3. isComfortable: false な feeling ドキュメントの数が閾値（要決定）に達した場合、現在の votingEvent ドキュメントの status が peace または waiting であれば voting に変更する。また、その時、votingUserIds のユーザーに対して、FCM の通知で戦争勃発の旨を通知する。location には、rooms/${roomId}/${roomEventId} を指定することで、クライアントで通知をタップするだけで、投票ページに遷移することができる

## onCreateVote

vote ドキュメントが作成されたときに動作する。

onCreateVote が発火したときに、vote コレクションのドキュメントの数が閾値（要決定）に達していなければ何もしない。

達している場合に行われる処理は次の通り。

1. 何らかのロジックに従って投票結果 (VoteEnum) の値を確定し、当該 votingEvent ドキュメントの result を更新する
2. 同時に新たな
3. その時、votingUserIds のユーザーに対して、投票が終わった旨の通知を行う。location には rooms/${roomId} を指定する...？
