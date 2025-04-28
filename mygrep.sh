#!/bin/bash
show_help(){
    echo "Usage: $0 [options] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show lines that do NOT match)"
    echo "  --help    Show this help message"
    exit 0
}

if [[ $1 == "--help" ]];then
    show_help
fi

show_line=false
invert=false

while getopts ":nv" opt; do
    case $opt in
        n)
            show_line=true ;;
        v)
            invert=true ;;
        \?)
            echo "Invalid option"
            exit 1 ;;
    esac
done

shift $((OPTIND -1))

# check for the correct of the word
if [[ $1 == *.* ]];then
    echo "The word can't be a file"
    echo "Usage: $0 [options] search_string file_name"
    exit 1
else
    search_word=$1
fi

# check for the extension of the text file
if [[ $2 == *.txt ]];then
    file_name=$2
else
    echo "The file should be a .txt file"
    echo "Usage: $0 [options] search_string file_name"
    exit 1
fi

# check if the text exists or not
if [ ! -f "${file_name}" ]; then
    echo "File doesn't exist :("
    exit 1
fi

line_number=0
while IFS= read -r line
do
    ((line_number++))
    if [[ ${invert} == true ]];then
        if [[ ! ${line,,} =~ ${search_word,,} ]];then
            if [[ ${show_line} == true ]];then
                echo "${line_number}:${line}"
            else
                echo "${line}"
            fi
        fi
    else
        if [[ ${line,,} =~ ${search_word,,} ]];then
            if [[ ${show_line} == true ]];then
                echo "${line_number}:${line}"
            else
                echo "${line}"
            fi
        fi
    fi
done < "${file_name}"