export class Todo {
    description = ``
    dueDateTime?: FirebaseFirestore.Timestamp
    isDone = false
    title = ``
    todoId = ``
    userId = ``
    createdAt?: FirebaseFirestore.Timestamp
    updatedAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Todo>) {
        Object.assign(this, partial)
    }
}
