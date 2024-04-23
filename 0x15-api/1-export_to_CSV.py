#!/usr/bin/python3
"""
Use the requests module to make a request to an employee REST API
    The request takes in an integer that serves as the employee ID
"""
import csv
import requests
import sys


def main():
    """
    This is the main function for the program
    """
    if len(sys.argv) < 2:
        print("Usage: python3 script.py <employee_id>")
        sys.exit("Not enough information")
    employee_id = sys.argv[1]

    # Make the GET request
    url = "https://jsonplaceholder.typicode.com/users/" + employee_id
    response = requests.get(url)
    employee_details = response.json()

    url = url + "/todos"
    response = requests.get(url)
    employee_todos = response.json()

    # Display formatted details
    name = employee_details["username"]

    # Write to CSV file
    filename = employee_id + ".csv"
    with open(filename, "w", newline="") as csvfile:
        csvwriter = csv.writer(csvfile, quoting=csv.QUOTE_ALL)
        for todo in employee_todos:
            todo_arr = [employee_id, name, todo["completed"], todo["title"]]
            csvwriter.writerow(todo_arr)


if __name__ == "__main__":
    main()
