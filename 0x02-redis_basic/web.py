#!/usr/bin/env python3
"""
In this tasks, we will implement a get_page function (prototype: def get_
page(url: str) -> str:). The core of the function is very simple. It uses the
requests module to obtain the HTML content of a particular URL and returns it.
"""
import requests
import time
from functools import wraps


# Cache dictionary
cache = {}


def cache_decorator(expiration_time):
    """
    A decorator to cache the results of a function with a specified
    expiration time.
    """
    def decorator(func):
        @wraps(func)
        def wrapper(url):
            current_time = time.time()
            if url in cache:
                cached_data, timestamp = cache[url]
                # Check if the cached data is still valid
                if current_time - timestamp < expiration_time:
                    return cached_data
            # Call the actual function and cache its result
            result = func(url)
            cache[url] = (result, current_time)
            return result
        return wrapper
    return decorator


@cache_decorator(expiration_time=10)
def get_page(url: str) -> str:
    """
    Fetch the HTML content of a particular URL and return it.
    Track how many times the URL was accessed.
    """
    # Track URL access count
    access_key = f"count:{url}"
    if access_key in cache:
        cache[access_key] = (cache[access_key][0] + 1, cache[access_key][1])
    else:
        cache[access_key] = (1, time.time())  # Initialize access count

    # Fetch the HTML content
    response = requests.get(url)
    return response.text
