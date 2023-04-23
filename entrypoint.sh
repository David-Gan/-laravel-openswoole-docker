cd /var/www

if [ -f ./.env ]; then
  composer install
  php artisan migrate
  php artisan cache:clear
  php artisan optimize

  php artisan octane:start --host 0.0.0.0 --watch
fi