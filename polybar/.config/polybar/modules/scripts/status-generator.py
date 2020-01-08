import os
import sys
from time import sleep


def realpath(filename):
    return os.path.dirname(os.path.abspath(__file__)) + filename


def get_size(value: int = 0, suffixes: list = ['KB', 'KB', 'MB', 'GB'], i: int = 0) -> str:
        if not isinstance(value, (int, float)):
            return 'unknown'

        while value >= 1024 and i < len(suffixes) - 1:
            value /= 1024
            i += 1

        if not i:
            return f"0.{int(value):0>3} {suffixes[i]}"

        return f"{value:.3f} {suffixes[i]}"


def get_network_statistic(interface: str, id: str) -> int:
    with open(f"/sys/class/net/{interface}/statistics/{id}_bytes") as file:
        return int(file.read())


def main():
    del sys.argv[0]

    interfaces = sys.argv
    interval = 1

    with open(realpath('/status-generator.pid'), 'w') as file:
        file.write(f"{os.getpid()}")

    # rx = down
    # tx = up

    network = {}

    for interface in interfaces:
        try:
            network[interface] = {}
            network[interface]['io_activity'] = 0
            network[interface]['rx_pas'] = get_network_statistic(interface, 'rx')
            network[interface]['tx_pas'] = get_network_statistic(interface, 'tx')
        except FileNotFoundError:
            network[interface]['rx_pas'] = 0
            network[interface]['tx_pas'] = 0

    while True:
        sleep(interval)

        data = []

        for interface in interfaces:
            try:
                network[interface]['rx_now'] = get_network_statistic(interface, 'rx')
                network[interface]['tx_now'] = get_network_statistic(interface, 'tx')
                network[interface]['rx_statistic'] = (
                    (network[interface]['rx_now'] - network[interface]['rx_pas']) / interval)
                network[interface]['tx_statistic'] = (
                    (network[interface]['tx_now'] - network[interface]['tx_pas']) / interval)
                network[interface]['rx_pas'] = network[interface]['rx_now']
                network[interface]['tx_pas'] = network[interface]['tx_now']
                network[interface]['io_statistic_total'] = network[interface]['rx_now'] + network[interface]['rx_now']

                if not network[interface]['rx_statistic'] and not network[interface]['tx_statistic']:
                    if not network[interface]['io_activity']:
                        continue
                    network[interface]['io_activity'] = network[interface]['io_activity'] - 1
                else:
                    network[interface]['io_activity'] = 60

                data.append(
                    f"{get_size(network[interface]['rx_statistic'])}/s  "
                    f"{get_size(network[interface]['tx_statistic'])}/s  "
                    f"{get_size(network[interface]['io_statistic_total'])}"
                )
            except FileNotFoundError:
                pass

        data.append(
            f"{get_size(get_network_statistic('lo', 'rx') + get_network_statistic('lo', 'tx'))}"
        )

        with open('/tmp/network-traffic', 'w') as file:
            data = f"  {'  -  '.join(data)}  -  "
            file.write(data)
            # print(data)


if __name__ == '__main__':
    main()
