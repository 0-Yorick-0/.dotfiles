# determine versions of PHP installed with HomeBrew
# if you want to dynamically list all your installed versions of PHP, uncoment
# this, but be warned that it will slow down all your sessions startup
# installedPhpVersions=(
# 	"$(brew ls --versions | ggrep -E 'php(@.*)?\s' | ggrep -oP '(?<=\s)\d\.\d' | uniq | sort)"
# )

installedPhpVersions=("7.4" "8.1" "8.5")
echo "${installedPhpVersions[@]}"

# create alias for every version of PHP installed with HomeBrew
for phpVersion in "${installedPhpVersions[@]}"; do
	value="{"

	#first, we create the first part of the alias,
	# that will unlink all other versions of PHP
	for otherPhpVersion in "${installedPhpVersions[@]}"; do
		if [ "$otherPhpVersion" = "$phpVersion" ]; then
			continue
		fi

		value="${value} brew unlink php@${otherPhpVersion};"
	done

	# then we concatenant the first part, previously built
	# e.g. typing "7.4" will result in :
	# { brew unlink php@7.4; brew unlink php@8.1 ; brew link php@8.5 --force --overwrite; } &> /dev/null && php -v
	value="${value} brew link php@${phpVersion} --force --overwrite; } &> /dev/null && php -v"

	alias "$phpVersion"="$value"
done
