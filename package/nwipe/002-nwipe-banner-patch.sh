version=`cat ../../../board/datazapper/version.txt`
sed -i "/banner/c\const char* banner = \"DataZapper v$version\";" ./src/version.c

