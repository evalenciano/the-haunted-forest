#!/bin/bash

game=0
cd start
until [ $game == 1 ] || [ $game == 2 ]; do
	kerosene=0
	knife=0
	blanket=0
	match=0
	amulet=0

	if [ $(basename $(pwd)) = start ]; then
		echo "One foggy night, you were driving on a deserted road in the middle of nowhere. Suddenly, you heard a shill scream from the woods next to you, and your car suddenly broke down. You exit the car in hopes of fixing it without avail. You read a sign next to you. 'Welcome to the Haunted Forest.'"
		echo "Would you like to enter the forest?(y/n)"
		read action
		case $action in
		  y) echo You said yes.
		 	cd forest;;
		  n) echo You said no.
			cd outside ;;
		  *) echo Please answer with y/n. \"$action\" ;;
		esac
	fi

	#forest
	if [ $(basename $(pwd)) = forest ]; then
		echo "You have entered the forest. You may not go back at this point, but you may freely go to places you have already visited via go-to <location>. Rumor is there's a monster lurking somewhere near the forest. Be cautious. Press any key to continue."
		read action
		case $action in
		  *) cd entry;;
		esac
	fi

	#outside
	if [ $(basename $(pwd)) = outside ]; then
	  echo "When trying to leave, you suddenly died."
	  cd dead
	fi

	#entry
	if [ $(basename $(pwd)) = entry ]; then
		echo "Location:entry - You find three items on the floor: a kerosene lamp, a knife, and a blanket. 'You may only have one item at a time,' the sign next to them dictated. However, you may return here to switch items. Which item would you like to take? (1/2/3)"
		read action
		case $action in
		  1) echo You chose the kerosene.
			knife=0
			lamp=1
			blanket=0
			cd oak ;;
		  2) echo You chose the knife
			knife=1
			lamp=0
			blanket=0
			cd oak ;;
		  3) echo You chose the blanket.
			knife=0
			lamp=0
			blanket=1
			cd oak ;;
		esac
	fi

	#oak
	if [ $(basename $(pwd)) = oak ]; then
		echo "After picking up your item, you make your way to the large oak tree in the center of the forest. There are three paths to take: 1)lake 2)cave 3)field. You pick a destination. (Note: All locations in the forest are accessible via 'go-to <location>.)"
		read action
		case $action in
		 	1) echo "You approach the lake."
				cd lake ;;
		  	2) echo "You aproach the cave."
				cd cave ;;
		  	3) echo "You approach the open field."
				cd field ;;
			back) echo "You choose to go back."
				cd .. ;;
		esac
	fi

	#lake
	if [ $(basename $(pwd)) = lake ]; then
		if [ $blanket -eq 1 ]; then
		  	echo "You lay down on your blanket by the lake. While lying down, you find a MATCH on the ground. You add the match to your inventory."
		  	match=1
		fi
			echo "The water is so still. You rest a bit. You then return to the oak tree."
			cd ..
	fi

	#cave
	if [ $(basename $(pwd)) = cave ]; then
		if [ $lamp == 1 and $match == 1 ]; then
			echo  "With the match you found, you light your kerosene lamp. In the depths of the cave, you find an amulet. You then return to the oak tree."
		 	amulet=1
		 	cd ..
		else
			echo "It's so dark. You can't go inside. You return to the oak tree."
			cd ..
		fi
	fi

	#field
	if [ $(basename $(pwd)) = field ]; then
		if [ $knife == 1 ]; then
			echo "A monster appears out of the bushes."
			if [ amulet == 0]; then
				echo "You have nothing to protect yourself. Consequently, you died."
			else
				echo "The monster sees the amulet in your pocket. It runs away in fear. As if activated, the amulet starts to brighten, and you find yourself outside of the forest. Congratulations! You survived!"
				game=1
			fi
		else
			echo "You see an open field. It is too vast to travel through. You return to the oak tree."
				cd ..
		fi
	fi

	#dead
	if [ $(basename $(pwd)) = dead ]; then
		 echo "Game over..."
		 game=2
	fi
done

echo "..."
echo "..."
echo "Play again!"
