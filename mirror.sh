#!/bin/sh
# author: Michael Chelen http://mikechelen.com http://twitter.com/mikechelen
# license: Creative Commons Zero
# saves file structure of Pubmed Central XML archives
# file list: http://www.ncbi.nlm.nih.gov/pmc/about/ftp.html#XML_for_Data_Mining

# path for temporary files
tempdir=tmp
mkdir -p $tempdir
# directory for article files
filedir=files
mkdir -p $filedir
# ftp server and remote path
ftp=ftp.ncbi.nlm.nih.gov
ftppath=pub/pmc
# download files and extract
for I in A-B C-H I-N O-Z;
do
 curfile=articles.$I.tar.gz
 cururl=ftp://$ftp/$ftppath/$curfile
 echo "Downloading $cururl to $tempdir"
# download file to temporary directory
 wget -P $tempdir $cururl
# use up to 5 concurrent connections
# aria2c -d $tempdir -s 5 $cururl
 echo "Exctracting $tempdir/$curfile to $filedir"
 tar -C $filedir --totals -xzf $tempdir/$curfile
 echo Done extracting $tempdir/$curfile
done
# remove temporary files
rm -r $tempdir
