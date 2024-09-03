from functools import wraps
from memory_profiler import memory_usage

def mem_timer(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        mem_before = memory_usage()[0]
        result = func(*args, **kwargs)
        mem_after = memory_usage()[0]
        print(f"Function Name: {func.__name__} \nMemory Use: {mem_after - mem_before} MB")
        return result
    return wrapper

@mem_timer
def example_function():
    print("123")
    pass

if __name__=="__main__":
    example_function()