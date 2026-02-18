<?php
$command = '
echo ">>>>> /usr/local/php84/bin/php occ files:cleanup"
#/usr/local/php84/bin/php occ files:cleanup

echo ">>>>> /usr/local/php84/bin/php occ files:repair-tree"
#/usr/local/php84/bin/php occ files:repair-tree

echo ">>>>> /usr/local/php84/bin/php occ files:scan --all"
#/usr/local/php84/bin/php occ files:scan --all

echo ">>>>> /usr/local/php84/bin/php occ sharing:cleanup-remote-storages"
#/usr/local/php84/bin/php occ sharing:cleanup-remote-storages

echo ">>>>> /usr/local/php84/bin/php occ versions:cleanup"
#/usr/local/php84/bin/php occ versions:cleanup

echo ">>>>> /usr/local/php84/bin/php occ bookmarks:clear-previews"
#/usr/local/php84/bin/php occ bookmarks:clear-previews

echo ">>>>> /usr/local/php84/bin/php occ maintenance:repair"
#/usr/local/php84/bin/php occ maintenance:repair

echo ">>>>> /usr/local/php84/bin/php occ maintenance:repair-share-owner"
#/usr/local/php84/bin/php occ maintenance:repair-share-owner

echo ">>>>> /usr/local/php84/bin/php occ check"
#/usr/local/php84/bin/php occ check

echo ">>>>> /usr/local/php84/bin/php occ trashbin:cleanup --all-users"
#/usr/local/php84/bin/php occ trashbin:cleanup --all-users

echo ">>>>> /usr/local/php84/bin/php occ preview:pre-generate"
#/usr/local/php84/bin/php occ preview:pre-generate

echo ">>>>> /usr/local/php84/bin/php occ maintenance:repair --include-expensive"
#/usr/local/php84/bin/php occ maintenance:repair --include-expensive

echo ">>>>> /usr/local/php84/bin/php occ geoblocker:localization-service:reset-db 2"
#/usr/local/php84/bin/php occ geoblocker:localization-service:reset-db 2
';
?>
<html>
<head></head>
<body>
<pre>
<?php
// echo shell_exec($command);
?>
</pre>
</body>
</html>
