import 'bootstrap';
import $ from 'jquery';
import ko from 'knockout';

window.ko = ko;
$(() => {
    let vm = {
        modes: ko.observableArray([]),
    };

    vm.selectMode = mode => {
        
        $.getJSON("http://127.0.0.1:8010", `key=${mode.key}`)
            .done(r => {
                vm.modes(r);
            }).fail(() => {
                console.log("err");
            });
    };

    vm.refresh = () => {
        console.log("refreshing");
        $.getJSON("http://127.0.0.1:8010")
            .done(r => {
                vm.modes(r);
            }).fail(() => {
                console.log("err");
            });
    };

    ko.applyBindings(vm);

    vm.refresh();

});
