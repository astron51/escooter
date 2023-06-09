fx_version 'adamant'

game 'gta5'

description 'Electric Scooter'

files {
    'vehicles.meta',
    'carvariations.meta',
    'handling.meta',
	'dlctext.meta',
}

data_file 'DLCTEXT_FILE' 'dlctext.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta' 

client_script 'vehicle_names.lua'