from time import time
from functools import wraps

def fn_timer(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time()
        result = func(*args, **kwargs)
        end_time = time()
        print(f"Function Name: {func.__name__} \nTime Use: {end_time - start_time}s")
        return result
    return wrapper

@fn_timer
def example_function():
    for i in range(1,100000000):
        pass
    pass

if __name__ == "__main__":
    example_function()