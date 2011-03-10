var URL = '/xmlrpc';
var REQ_CountryOfDeparture = 'xmlrpc.flight.getCountryOfDeparture';
var REQ_CityOfDeparture    = 'xmlrpc.flight.getCityOfDeparture';
var REQ_AirportOfDeparture = 'xmlrpc.flight.getAirportOfDeparture';
var REQ_CountryOfArrival   = 'xmlrpc.flight.getCountryOfArrival'
var REQ_CityOfArrival      = 'xmlrpc.flight.getCityOfArrival';
var REQ_AirportOfArrival   = 'xmlrpc.flight.getAirportOfArrival';

/* Timetable requests */
var Timetable_getCitiesOfDeparture  = 'xmlrpc.flight.timetable.getCitiesOfDeparture';
var Timetable_getCitiesOfArrival    = 'xmlrpc.flight.timetable.getCitiesOfArrival';
var Timetable_searchFlights         = 'xmlrpc.flight.timetable.searchFlights';

/* Fare requests*/
var FareSearchCitiesOfDeparture = 'xmlrpc.flight.fare.searchCitiesOfDeparture';
var FareSearchCitiesOfArrival   = 'xmlrpc.flight.fare.searchCitiesOfArrival';
var FareSearchDatesOfDeparture  = 'xmlrpc.flight.fare.searchDatesOfDeparture';
var FareSearchFlights           = 'xmlrpc.flight.fare.searchFlights';

var METHODS = [
    REQ_CountryOfDeparture,
    REQ_CityOfDeparture,
    REQ_AirportOfDeparture,
    REQ_CountryOfArrival,
    REQ_CityOfArrival,
    REQ_AirportOfArrival,
    Timetable_getCitiesOfDeparture,
    Timetable_getCitiesOfArrival,
    Timetable_searchFlights,
    FareSearchCitiesOfDeparture,
    FareSearchCitiesOfArrival,
    FareSearchDatesOfDeparture,
    FareSearchFlights
];
var service = new rpc.ServiceProxy(URL, {
    asynchronous: true,
    sanitize: false,
    methods: METHODS,
    protocol: 'XML-RPC',
});


/**
 * makeRequest(method, params, element, initialValue)
 *
 * запрос rpc метода с параметрами
 * результат запроса записывается в element
 * значение по умолчанию берется из initialValue
 *
 **/
function makeRequest(method, params, element, initialValue) {
    var methodObject = service;
    var propChain = method.split(/\./);
    for(var j = 0; j+1 < propChain.length; j++){
        methodObject = methodObject[propChain[j]];
    }

    methodObject[propChain[propChain.length-1]]({
        params: [ params ],
        onSuccess:function(message){
            //alert('on Success');
            //updateList(element, message);
        },
        onComplete: function(response) {
            updateList(element, initialValue, response.result);
        },
        onException:function(e){
            alert("Unable to request because: " + e);
            return true;
        }
    });
}

/*
 * Изменение списка элементов
 * element - элемент над которым требуются модификации
 * result - массив с идентификаторами и названиями элемента
 */

function updateList(element, initialValue, result) {
    var options = '';
    $(result).each(function() {
        options += '<option value="' + $(this).attr('id') + '">' + $(this).attr('name') + '</option>';
    });

    element.html(options);
    element.val(initialValue);
    element.attr('disabled', false);
    element.change();
}
