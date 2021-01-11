#!/bin/sh

WORKDIR=$(mktemp -d /tmp/get_ips.XXXXXX)
OUTPUT_FILE="${1=bypassvpn.txt}"

# Use maxmind GeoLite2-ASN file: Register to maxmind.com to get a api key (free for personal usage)
LICENCE_KEY=${2=aaaaaa}

GEOFILE=$WORKDIR/tmp_geofile.zip

curl -s "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN-CSV&license_key=${LICENCE_KEY}&suffix=zip" >$GEOFILE

# https://bgp.he.net/search?search%5Bsearch%5D=netflix&commit=Search%27
# Find NetFlix AS
for as in $(unzip -p $GEOFILE \
  $(unzip -l $GEOFILE | grep -e GeoLite2-ASN-Blocks-IPv4.csv | sed 's/^.\{30\}//g') |
  grep -i 'netflix\|,2906,\|,55095,\|,40027,\|,394406,' |
  cut -d"," -f2 | sort -u); do
  whois -h whois.radb.net -- '-i origin AS'$as | grep -Eo "([0-9.]+){4}/[0-9]+" >>$WORKDIR/tmp_getips.tmp
done

cat $WORKDIR/tmp_getips.tmp | sort -u >$OUTPUT_FILE
rm -rf $WORKDIR
