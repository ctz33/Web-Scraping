// Author: Yuxiang Lin
// Created: 6/10
// Edit: 6/12 Mike, Add map and back function, simplify code logic
// Edit: 6/12 Gail, Mike, Change facilities to icon+title display


// Description: Setup each box's listener includes hover, address_line click, and back_button click
// Requires: thisBox, thisMap, thisBack ∈ jQuery element;
//			 address is the full address (including street number and city name)
// Updates: thisBox, thisMap, thisBack
// Returns: N/A
function setUpBoxAction(thisBox, thisMap, thisBack, address) {
	//Mouse Enter and Mouse Leave actions
	var mouseE = function(event) {
		$(this).find(".housing_img").stop().animate({
			opacity: '0.1',
		}, 300)
		$(this).find(".more_info").stop().animate({
			opacity: '1',
		}, 300)
	}
	var mouseL = function(event) {
		$(this).find(".housing_img").stop().animate({
			opacity: '1',
		}, 200)
		$(this).find(".more_info").stop().animate({
			opacity: '0',
		}, 300)
	}
	thisBox.hover(mouseE, mouseL);

	//Click address
	var setUpMapSucess;
	thisBox.find('a').click(function(event) {
		setUpMap(thisMap[0], address);
		thisBox.unbind('mouseenter mouseleave');
		thisBox.find(".more_info").css({
			opacity: '0',
			zIndex: '0'
		})
		thisBack.css({
			display: 'block',
			zIndex: '9',
			cursor: "pointer",
		})
		thisMap.css({
			opacity: '1',
			zIndex: '9',
		})
	})

	//Click back
	thisBack.click(function(event) {
		thisMap.css({
			opacity: '0',
			zIndex: '0',
		})
		thisBack.css({
			display: 'none',
			zIndex: '0',
		})
		thisBox.find(".more_info").css({
			opacity: '1',
			zIndex: '3'
		})
		thisBox.hover(mouseE, mouseL);
	})
}

// Description: Append a box (house) from housing_list[index] to #wrap
// Requires: ∀x ∈[0,housing_list.length), housing_list[x] has name, image, address, phone, campus, area, hall_director, facility_set,learning_community attributes not null
//			 index ∈ Integer, 0<=index<=housing_list.length-1
// Updates: wrap
// Returns: N/A
function addHouse(housing_list, index, wrap) {
	//Setup a container (box) for the house in housing_list[index]
	wrap.append('<div class=\"box\"></div>');

	//Setup image and heading
	var thisBox = $('.box').last();
	if(housing_list[index].image!=null){
		thisBox.append('<div class="img_container"><img src=\"' + housing_list[index].image + '\" class=\"housing_img\" /></div><p class=\"housing_name\">' + housing_list[index].name + '</p>')
	}else{
		thisBox.append('<div class="img_container"><img src=\"img/no_img_found.jpg\" class=\"housing_img\" /></div><p class=\"housing_name\">' + housing_list[index].name + '</p>')
	}
	thisBox.append('<p class=\"more_info\"></p>');

	//Setup more_info content to display when mouse hover
	var thisInfo = $('.more_info').last();
	thisInfo.append('Address: <a>' + housing_list[index].address + '</a><br/>');
	thisInfo.append('Phone: ' + housing_list[index].phone + '<br/>');
	if(housing_list[index].area != "n/a"){
		thisInfo.append('Campus: ' + housing_list[index].campus+"  "+housing_list[index].area + '<br/>');
	}else{
		thisInfo.append('Campus: ' + housing_list[index].campus + '<br/>');
	}
	thisInfo.append('Hall Director: ' + housing_list[index].hall_director + '<br/>');
	thisInfo.append('<hr />');

	//Setup icons for more_info content
	var facilities = housing_list[index].facility_set
	for(var i = 0; i < facilities.length; i++) {
		switch(facilities[i]) {
			case "Microwave/Refrigerator":
				appendFacility(thisInfo,"Microwave","&#xe78c;");
				appendFacility(thisInfo,"Fridge","&#xe6a2;");
				break;
			case "Laundry Facilities (in complex)":
				appendFacility(thisInfo, facilities[i],"&#xe67d;");
				break;
			case "Lounge space":
				appendFacility(thisInfo, facilities[i],"&#xe659;");
				break;
			case "Air Conditioning":
				appendFacility(thisInfo, facilities[i],"&#xe651;");
				break;
			case "Vending Machines":
				appendFacility(thisInfo, facilities[i],"&#xe662;");
				break;
			case "Kitchen Facilities":
				appendFacility(thisInfo, facilities[i],"&#xe62e;");
				break;
			case "Own Trash Removal":
				appendFacility(thisInfo, facilities[i],"&#xe601;");
				break;
			case "Bike Room Accessible":
				appendFacility(thisInfo, facilities[i],"&#xe6a6;");
				break;
			case "Handicap Access":
				appendFacility(thisInfo, facilities[i],"&#xe622;");
				break;
			case "ResNet":
				appendFacility(thisInfo, facilities[i],"&#xe631;");
				break;
			case "Study Areas":
				appendFacility(thisInfo, facilities[i],"&#xe603;");
				break;
			case "IPTV (internet protocol television)":
				appendFacility(thisInfo, facilities[i],"&#xe6a5;");
				break;
			case "Game Room":
				appendFacility(thisInfo, facilities[i],"&#xe67e;");
				break;
			case "On site parking":
				appendFacility(thisInfo, facilities[i],"&#xe664;");
				break;
			case "Single-gender room/suite; Mixed gender wing/floor":
				appendFacility(thisInfo, "Mixed gender wing/floor","&#xe606;");
				break;
			case "Single-gender rooms on single gender wings":
				appendFacility(thisInfo, "Single gender wing","&#xe605;");
				break;
			case "Women Only":
				appendFacility(thisInfo, "Mixed gender wing/floor","&#xe606;");
				break;
			case "Academic Year Housing":
				break;
			case "Suite/Room Bath":
				appendFacility(thisInfo, facilities[i],"&#xe604;");
				break;
			case "Corridor Bath":
				appendFacility(thisInfo, facilities[i],"&#xe607;");
				break;
			case "Community sinks, Private baths on floor/wing":
				appendFacility(thisInfo, "Community sinks","&#xe607;");
				appendFacility(thisInfo, "private baths on floor/wing","&#xe604;");
				break;
			case "Single-gender floors":
				appendFacility(thisInfo, facilities[i],"&#xe605;");
				break;
			case "Fitness Room":
				appendFacility(thisInfo, facilities[i],"&#xe668;");
				break;
			default:
				thisInfo.append(facilities[i] + " ");
				break;
		}
	}

	//Learning Community
	if(housing_list[index].learning_community!="No Learning Community"){
		appendFacility(thisInfo, "Learning Community: "+housing_list[index].learning_community,"&#xe690;");
	}

	//Setup map and back button
	thisBox.append('<div class=\"map\"></div>');
	thisBox.append('<div class=\"back\">back</div>');

	//Setup each box's action
	//Including hover, map display and back button
	setUpBoxAction(thisBox, $('.map').last(), $('.back').last(), housing_list[index].full_address);
}

// Description: Append to thisInfo an facility icon
// Requires: thisInfo ∈ jQuery element
// Updates: thisInfo
// Returns: N/A
function appendFacility(thisInfo, title, unicode){
	thisInfo.append('<i class="iconfont" title=\"'+title+'\">'+unicode+'</i> ');
}


// Description: Add boxes for the first page and add entry animation.
// Requires: ∀x ∈[0,housing_list.length), housing_list[x] has name, image, address, phone, campus, area, hall_director, facility_set,learning_community attributes not null
// Updates: wrap
// Returns: number of boxes displayed in the first page.
function autoAdd(housing_list, wrap) {
	//Setup wrap's width'
	var windowHeight = $(window).height();
	var windowWidth = $('body').width();
	var boxWidth = 320;
	var boxHeight = 250;
	var numOfColumns = Math.floor(windowWidth / boxWidth);
	var numOfRows = Math.ceil(windowHeight / boxHeight);
	var numOfDisplay = Math.min((numOfRows * numOfColumns), housing_list.length);
	wrap.width(boxWidth * numOfColumns);

	//Add first page to display
	for(var i = 0; i < numOfDisplay; i++) {
		addHouse(housing_list, i, wrap);
	}

	//Show animation starting from first box
	displayBoxAnimation($('.box').eq(0));

	return numOfDisplay;
}

// Description: Check if the user has reach the last row and need append more boxes
// Requires: wrap ∈ jQuery element
// Updates: N/A
// Returns: true, if need append; false, if not.
function needAppend(wrap) {
	var windowHeight = $(window).height();
	var scrollHeight = $(window).scrollTop();
	var boxes = $('.box');
	var lastBoxHeight = boxes.eq(boxes.length - 1).offset().top + 250;
	return lastBoxHeight <= (windowHeight + scrollHeight);
}

// Description: Append boxes to the end of #wrap
// Requires: ∀x ∈[0,housing_list.length), housing_list[x] has name, image, address, phone, campus, area, hall_director, 			facility_set,learning_community attributes not null
// Updates: N/A
// Returns: number of boxes added to #wrap
function append(housing_list, numOfDisplay) {
	var windowWidth = $('body').width();
	var boxWidth = 320;
	var numOfColumns = Math.floor(windowWidth / boxWidth);
	var numToAdd = Math.min(numOfDisplay + numOfColumns * 2, housing_list.length) - numOfDisplay;
	for(var i = 0; i < numToAdd; i++) {
		addHouse(housing_list, numOfDisplay + i);
	}

	//Animation for newly added boxes
	displayBoxAnimation($('.box').eq(numOfDisplay));

	return numToAdd;
}

// Description: Add a message if the user reach the end of list.
// Requires: N/A
// Updates: wrap
// Returns: N/A
function endMessage(wrap) {
	wrap.append('<hr /><p class="end_message">This is the end of page</p>');
}

// Description: Animation for displaying boxes from thisBox to the end of #wrap
// Requires: N/A
// Updates: thisBox, and all the boxes after thisBox
// Returns: N/A
function displayBoxAnimation(thisBox) {
	thisBox.animate({
		opacity: '1',
	}, 100, function() {
		displayBoxAnimation(thisBox.next());
	})
}

// Description: Setup the map given a canvas and address for marker.
// Requires: address is the full address (including street number and city name)
// Updates: canvas
// Returns: N/A
function setUpMap(canvas, address) {
	var map = new google.maps.Map(canvas, {
		zoom: 13
	});
	var geocoder = new google.maps.Geocoder();

	geocoder.geocode({
		'address': address
	}, function(results, status) {
		if(status === 'OK') {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map: map,
				position: results[0].geometry.location
			});
		} else {
			alert('Sorry. Address not found in the database.');
		}
	});
}

// Description: Entry point when the page is loaded.
// Requires: N/A
// Updates: N/A
// Returns: N/A
$(document).ready(function(event) {
	//Fetch local dorm.json file
	fetch('dorm.json')
		//Get the response json object and store in housing_list
		.then(response => response.json()).then(function(housing_list) {

			var wrap = $('#wrap');
			var numOfDisplay = autoAdd(housing_list, wrap);

			//When scroll window
			$(this).scroll(function(event) {
				//If scroll to the last row, append boxes
				if(needAppend(wrap)) {
					numOfDisplay += append(housing_list, numOfDisplay);
				}
				//If all the houses are displayed, unbind scroll listener
				if(numOfDisplay == housing_list.length) {
					endMessage();
					$(this).unbind("scroll");
				}
			})
		})
})
