version=$(jq -r .version info.json)
name=midymidy-factorio-mod_$version
mkdir $name
cp -r *.lua info.json locale thumbnail.png $name
zip -r $name.zip $name
rm ~/.factorio/mods/midymidy-factorio-mod_*.zip
cp $name.zip ~/.factorio/mods/
rm -rf $name
if [[ $1 = "-u" ]]; then 
    pv ~/.factorio/mods/$name.zip | ssh factorio@factorio.nicball.space "rm ~/factorio/factorio/mods/midymidy-factorio-mod_*.zip; cat > ~/factorio/factorio/mods/$name.zip;"
fi
