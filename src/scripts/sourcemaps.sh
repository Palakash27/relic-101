# steps

# 1. set the New Relic App ID in var
NEW_RELIC_APP_ID="601507961"
# 2. set the New Relic User API Key in var
NEW_RELIC_USER_API_KEY="NRAK-GQ1VF07JNKAH57SVVBNPY9O924C"
# 3. build the absolute path to the main directory
PROJ_ROOT_DIR=$(pwd)
# go to $PROJ_ROOT_DIR/.next
NEXT_DIR="$PROJ_ROOT_DIR/.next"

# 4. find all the files with their names ending with .js.map recursively
# 5. loop through the files and upload them to New Relic


# APP_URL="http://localhost:3000"
APP_URL="https://relic-101.vercel.app"

find $NEXT_DIR -type f -name "*.js.map" | while read file; do
    echo "Uploading sourcemap file: $file"

    withMap=$(echo $file)
    # 6. remove the .map extension from the file name
    file=$(echo $file | sed 's/\.map$//g')

    echo "new file name: $file"


    # 7. construct javascriptUrl=$APP_URL+file
    jsurl=$(echo $file | sed "s|$NEXT_DIR||g")
    echo "jsurl: $jsurl"
    jsurlWithMap=$(echo $withMap | sed "s|$NEXT_DIR||g")
    echo "jsurlWithMap: $jsurlWithMap"

    withMapFile="./.next$jsurlWithMap"
    echo "withMapFile without absolute path: $withMapFile"

    file="/.next$jsurl"
    echo "without absolute path: $file"

    # add the app url to the jsurl
    jsurl="$APP_URL/_next$jsurl"

    echo "js url: $jsurl"

    echo "withMapFile: $withMapFile"
    echo "jsurl: $jsurl"

    curl -H "Api-Key: $NEW_RELIC_USER_API_KEY" \
        -F "sourcemap=@$withMapFile" \
        -F "javascriptUrl=$jsurl" \
        -F "releaseId=YOUR_RELEASE_ID" \
        -F "releaseName=YOUR_UI_PAGE" \
        https://sourcemaps.service.newrelic.com/v2/applications/$NEW_RELIC_APP_ID/sourcemaps
done







# curl -H "Api-Key: YOUR_NEW_RELIC_USER_API_KEY" \
#     -F "sourcemap=@SOURCE_MAP_PATH" \
#     -F "javascriptUrl=JS_URL" \
#     -F "releaseId=YOUR_RELEASE_ID" \
#     -F "releaseName=YOUR_UI_PAGE" \
# https://sourcemaps.service.newrelic.com/v2/applications/YOUR_NEW_RELIC_APP_ID/sourcemaps