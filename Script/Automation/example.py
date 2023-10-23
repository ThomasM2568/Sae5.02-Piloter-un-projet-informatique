#-------------------------------------------
#              Module Import
#-------------------------------------------

import argparse

#-------------------------------------------
#              Argument parsing
#
#-------------------------------------------

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--arg', help='give an input for the script')

args = parser.parse_args()

#-------------------------------------------
#                   Main
#-------------------------------------------

def main():
  '''
  @args:
  None

  @output:
  Hello World
  '''
  print("Hello World")

if __name__ == '__main__':
  main()
