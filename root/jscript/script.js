var URL = '/rpc';
var RPCDepartureCountry = 'rpc.air.DepartureCountry';
var RPCDepartureCity    = 'rpc.air.DepartureCity';
var RPCArrivalCountry   = 'rpc.air.ArrivalCountry';
var RPCArrivalCity      = 'rpc.air.ArrivalCity';
var RPCDepartureDate    = 'rpc.air.DepartureDate';
var PRCReturningDate    = 'rpc.air.ReturnDate';
var METHODS = [
    RPCDepartureCountry,
    RPCDepartureCity,
    RPCArrivalCountry,
    RPCArrivalCity,
    RPCDepartureDate,
    PRCReturningDate
];
var service = new rpc.ServiceProxy(URL, {
    asynchronous: true,
    sanitize: false,
    methods: METHODS,
    protocol: 'XML-RPC'
});

/*
 * Let's rock
 */
$(function() {
    $("input[name='isOneWay']").bind('click', fireIsOneWayClicked);
    $("select[name='DepartureCountry']").bind('change', fireDepartureCountryChanged);
    $("select[name='DepartureCity']").bind('change', fireDepartureCityChanged);
    $("select[name='ArrivalCountry']").bind('change', fireArrivalCountryChanged);
    $("select[name='ArrivalCity']").bind('change', fireArrivalCityChanged);
    $("select[name='DepartureDate']").bind('change', fireDepartureDateChanged);
});

function fireDepartureCountryChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='DepartureCity']");
    makeRequest(RPCDepartureCity, { departureCountry : value }, element);
}

function fireDepartureCityChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='ArrivalCountry']");
    makeRequest(RPCArrivalCountry, { departureCity : value }, element);
}

function fireArrivalCountryChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='ArrivalCity']");
    makeRequest(RPCArrivalCity, { arrivalCountry : value }, element);
}

function fireArrivalCityChanged() {
    var value = $(this).attr('value');
    var departureCity = $("select[name='DepartureCity']").attr('value');
    var element = $("select[name='DepartureDate']");
    makeRequest(RPCDepartureDate, { departureCity: departureCity, arrivalCity : value }, element);
}

function fireDepartureDateChanged() {
    var value = $(this).attr('value');
    var departureCity   = $("select[name='DepartureCity']").attr('value');
    var arrivalCity = $("select[name='ArrivalCity']").attr('value');
    var element = $("select[name='ReturnDate']");
    makeRequest(PRCReturningDate, {
        departureCity: departureCity,
        arrivalCity: arrivalCity,
        departureDate: value
    }, element);
}

function fireIsOneWayClicked(object) {
    var element = $("select[name='ReturnDate']");

    ($(this).attr('checked'))
        ? element.attr('disabled', 'disabled')
        : element.attr('disabled', false);
}

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
            updateList(element, response.result)
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
