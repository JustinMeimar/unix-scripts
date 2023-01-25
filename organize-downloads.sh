#/bin/bash

declare -a pictures=("*.pdf", "*.jpg")

for filename in ~/Downloads/* 
do
  #echo "$filename"
  case "$filename" in
    *.png | *.jpg)  
      echo "picture: $filename" ;
      DEST_DIR="/home/justin/Downloads/pictures";
      mkdir -p $DEST_DIR;
      ;; 
    
    *.json) 
      DEST_DIR="/home/justin/Downloads/json";
      mkdir -p $DEST_DIR;
      mv $filename $DEST_DIR;
      ;;

    *.pdf | *.pdf\') 
      DEST_DIR="/home/justin/Downloads/pdf";
      mkdir -p $DEST_DIR;
      mv $filename $DEST_DIR;
      ;;
    
    *.mp4 | *.mp3 )
      DEST_DIR="/home/justin/Downloads/mpx";
      mkdir -p $DEST_DIR;
      mv $filename $DEST_DIR; 
      ;;
    
    *.tar.gz | *.zip | *.deb | *.tar)
      DEST_DIR="/home/justin/Downloads/compressed";
      mkdir -p $DEST_DIR;
      mv $filename $DEST_DIR; 
      ;;
    
    *.* | \'*\')
      echo $filename;
      DEST_DIR="/home/justin/Downloads/misc";
      mkdir -p $DEST_DIR;
      mv $filename $DEST_DIR;
      ;;
  esac
    
done

