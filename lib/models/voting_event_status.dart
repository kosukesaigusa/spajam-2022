enum VotingEventStatus {
  peace(label: 'peace', mood: '😌'),
  waiting(label: 'waiting', mood: '😒'),
  voting(label: 'voting', mood: '🗳'),
  finished(label: 'finished', mood: '🎉');

  const VotingEventStatus({
    required this.label,
    required this.mood,
  });

  final String label;
  final String mood;
}
