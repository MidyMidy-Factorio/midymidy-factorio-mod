rm midymidy-factorio-mod_*.zip
version=$(jq -r .version info.json)
name=midymidy-factorio-mod_$version
mkdir $name
cp -r *.lua info.json locale thumbnail.png $name
zip -r $name.zip $name
rm -r $name
sudo rm /etx/nixos/factorio-mods/midymidy-factorio-mod_*.zip
sudo cp $name.zip /etc/nixos/factorio-mods/
cp $name.zip /var/aria2d/
