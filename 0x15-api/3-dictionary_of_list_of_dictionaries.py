#!/usr/bin/python3

"""
script returns information about Employee TODO list
    and creates csv file based on user id
"""


import json
import requests
import sys


if __name__ == "__main__":
    userUrl = f"https://jsonplaceholder.typicode.com/users"
    todoUrl = f"https://jsonplaceholder.typicode.com/todos"
    filename = f"todo_all_employees.json"

    res = requests.get(userUrl)
    users = res.json()
    res = requests.get(todoUrl)
    todos = res.json()

    a_dict = {}
    with open(filename, "w") as f:
        for user in users:
            userId = user["id"]
            a_dict[userId] = []
            userTodos = list(filter(lambda t: t["userId"] == userId, todos))
            for todo in userTodos:
                a_dict[userId].append({
                    "username": user["username"],
                    "task": todo["title"],
                    "completed": todo["completed"]
                })
        json.dump(a_dict, f)
