#!/usr/bin/env python3
"""
Python function to return all students sorted by average score.
"""
from pymongo import MongoClient


def top_students(mongo_collection):
    """
    Returns all students sorted by their average score.
    :param mongo_collection: the pymongo collection object
    :return: a list of students with their average score, sorted by
     average score
    """
    # Retrieve all students
    students = mongo_collection.find()

    # List to store students with their average scores
    students_with_avg = []

    for student in students:
        # Calculate the average score if the 'scores' field exists
        scores = student.get('scores', [])

        if scores:
            # Calculate the average score of all entries in the 'scores' array
            total_score = sum(score['score'] for score in scores)
            average_score = total_score / len(scores)
        else:
            # If no scores, set averageScore to 0
            average_score = 0

        # Append student with calculated average score to the list
        student['averageScore'] = average_score
        students_with_avg.append(student)

    # Sort students by average score in descending order
    sorted_students = sorted(students_with_avg,
                             key=lambda x: x['averageScore'], reverse=True)

    return sorted_students
