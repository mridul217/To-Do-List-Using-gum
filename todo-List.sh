#!/bin/sh

# Function to display the menu and get user choice using gum choose
get_action_choice() {
    gum choose "Add Task" "List Tasks" "Remove Task" "Clear All Tasks" "Exit"
}

# Main loop for the to-do list application
while true; do
    action_choice=$(get_action_choice)

    case "$action_choice" in
        "Add Task")
            echo "Enter the task: "
            read task
            echo "$task" >> todo.txt
            echo "Added task: $task"
            ;;
        "List Tasks")
            if [ -f "todo.txt" ]; then
                echo "Tasks in the to-do list:"
                cat -n todo.txt
            else
                echo "No tasks in the to-do list."
            fi
            ;;
        "Remove Task")
            if [ -f "todo.txt" ]; then
                echo "Tasks in the to-do list:"
                cat -n todo.txt
                echo "Enter the task number to remove: "
                read task_number
                if [ "$task_number" -ge 1 ] 2>/dev/null && [ "$task_number" -le "$(wc -l < todo.txt)" ] 2>/dev/null; then
                    task_to_remove=$(sed "${task_number}q;d" todo.txt)
                    sed -i "${task_number}d" todo.txt
                    echo "Removed task: $task_to_remove"
                else
                    echo "Invalid task number."
                fi
            else
                echo "No tasks in the to-do list."
            fi
            ;;
        "Clear All Tasks")
            if [ -f "todo.txt" ]; then
                rm todo.txt
                echo "All tasks cleared."
            else
                echo "No tasks in the to-do list."
            fi
            ;;
        "Exit")
            echo "Exiting the to-do list program."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
