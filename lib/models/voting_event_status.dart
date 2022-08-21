import 'package:flutter/material.dart';

enum VotingEventStatus {
  peace(
    status: 'peace',
    mood: '😌',
    chipLabel: '快適',
    moodColor: Color.fromRGBO(83, 215, 88, 1),
  ),
  waiting(
    status: 'waiting',
    mood: '😒',
    chipLabel: '不満',
    moodColor: Color.fromARGB(255, 215, 85, 238),
  ),
  voting(
    status: 'voting',
    mood: '🔥',
    chipLabel: '勃発!!',
    moodColor: Colors.red,
  ),
  finished(
    status: 'エアコン戦争終結',
    mood: '🎉',
    chipLabel: 'エアコン戦争に終止符が打たれました!!',
    moodColor: Colors.blue,
  );

  const VotingEventStatus({
    required this.status,
    required this.mood,
    required this.chipLabel,
    required this.moodColor,
  });

  final String status;
  final String mood;
  final String chipLabel;
  final Color moodColor;
}
