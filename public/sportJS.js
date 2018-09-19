// Author: Yuxiang Lin (Mike)
// Created: 6/14
// Edit: N/A

// Description: Add the previous game information to the banner.
// Requires: N/A
// Updates: wrap
// Returns: N/A
function getPrevGame(prevGameData) {
	var date = prevGameData[0];
	var location = prevGameData[1];
	var players = prevGameData[2].split(",");
	var p1ScoreIndex = players[0].search('[0-9]')
	var p1 = players[0].substr(0, p1ScoreIndex)
	var p1Score = players[0].substr(p1ScoreIndex)
	var p2ScoreIndex = players[1].search('[0-9]')
	var p2 = players[1].substr(0, p2ScoreIndex)
	var p2Score = players[1].substr(p2ScoreIndex)

	$('.vs').append(p1 + '<span class="score">' + p1Score + '</span>' + ' vs.' + '<span class="score">' + p2Score + '</span>' + p2);
	$('.locDate').append(date + " at " + location);
}

// Description: Append all players and coach to the html
// Requires: |player_list|=|player_picture| with the same order
//           |coach_list|=|coach_picture| with the same order
// Updates: wrap
// Returns: N/A
function getPlayerCoach(player_list, player_picture,coach_list, coach_picture) {
	var windowHeight = $(window).height();
	var windowWidth = $('body').width();
	var boxWidth = 120;
	var boxHeight = 190;
	var numOfColumns = Math.floor(windowWidth / boxWidth);
	var numOfRows = Math.ceil(windowHeight / boxHeight);
	var numOfDisplay = Math.min((numOfRows * numOfColumns), player_list.length);
	$('#wrap').width(boxWidth*numOfColumns);

	for(var i = 0; i < player_list.length; i++) {
		addPeople($('.player-container'), player_list[i], player_picture[i]);
	}
	for(var i=0;i<coach_list.length;i++){
		addPeople($('.coach-container'), coach_list[i], coach_picture[i]);
	}
}

// Description: Append a box (people) with name and picture
// Requires: wrap∈jQuery element
// Updates: wrap
// Returns: N/A
function addPeople(wrap, name, picture) {
	//Setup a container (box) for the house in housing_list[index]
	wrap.append('<div class=\"box\"></div>');

	//Setup image and name
	var thisBox = $('.box').last();
	thisBox.append('<div class="img_container"><img src=\"' + picture + '\" class=\"photo\" /></div><p class=\"name\">' + name + '</p>')
}

// Description: Entry point when the page is loaded.
// Requires: N/A
// Updates: N/A
// Returns: N/A
$(document).ready(function(event) {
	//Fetch local sport.json file
	fetch('sport.json')
		//Get the response json object and store in sport_list
		.then(response => response.json()).then(function(sport_list) {

			var wrap = $('#wrap');
			var heading = $('h1');
			heading.append(sport_list.gender + " " + sport_list.name);
			getPrevGame(sport_list.prev_game)
			getPlayerCoach(sport_list.player_names, sport_list.player_pictures,sport_list.coach_names,sport_list.coach_pictures);
		})
})
