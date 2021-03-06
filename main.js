


$(function() {
    var vm = {
        // array for the modes sent from the processing sketch
        modes: ko.observableArray([]),
    };

    vm.selectMode = function(mode) {
        // a mode button has been clicked, so we send its key
        $.getJSON("http://127.0.0.1:8010", `key=${mode.key}`)
            .done(function(r) {
                /*
                the modes that get sent back look like this:
                [
                    { "key": "R", "name": "Red", "isActive": false },
                    { "key": "G", "name": "Green", "isActive": true },
                    { "key": "B", "name": "Blue", "isActive": false }
                ]
                */

                // the modes are now put into the observable array, 
                // which causes the UI to update.
                vm.modes(r);
            }).fail(function() {
                console.log("err");
            });
    };
    var failedToRefresh = false;
    
    vm.refresh = function() {
        if (!failedToRefresh) {
            $.getJSON("http://127.0.0.1:8010")
            .done(r => {
                console.log("refreshing modes");
                vm.modes(r);
            }).fail(function() {
                console.log("error!");
                failedToRefresh = true;
                // most likely, the server sketch quit or is inaccessible.
            });
        }
    };

    ko.applyBindings(vm);

    vm.refresh();

    // call refresh every 500 milliseconds to keep the web UI updated
    setInterval(vm.refresh, 500);
});
