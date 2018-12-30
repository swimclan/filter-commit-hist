#!/bin/bash

declare VALUE=$1
declare HEAD=0
declare COMMITS=`git log HEAD~$HEAD`
declare CURRENT_COMMIT_HASH
declare CURRENT_COMMIT
declare LAST_COMMIT_HASH
declare FOUND=0

git log HEAD~$HEAD | while read LINE
do
  if [[ ($LINE =~ ^commit[[:space:]][a-z0-9]{40}$) && ($FOUND -eq 1) ]]
  then
    FOUND=0
    echo -e $CURRENT_COMMIT
    CURRENT_COMMIT=""
  elif [[ $LINE =~ ^commit[[:space:]][a-z0-9]{40}$ ]]
  then
    CURRENT_COMMIT=""
  fi
  
  if [[ $LINE =~ ^.*$(echo $VALUE).*$ ]]
  then
    FOUND=1
  fi
  CURRENT_COMMIT=$CURRENT_COMMIT$LINE"\n"
done

exit 0