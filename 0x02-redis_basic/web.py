#!/usr/bin/env python3
"""
In this tasks, we will implement a get_page function (prototype: def get_page
(url: str) -> str:). The core of the function is very simple. It uses the
requests
Module to obtain the HTML content of a particular URL and returns it.
"""
import redis
import requests
import time
from typing import Callable, Optional


# Initialize Redis client
redis_client = redis.Redis()


def cache_page(method: Callable) -> Callable:
    """Decorator to cache page responses."""
    def wrapper(url: str) -> str:
        # Check if the cached value exists
        cached_value = redis_client.get(url)
        if cached_value:
            return cached_value.decode('utf-8')  # Return cached value

        # Call the original method to fetch the page
        response = method(url)

        # Store the result in Redis with an expiration time of 10 seconds
        redis_client.setex(url, 10, response)

        # Increment access count
        redis_client.incr(f"count:{url}")

        return response

    return wrapper


@cache_page
def get_page(url: str) -> str:
    """Fetch the HTML content of a URL."""
    response = requests.get(url)
    return response.text
