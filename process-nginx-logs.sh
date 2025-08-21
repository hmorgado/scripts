#!/bin/bash

process_file () {
  LOG_FILE=$1
  [ -z "$LOG_FILE" ] && echo "Missing file argument" && exit 1
  cat "$LOG_FILE" | awk '{print $1}' | sort | sed '/^$/d' | uniq -c | sort -bgr | head
  echo ""
  LINES_PROCESSED=$(wc -l $LOG_FILE | cut -d ' ' -f 1 )
  echo Total of $LINES_PROCESSED lines processed
}

process_file $1

# awk '{print $1}' -> separates files by ' ' (default) and prints the first one
# sed '/^$/d'      -> removes empty lines
# uniq -c          -> counts and prints occurrences
# sort -b          -> ignores leading blanks
# sort -g          -> compare according to general numeric value
# sort -r          -> reverse result
# head             -> shows the top 10 lines