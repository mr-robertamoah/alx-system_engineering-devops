#!/usr/bin/python3

"""
script returns information about Employee TODO list
"""

if __name__ == "__main__":
    import json
    import requests
    import sys

    userId = sys.argv[1]
    userUrl = f"https://jsonplaceholder.typicode.com/users?id={userId}"
    todoUrl = f"https://jsonplaceholder.typicode.com/todos?userId={userId}"

    res = requests.get(userUrl)
    user = res.json()[0]
    res = requests.get(todoUrl)
    todos = res.json()

    completed = len(list(filter(lambda x: x["completed"] is True, todos)))
    print(f"Employee {user['name']} is done with tasks({completed}/20):")
    for todo in todos:
        if todo["completed"]:
            print(f"\t {todo['title']}")
