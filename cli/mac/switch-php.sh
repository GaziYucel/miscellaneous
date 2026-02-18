#!/bin/bash  
 
# Check if a version argument is provided  
if [ $# -eq 0 ]; then  
  echo "Usage: switch-php.sh <version>"  
  echo "Example: switch-php.sh 8.4"  
  echo "Installed versions: $(brew list | grep 'php@' | sed 's/php@//' | tr '\n' ' ')"  
  exit 1  
fi  
 
DESIRED_PHP_VERSION=$1  
PHP_FORMULA="php@$DESIRED_PHP_VERSION"  
 
# Check if the PHP version is installed  
if ! brew list "$PHP_FORMULA" &> /dev/null; then  
  echo "Error: $PHP_FORMULA is not installed. Install it first with:"  
  echo "brew install shivammathur/php/$PHP_FORMULA"  
  exit 1  
fi  
 
# Unlink the current PHP version (if any)  
CURRENT_PHP=$(php -v | head -n 1 | awk '{print $2}' | cut -d '.' -f 1,2)  
if [ "$CURRENT_PHP" != "$DESIRED_PHP_VERSION" ]; then  
  echo "Unlinking current PHP ($CURRENT_PHP)..."  
  brew unlink "php@$CURRENT_PHP" &> /dev/null  
fi  
 
# Link the desired PHP version  
echo "Linking $PHP_FORMULA..."  
brew link "$PHP_FORMULA" --force --overwrite  
 
# Verify the switch  
NEW_PHP_VERSION=$(php -v | head -n 1 | awk '{print $2}' | cut -d '.' -f 1,2)  
if [ "$NEW_PHP_VERSION" = "$DESIRED_PHP_VERSION" ]; then  
  echo "Success! Switched to PHP $NEW_PHP_VERSION"  
else  
  echo "Error: Failed to switch to PHP $DESIRED_PHP_VERSION"  
  exit 1  
fi  