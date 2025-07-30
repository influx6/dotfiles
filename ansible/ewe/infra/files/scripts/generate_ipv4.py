#!/usr/bin/env python3

"""Generates a list of python ip list from the provided range"""
import sys


class ArgumentException(Exception):
    """Exception when argument is incorrect or invalid"""

    pass


def _ip4_generate_ip_range(from_ip: str, to_ip: str):
    from_ip_parts = list(map(lambda t: int(t), from_ip.split(".")))
    if len(from_ip_parts) != 4:
        raise ArgumentException(
            f"from_ip: expected ipv4 four parts ip address and not {from_ip}"
        )
    to_ip_parts = list(map(lambda t: int(t), to_ip.split(".")))
    if len(to_ip_parts) != 4:
        raise ArgumentException(
            f"to_ip: expected ipv4 four parts ip address and not {to_ip}"
        )

    if from_ip_parts[:3] != to_ip_parts[:3]:
        raise ArgumentException(
            f"ip must have within the same subnet range: {from_ip_parts[:3]} != {to_ip_parts[:3]}"
        )

    difference = to_ip_parts[3] - from_ip_parts[3]
    if difference == 0:
        print(to_ip)
        return

    should_reverse = False
    if difference < 0:
        difference = difference * -1
        should_reverse = True
        from_ip_parts = to_ip_parts

    ip_set = [from_ip if not should_reverse else to_ip]
    ip_set.extend(
        list(
            map(
                lambda index: f"{from_ip_parts[0]}.{from_ip_parts[1]}.{from_ip_parts[2]}.{from_ip_parts[3] + index}",
                range(1, difference),
            ),
        )
    )
    ip_set.append(to_ip if not should_reverse else from_ip)

    ip_set = ",".join(ip_set)
    print(ip_set)


if __name__ == "__main__":
    command_args = list(sys.argv)
    _ip4_generate_ip_range(*command_args[1:3])
