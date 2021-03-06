#!/bin/bash
cd tests
echo "setting up test environment (this might take a while)..."
python bootstrap.py >/dev/null 2>&1
./bin/buildout >/dev/null 2>&1
echo "running tests"
if [ $1 ]; then
    suite="cms.$1"
else
    suite='cms'
fi
./bin/coverage run --rcfile=.coveragerc testapp/manage.py test $suite
retcode=$?
echo "post test actions..."
./bin/coverage xml
./bin/coverage html
cd ..
echo "done"
exit $retcode
