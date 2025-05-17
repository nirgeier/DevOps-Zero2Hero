import os
import signal
import sys
import time


def signal_handler(sig, frame):
    print(f'Got signal number {sig} {frame}')
    print('Handling the last server requests...')
    time.sleep(4)
    print('Serve is closed for new requests')
    time.sleep(1)

    print('Disconnecting from database..')
    time.sleep(3)
    print('Successfully disconnected from db')
    print('Performing other cleanup tasks...')
    time.sleep(7)
    sys.exit(0)


signal.signal(signal.SIGINT, signal_handler)
print(f'Server is running, PID={os.getpid()}')
signal.pause()
