# Shell setting the proper environment variables to load the test data using gretl
#
# The following Variables must be set properly to access the Pub and Sogis Db's
# export DB_USER_SOGIS='foo'
# export DB_PWD_SOGIS='bar'
# export DB_USER_PUB='foo'
# export DB_PWD_PUB='bar'


# SET GRETL environment variables
#export DB_URI_SOGIS='jdbc:postgresql://geodb.verw.rootso.org/sogis?ApplicationName=gretl&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory'
#export DB_URI_PUB='jdbc:postgresql://geodb_brw.verw.rootso.org/pub?ApplicationName=gretl&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory'
#export DB_URI_EDIT='jdbc:postgresql://10.36.43.208:5432/postgres'

export DB_URI_SOGIS='jdbc:postgresql://geodb.verw.rootso.org/sogis?ApplicationName=gretl&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory'
export DB_URI_PUB='jdbc:postgresql://192.168.50.8:5432/pub?ApplicationName=gretl'
export DB_URI_EDIT='jdbc:postgresql://192.168.50.8:5432/pub'

echo "======================================================="
echo "DB CREDENTIALS"
echo ""
echo "Pub URI: $DB_URI_PUB"
echo "Pub USER: $DB_USER_PUB"
echo "Pub PWD: $DB_PWD_PUB"
echo ""
echo "Sogis URI: $DB_URI_SOGIS"
echo "Sogis USER: $DB_USER_SOGIS"
echo "Sogis PWD: $DB_PWD_SOGIS"
echo ""
echo "Docker DB URI: $DB_URI_EDIT"
echo "Docker DB USER: See build.gradle"
echo "Docker DB PWD: See build.gradle"
echo "======================================================="


# Start local gretl
$(pwd)/start-gretl.sh --docker-image sogis/gretl-runtime:production --job-directory $(pwd)

#start-gretl.sh --docker-image sogis/gretl-runtime:production --job-directory ~/Documents/work/natai/devdb/initialize_db/copy_prod_data

