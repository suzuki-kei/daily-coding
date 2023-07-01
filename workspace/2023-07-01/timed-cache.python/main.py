import functools
import time


def main():
    try:
        while True:
            print(get_time())
            time.sleep(0.4)
    except KeyboardInterrupt:
        pass


def timed_cache(ttl_in_seconds):
    def get_time_key():
        return int(time.time()) // ttl_in_seconds

    def decorator(cached_function):
        def wrapper(*args, **kwargs):
            nonlocal previous_time_key
            time_key = get_time_key()

            if time_key != previous_time_key:
                cached_function.cache_clear()
                previous_time_key = time_key
            return cached_function(*args, **kwargs)

        previous_time_key = get_time_key()
        return wrapper

    return decorator


@timed_cache(ttl_in_seconds=2)
@functools.cache
def get_time():
    return time.time()


if __name__ == "__main__":
    main()

