var URL = '/xmlrpc';
var REQ_CountryOfDeparture = 'xmlrpc.flight.getCountryOfDeparture';
var REQ_CityOfDeparture    = 'xmlrpc.flight.getCityOfDeparture';
var REQ_AirportOfDeparture = 'xmlrpc.flight.getAirportOfDeparture';
var REQ_CountryOfArrival   = 'xmlrpc.flight.getCountryOfArrival'
var REQ_CityOfArrival      = 'xmlrpc.flight.getCityOfArrival';
var REQ_AirportOfArrival   = 'xmlrpc.flight.getAirportOfArrival';

var METHODS = [
    REQ_CountryOfDeparture,
    REQ_CityOfDeparture,
    REQ_AirportOfDeparture,
    REQ_CountryOfArrival,
    REQ_CityOfArrival,
    REQ_AirportOfArrival
];
var service = new rpc.ServiceProxy(URL, {
    asynchronous: true,
    sanitize: false,
    methods: METHODS,
    protocol: 'XML-RPC'
});

function makeRequest(method, params, element) {
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
            updateList(element, response.result);
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

function updateList(element, result) {
    var options = '';
    $(result).each(function() {
        options += '<option value="' + $(this).attr('id') + '">' + $(this).attr('name') + '</option>';
    });

    element.html(options);
    element.attr('disabled', false);
    element.change();
}
