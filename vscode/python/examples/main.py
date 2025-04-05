import typing


def print_hello(extend_str: typing.AnyStr):
    if not extend_str:
        print("Hello!")
        return None
    print("Hello {extend_str}!")


if __name__ == "__main__":
    print_hello("World")
