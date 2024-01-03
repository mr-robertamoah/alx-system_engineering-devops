#!/usr/bin/python3

"""
script returns information about Employee TODO list
    and creates csv file based on user id
"""


import json
import requests
import sys


if __name__ == "__main__":
    userId = sys.argv[1]
    userUrl = f"https://jsonplaceholder.typicode.com/users?id={userId}"
    todoUrl = f"https://jsonplaceholder.typicode.com/todos?userId={userId}"
    filename = f"{userId}.csv"

    res = requests.get(userUrl)
    user = res.json()[0]
    res = requests.get(todoUrl)
    todos = res.json()

    with open(filename, "w") as f:
        for todo in todos:
            f.write(f""""{todo['userId']}","{user['username']}",\
"{todo['completed']}","{todo['title']}"\n""")
