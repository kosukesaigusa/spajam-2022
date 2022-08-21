import * as functions from 'firebase-functions'
import { VoteRepository } from '~/src/repositories/vote'
import { VotingEventRepository } from '~/src/repositories/votingEvent'
import { completeVotingEvent } from '~/src/utils/vote'

/**
 *
 */
export const onCreateCompleteVotingRequest = functions
    .region(`asia-northeast1`)
    .firestore.document(`/rooms/{roomId}/votingEvents/{votingEventId}/completeVotingRequests/{completeVotingRequestId}`)
    .onCreate(async (_, context) => {
        const { roomId, votingEventId } = context.params

        const votingEventRepository = new VotingEventRepository()
        const votingEvent = await votingEventRepository.fetchVotingEvent({ roomId, votingEventId })
        if (votingEvent === undefined) {
            functions.logger.error(
                `指定のVotingEventが存在しません: { roomId: ${roomId}, votingEventId: ${votingEventId} }`
            )
            return
        }
        if (votingEvent.status !== `voting`) {
            functions.logger.error(`現在投票中ではありません。`)
            return
        }
        const userIds = votingEvent.votingUserIds
        const voteRepository = new VoteRepository()
        const votes = await voteRepository.fetchVotes({ roomId, votingEventId })
        functions.logger.info(`一定時間が経過したので結果を算出します。`)

        await completeVotingEvent({ votes, roomId, votingEventId, userIds })
    })
