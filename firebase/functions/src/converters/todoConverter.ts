import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { Todo } from '../models/todo'

export const todoConverter: FirestoreDataConverter<Todo> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): Todo {
        const data = qds.data()
        return {
            description: data.description,
            dueDateTime: data.dueDateTime,
            isDone: data.isDone,
            title: data.title,
            todoId: qds.id,
            userId: data.userId,
            createdAt: data.createdAt,
            updatedAt: data.updatedAt
        }
    },
    toFirestore(todo: Todo): FirebaseFirestore.DocumentData {
        return {
            description: todo.description,
            dueDateTime: todo.dueDateTime,
            isDone: todo.isDone,
            title: todo.title,
            todoId: todo.todoId,
            userId: todo.userId,
            createdAt: FieldValue.serverTimestamp(),
            updatedAt: FieldValue.serverTimestamp()
        }
    }
}
