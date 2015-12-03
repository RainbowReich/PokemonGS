# RubyGS

RubyGS is a Ruby Gem that allows Rubyists to view and edit .sav files for the Gold, Silver, and Crystal versions of Pokemon on the Gameboy Color.

These are typically files generated by a Gameboy/Gameboy Color emulator (or a physical backup device, for those of you who are more inclined) that contains the raw data acting as the SRAM on a game cartridge.

##Installation
```
$ gem install ruby_gs
```

##Usage
``` ruby
require 'ruby_gs'

saved_game = SaveFileReader.read "/path/to/save/file.sav" # => SaveFile containing data representing the raw SRAM of your cartridge

saved_game.trainer_name = "Reich" # Note: Most fields that accept a string are limited to 10-character strings or less

saved_game.rival_name = "Bugs"

saved_game.team.pokemon[0].species = 25 # Change our first team pokemon's species to someone very familiar

saved_game.team.pokemon[5].happiness = 255 # That's one happy Pokemon!

saved_game.team.amount = 5 # Annnnnnd now it's gone (Not really, it's just hidden from view)

hours = 78
minutes = 33
seconds = 12
frames = 20

saved_game.time_played = [hours, minutes, seconds, frames] # The amount of frames is not visible to the player and is rather inconsequential in general.

saved_game.item_pocket[3].kind = 1 # Change the 3rd item in our Item Pocket to a Master Ball. 
saved_game.item_pocket[3].amount = 255 # Gotta make sure we have enough for our journey.

saved_game.write # This will write your changes directly to the same save file you initially opened.

saved_game.write "path/to/other/save/file.sav" # This will write your changes to a different location.

```

##Useful Links
+ [List of item indices](http://bulbapedia.bulbagarden.net/wiki/List_of_items_by_index_number_%28Generation_II%29)
+ [List of Pokemon species indices](http://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_%28Generation_II%29)

##TODO:
+ Support for Crystal.
+ Major refactoring.
+ Player Location editing.
+ Event Flag editing (and possibly documenting the purpose of each flag).


_Special thanks to Bulbapedia for hosting the project to document G/S/C's SRAM innards._
