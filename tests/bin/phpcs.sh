#!/usr/bin/env bash

if [[ ${RUN_PHPCS} == 1 ]]; then
	echo $TRAVIS_COMMIT_RANGE
	CHANGED_FILES=`git diff --name-only --diff-filter=ACMR $TRAVIS_COMMIT_RANGE | grep \\\\.php | awk '{print}' ORS=' '`
	IGNORE=""

	if [ "$CHANGED_FILES" != "" ]; then
		# Install wpcs globally:
		composer require woocommerce/woocommerce-sniffs

		echo "Modified files in commit:"
		echo $CHANGED_FILES

		echo "Running Code Sniffer."
		./vendor/bin/phpcs --ignore=$IGNORE --encoding=utf-8 -s -n -p $CHANGED_FILES
	else
		echo "No PHP files modified. Skipping Coding Standards Test"
	fi
fi
