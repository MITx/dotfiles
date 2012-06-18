#!/bin/bash
DIR=$(dirname $0)
DOTLINKS=$(find $DIR -maxdepth 1 -name ".*" -type f | grep -v "swp")
DOTDIRS=$(find $DIR -maxdepth 1 -name ".*.d" -type d)
LINKS="$DOTLINKS $DOTDIRS"
for file in $LINKS; do
    link="$HOME/$(basename $file)"
    if [[ -L "$link" ]];then
        echo "skipping $file"
    else
        if [[ -r "$link" ]];then
            echo "backing up ${link}"
            mv $link{,.bak}
        fi
        ln -s $file $link
        echo "creating symlink $link"
    fi
done
