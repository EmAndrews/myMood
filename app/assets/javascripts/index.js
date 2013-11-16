$(function () {
    var h = new Highcharts.Chart({
        chart: {
            renderTo: 'line-graph',
            type: 'line'
        },
        title: {
            text: 'Week of Ratings',
            x: -20 //center
        },
        xAxis: {
            categories: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
        },
        yAxis: {
            title: {
                text: 'Ratings'
            },
            max: 10,
            tickInterval: 1,
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: 'Mood',
            data: [7, 6, 9, 10, 8, 2, 5]
        }, {
            name: 'Sleep',
            data: [2, 8, 5, 10, 7, 2, 4]
        }]
    });
});

$(function () {
    var h = new Highcharts.Chart({
        chart: {
            renderTo: 'pie-chart',
            type: 'pie',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Average yes/no answers'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Yes',       73.2],
                {
                    name: 'No',
                    y: 26.8,
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
});

$(document).ready(function () {
    $('#settings-content').hide();
//    $.fn.carousel.defaults = {
//        interval: false, pause: 'hover'
//    };
//    $('.carousel').carousel({interval: false});
//
//    $(document).on('mouseleave', '.carousel', function() {
//        $(this).carousel('pause');
//    });

    $('#settings').click( function() {
        $('#homepage-content').hide();
        $('#settings-content').show();
        return false;
    });

    $('.brand').click( function() {
        $('#settings-content').hide();
        $('#homepage-content').show();
        return false;
    });

    $('.home').click( function() {
        $('#settings-content').hide();
        $('#homepage-content').show();
        return false;
    });
});

