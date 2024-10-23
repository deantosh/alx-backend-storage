#!/usr/bin/env python3
"""
Write a Python function that returns the list of school having a
specific topic:
 - Prototype: def schools_by_topic(mongo_collection, topic):
 - mongo_collection will be the pymongo collection object
 - topic (string) will be topic searched
"""
from pymongo import MongoClient


def schools_by_topic(mongo_collection, topic):
    """ List schools having specific topic """
    return list(mongo_collection.find({"topics": topic}))
