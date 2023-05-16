cd /var/www

composer require laravel/octane
composer install
npm install --save-dev chokidar

if [ -f ./.env ]; then
  php artisan migrate
  php artisan cache:clear
  php artisan optimize

  php artisan octane:start --host 0.0.0.0 --watch
fi
