#!/bin/bash
if [[ "$1" == "--help" ]]; then
    echo "Usage: $0 [options] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show lines that do NOT match)"
    echo "  --help Show this help message"
    exit 0
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 search_string file_name [options]"
    exit 1
else
    if [[ $1 == -* ]]; then
        option=$1
        if [[ ! $2 == *.txt ]];then
                if [[ $3 == *.txt ]];then
                        search_word=$2
                        file_name=$3
                else
                        echo "insert file end with .txt"
                        exit 1
                fi
        else
                echo "Error: Missing or invalid search word. Usage: $0 search_string filename [options]"
                exit 1
        fi
    else
        option=""
         if [[ ! $1 == *.txt ]];then
                if [[ $2 == *.txt ]];then
                        search_word=$1
                        file_name=$2
                else
                        echo "insert file end with .txt"
                        exit 1
                fi
        else
                echo "Search word error , try again"
                exit 1
        fi
    fi
fi

if [ ! -f "${file_name}" ]; then
    echo "File doesn't exist :("
    exit 1
fi

line_number=0
while IFS= read -r line
do
        ((line_number++))
        if [[ ${option} == *v* ]];then
                if [[ ! ${line} =~ ${search_word} ]];then
                        if [[ ${option} == *n* ]];then
                                echo "${line_number}:${line}"
                        else
                                echo "${line}"
                        fi
                fi
        else
                if [[ ${line} =~ ${search_word} ]];then
                        if [[ ${option} == *n* ]];then
                                echo "${line_number}:${line}"
                        else
                                echo "${line}"
                        fi
                fi
        fi
done < "${file_name}"