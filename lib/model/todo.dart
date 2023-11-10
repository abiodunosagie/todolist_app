class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  ///List items for the todo items
  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Morning Exercise',
        isDone: true,
      ),
      ToDo(
        id: '02',
        todoText: 'Buy Groceries',
        isDone: true,
      ),
      ToDo(
        id: '03',
        todoText: 'Call Mr. Ayo for the website idea',
      ),
      ToDo(
        id: '04',
        todoText: 'Check Emails from violet',
        isDone: true,
      ),
      ToDo(
        id: '05',
        todoText: 'Dinner with Mj, and Cynthia',
      ),
      ToDo(
        id: '06',
        todoText: 'Work on mobile apps for 2 hours',
      ),
    ];
  }
}
