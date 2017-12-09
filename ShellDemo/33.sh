#!/bin/bash
# 逐行读取文件内容
cat test.txt | while read line
do
    echo $line
done


