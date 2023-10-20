return {
    {
        "phpactor/phpactor",
        dependencies = {
            { "stephpy/vim-php-cs-fixer" },
            { "squizlabs/PHP_CodeSniffer" },
        },
        ft = { "php", "cucumber" },
        branch = "master",
        build = "composer install --no-dev -o",
    },
}
