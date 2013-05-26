$.getJSON('/petitions/51942b9b2f2c888e2f00000c.json', function(data) {

    d3.select('#petition')
        .append('h5')
        .text(data.petition.attributes.title);

    d3.select('#petition')
        .append('p')
        .text(data.petition.attributes.body);

    d3.select('#entities')
        .selectAll('p')
        .data(data.semantria.entities)
        .enter()
        .append('p')
        .text(function(d) { return d.entity_type + ': ' + d.title + ' (' + d.sentiment_score + ')'; })
        .style('color', function(d){
            switch(d.sentiment_polarity)
            {
                case 'positive':
                    return 'green';
                case 'negative':
                    return 'red';
                case 'neutral':
                    return 'black';
                default:
                    return 'black';
            }
        });

});
