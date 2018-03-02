import os

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_blocks(width, height):
    block = chr(9608)
    print(bcolors.OKBLUE)
    print(block * width * height)
    print(bcolors.ENDC)

def fill_screen():
    rows, columns = os.popen('stty size', 'r').read().split()
    print_blocks(int(columns), int(rows))

if __name__ == '__main__':
    fill_screen()