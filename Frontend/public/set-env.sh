cp -f /usr/share/nginx/html/index.html /tmp

if [ -n "$REACT_APP_REGION" ]; then
sed -i -e "s|REPLACE_REACT_APP_REGION|$REACT_APP_REGION|g" /tmp/index.html
fi

cat /tmp/index.html > /usr/share/nginx/html/index.html
