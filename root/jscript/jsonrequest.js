var FareSearchCitiesOfDepartureOW  = '/json/charter/searchCitiesOfDepartureOW';
var FareSearchCitiesOfArrivalOW    = '/json/charter/searchCitiesOfArrivalOW';
var FareSearchDatesOfDepartureOW   = '/json/charter/searchDatesOfDepartureOW';
var FareSearchCitiesOfDeparture1RT = '/json/charter/searchCitiesOfDeparture1RT';
var FareSearchCitiesOfArrival1RT   = '/json/charter/searchCitiesOfArrival1RT';
var FareSearchCitiesOfDeparture2RT = '/json/charter/searchCitiesOfDeparture2RT';
var FareSearchCitiesOfArrival2RT   = '/json/charter/searchCitiesOfArrival2RT';
var FareSearchDatesOfDeparture1RT  = '/json/charter/searchDatesOfDeparture1RT';
var FareSearchDatesOfDeparture2RT  = '/json/charter/searchDatesOfDeparture2RT';

/* common functions */
var FareSearchCitiesOfDeparture = '/json/charter/searchCitiesOfDeparture';
var FareSearchCitiesOfArrival   = '/json/charter/searchCitiesOfArrival';
var FareSearchDatesOfDeparture  = '/json/charter/searchDatesOfDeparture';
var FareSearchFlights           = '/json/charter/searchFlights';
var FareSearchTimetable         = '/json/charter/searchTimetable';

/* Timetable requests */
var Timetable_getCitiesOfDeparture  = '/json/charter/timetable/getCitiesOfDeparture';
var Timetable_getCitiesOfArrival    = '/json/charter/timetable/getCitiesOfArrival';
var Timetable_searchFlights         = '/json/charter/timetable/searchFlights';

/* location requests */
var REQ_CountryOfDeparture = '/json/location/getCountryOfDeparture';
var REQ_CityOfDeparture    = '/json/location/getCityOfDeparture';
var REQ_AirportOfDeparture = '/json/location/getAirportOfDeparture';
var REQ_CountryOfArrival   = '/json/location/getCountryOfArrival'
var REQ_CityOfArrival      = '/json/location/getCityOfArrival';
var REQ_AirportOfArrival   = '/json/location/getAirportOfArrival';


function makeRequest(method, params, element, initialValue) {
    var request = $.ajax({
        url: method,
        dataType: 'json',
        data: params,
        success : function(result) {
            if (element && element[0]) {
                element[0].options.length = 0;

                $(result).each(function() {
                    var option = document.createElement("option");
                    option.text = $(this).attr('name');
                    option.value = $(this).attr('id');

                    element.append(option);
                });

                element.val(initialValue);
                element.attr('disabled', false);
                element.change();
            }
        }
    });

}


