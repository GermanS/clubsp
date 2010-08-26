var URL = '/rpc';
var RPCDepartingCountry   = 'rpc.air.DepartingCountry';
var RPCDepartingCity      = 'rpc.air.DepartingCity';
var RPCDestinationCountry = 'rpc.air.DestinationCountry';
var RPCDestinationCity    = 'rpc.air.DestinationCity';
var RPCDepartingDate      = 'rpc.air.DepartingDate';
var PRCReturningDate      = 'rpc.air.ReturningDate';
var METHODS = [
    RPCDepartingCountry,
    RPCDepartingCity,
    RPCDestinationCountry,
    RPCDestinationCity,
    RPCDepartingDate,
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
    $("select[name='DepartingCountry']").bind('change', fireDepartingCountryChanged);
    $("select[name='DepartingCity']").bind('change', fireDepartingCityChanged);
    $("select[name='DestinationCountry']").bind('change', fireDestinationCountryChanged);
    $("select[name='DestinationCity']").bind('change', fireDestinationCityChanged);
    $("select[name='DepartingDate']").bind('change', fireDepartingDateChanged);
});

function fireDepartingCountryChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='DepartingCity']");
    makeRequest(RPCDepartingCity, { departingCountry : value }, element);
}

function fireDepartingCityChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='DestinationCountry']");
    makeRequest(RPCDestinationCountry, { departingCity : value }, element);
}

function fireDestinationCountryChanged() {
    var value = $(this).attr('value');
    var element = $("select[name='DestinationCity']");
    makeRequest(RPCDestinationCity, { destinationCountry : value }, element);
}

function fireDestinationCityChanged() {
    var value = $(this).attr('value');
    var departingCity = $("select[name='DepartingCity']").attr('value');
    var element = $("select[name='DepartingDate']");
    makeRequest(RPCDepartingDate, { departingCity: departingCity, destinationCity : value }, element);
}

function fireDepartingDateChanged() {
    var value = $(this).attr('value');
    var departingCity   = $("select[name='DepartingCity']").attr('value');
    var destinationCity = $("select[name='DestinationCity']").attr('value');
    var element = $("select[name='ReturningDate']");
    makeRequest(PRCReturningDate, {
        departingCity: departingCity,
        destinationCity: destinationCity,
        departingDate: value
    }, element);
}

function fireIsOneWayClicked(object) {
    var element = $("select[name='ReturningDate']");

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
            //alert('on Complete');
            //alert(response);
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
