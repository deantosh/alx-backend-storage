#!/usr/bin/env python3
"""
Create a Cache class. In the __init__ method, store an instance of the Redis
client as a private variable named _redis (using redis.Redis()) and flush the
instance using flushdb.

Class methods:
1. Create a store method that takes a data argument and returns a string.
      -> The method should generate a random key (e.g. using uuid), store the
      input data in Redis using the random key and return the key.

2. Create a get method that take a key string argument and an optional
   Callable argument named fn.
      -> This callable will be used to convert the data back to the desired
         format.
      -> 2 fn's get_str and get_int

Type-annotate store correctly. Remember that data can be a str, bytes,
int or float.
"""
import redis
import uuid
from typing import Optional, Union, Callable


class Cache:
    """ Define a redis cache class """
    def __init__(self):
        """ Initialize the class and flush Redis """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """ Takes argument, Generates a random key and store data in Redis """
        self.key = str(uuid.uuid4())  # generate id which is a str
        self._redis.set(self.key, data)  # store data in redis

        return self.key

    def get(self,
            key: str,
            fn: Optional[Callable[[bytes], Union[int, str, float]]] = None
            ) -> Union[str, bytes, int, float, None]:
        """
        Retrieve data from Redis by key and convert it back to its original
        type. If `fn` is provided, apply the function to decode the data
        (str, int, float).
        """
        # Get raw data from Redis --(which by default is binary format)
        data = self._redis.get(key)

        if data is None:
            return None

        if fn:
            return fn(data)  # decode data from binary

        return data

    def get_str(self, key: str) -> Optional[str]:
        """
        Retrieve a string from Redis.
        Calls get() with a callable to decode bytes into a UTF-8 string.
        """
        return self.get(key, lambda data: data.decode('utf-8'))

    def get_int(self, key: str) -> Optional[int]:
        """
        Retrieve an integer from Redis.
        Calls get() with a callable to convert bytes into an int.
        """
        return self.get(key, lambda data: int(data.decode('utf-8')))
