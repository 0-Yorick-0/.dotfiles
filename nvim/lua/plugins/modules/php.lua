return {
    {
        "phpactor/phpactor",
        ft = { "php", "cucumber" },
        branch = "master",
        build = "composer install --no-dev -o",
    },
    { "stephpy/vim-php-cs-fixer" },
    { "squizlabs/PHP_CodeSniffer" },
}
