$.getJSON('/petitions/51942b9b2f2c888e2f00000c.json', function(data) {

    d3.select('#petition')
        .append('h5')
        .text(data.petition.attributes.title);

    d3.select('#petition')
        .append('p')
        .text(data.petition.attributes.body);

    // Extract Countries from the Open Calais result:
    var locations = [];
    for(var key in data.open_calais) {
        var value = data.open_calais[key];
        if(value._typeGroup == 'entities') {
            var entity = value;
            if(entity._type == 'Country') {
                if(entity.resolutions) {
                    locations.push(entity.resolutions[0]);
                }
            }
        }
    }

    // Add a map for each location:
    d3.select("#maps")
        .selectAll('div')
        .data(locations)
        .enter()
        .append('div')
        .attr('id', function(d, i) {
            return 'map' + i;
        })
        .style('height', '300px')
        .style('width', '300px');

    // Draw the maps using Leaflet.js
    d3.select("#maps")
        .selectAll('div')
        .each(function(d, i){
            var map = L.map('map' + i).setView([d.latitude, d.longitude], 3);

            L.tileLayer('http://{s}.tile.cloudmade.com/8ee2a50541944fb9bcedded5165f09d9/997/256/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
            }).addTo(map);

            L.marker([d.latitude, d.longitude])
                .addTo(map)
                .bindPopup(d.name)
                .openPopup();

        });


});

