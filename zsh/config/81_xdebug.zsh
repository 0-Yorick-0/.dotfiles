# Comment out ini files.
alias ini-disable="sed -iE 's/^;* */; /'"
alias ini-enable="sed -iE 's/^;* *//'"

# Toggle Xdebug.
function xdebug-on() {
	ini-enable $(php -i | grep xdebug.ini)
	brew services restart php
}

function xdebug-off() {
	ini-disable $(php -i | grep xdebug.ini)
	brew services restart php
}
