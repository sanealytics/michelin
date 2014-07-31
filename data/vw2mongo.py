#!/usr/bin/python
import fileinput
#import json
from bson.json_util import dumps
from collections import defaultdict
import argparse
import operator

###############
# TODO: Do a nice argparse
# Could theoretically only store the top 100 or so, drop off the list if too small
#

def process_topic(topic, wordIdx):
  print topic, wordIdx
  

def process_input(labels, topics, skipCol, startRow, endRow, topK):
  lineCnt = 0
  topicDict = defaultdict(lambda: defaultdict(float)) # large storage requirements
  for line in fileinput.input():
    lineCnt+=1
    if lineCnt-startRow > endRow & endRow > -1:
      for topic in topicDict.keys():
        temp = dict()
        #temp[topic] = topicDict[topic]
        topTopics = sorted(topicDict[topic].iteritems(), key=operator.itemgetter(1), reverse=True)[:topK]
        temp[labels[0]] = topic
        temp[labels[1]] = topTopics
        #print json.dumps(temp) #, indent = 2 )
        print dumps(temp) #, indent = 2 )
      break
    if lineCnt > startRow:
      vals = line.strip().split(' ') # strip() gets rid of extra column at end
      if skipCol: # for topics file
        vals.pop(0) # Get rid of first column
      wordIdx = lineCnt-startRow
      # print wordIdx, ',', ','.join(vals)
      #topicDict = zip(xrange(topics), vals)
      #print json.dumps(topicDict)
      for topic in xrange(len(vals)):
        topicDict[topic + 1][wordIdx] = float(vals[topic])


def main():
  labels = ["topic", "words"]
  #process_input(labels, 100, True, 11, 5, 3)
  process_input(labels, 100, True, 11, 246008, 100)

if __name__ == "__main__":
    main()


