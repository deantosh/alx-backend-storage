#!/usr/bin/env python3
"""
Python script to provide some stats about Nginx logs stored in MongoDB:
 - Database: logs
 - Collection: nginx
 - Displays:
     - First line: x logs where x is the number of documents in this collection
     - Second line: Methods:
     - 5 lines with the number of documents for each method ["GET", "POST",
       "PUT", "PATCH", "DELETE"]
     - One line with the number of documents with method=GET and path=/status
"""
from pymongo import MongoClient

# Create the MongoDB client
client = MongoClient("mongodb://localhost:27017/")

# Select the database and collection
db = client["logs"]
collection = db["nginx"]

# Get the total number of logs (documents in the collection)
log_count = collection.count_documents({})
print(f"{log_count} logs")

# Print method statistics
print("Methods:")
methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]

for method in methods:
    method_count = collection.count_documents({"method": method})
    print(f"\tmethod {method}: {method_count}")

# Get the count of documents with method=GET and path=/status
status_check_count = collection.count_documents({
    "method": "GET", "path": "/status"})
print(f"{status_check_count} status check")
