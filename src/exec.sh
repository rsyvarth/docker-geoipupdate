#!/bin/sh -e

# set a configuration file if not already set
! (: "${GEOIP_CONFIG_FILE?}") 2>/dev/null && {
    GEOIP_CONFIG_FILE="/usr/local/etc/maxmind-geoip.conf"
    echo "AccountID $GEOIP_ACCOUNT_ID" >> $GEOIP_CONFIG_FILE
    echo "LicenseKey $GEOIP_LICENSE_KEY" >> $GEOIP_CONFIG_FILE
    echo "EditionIDs ${GEOIP_EDITION_IDS:-"GeoLite2-City GeoLite2-Country"}" >> $GEOIP_CONFIG_FILE
    echo "DatabaseDirectory ${GEOIP_DIRECTORY:-"/usr/local/share/maxmind/"}" >> $GEOIP_CONFIG_FILE
}

cat $GEOIP_CONFIG_FILE

# execute the updates with verbose output
geoipupdate -f $GEOIP_CONFIG_FILE -v
