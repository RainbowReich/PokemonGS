require_relative "save_file_reader"

IO.copy_stream("/home/reich/.vbam/silver.sav", "/home/reich/.vbam/silver.sav.bak") #backup

save = SaveFileReader.read("/home/reich/.vbam/silver.sav")

save.money.assign 696969
save.time_played.assign [0,6,66,0]
save.trainer_palette.assign 1
save.trainer_id.assign 420 
save.set_team_species 0, rand(251)

save.trainer_name = "abcdefghij"
save.rival_name = "Penis"
save.team.name[0] =

puts save.trainer_name
puts save.mom_name
puts save.rival_name
puts save.red_name
puts save.blue_name

save.write

`vbam --ifb-filter=1 --filter=2 --pause-when-inactive /home/reich/silver.gbc`

