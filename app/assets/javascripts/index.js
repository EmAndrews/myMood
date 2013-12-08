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
            name: 'Percent of Users',
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

function setCarouselToStopSpinning() {
    $('.carousel').carousel({interval: false});
}

function removeStatusBarHandler() {
    $('.status-button').click(function () {
        $('#notice').remove();
        $('#alert').remove();
    });
}
function goBackToSettingsAfterFailedChange() {
    $('#failed-change').click(function () {
        $('#alert').remove();
        $('#homepage-content').hide();
        $('#settings-content').show();
        return false;
    });
}
function clickingOnSettingsHandler() {
    $('#settings').click(function () {
        $('#homepage-content').hide();
        $('#settings-content').show();
        return false;
    });
}
function clickingOnBrandHandler() {
    $('.brand').click(function () {
        $('#settings-content').hide();
        $('#homepage-content').show();
        return false;
    });
}
function clickingOnHomeHandler() {
    $('.home').click(function () {
        $('#settings-content').hide();
        $('#homepage-content').show();
        return false;
    });
}
function drawAdminPieChartIfAdmin() {
    if ($('#admin-pie-chart').length != 0) {
        $(function () {
            var h = new Highcharts.Chart({
                chart: {
                    renderTo: 'admin-pie-chart',
                    type: 'pie',
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false
                },
                title: {
                    text: 'Active vs Inactive Users as of today'
                },
                tooltip: {
                    pointFormat: "{series.name}: <b>{point.percentage:.1f}%</b>"
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            color: '#000000',
                            connectorColor: '#000000',
                            format: "<b>{point.name}</b>: {point.percentage:.1f} %"
                        }
                    }
                },
                series: [
                    {
                        type: 'pie',
                        name: 'Percent of Users',
                        data: [
                            ['Active', 65.0],
                            {
                                name: 'Inactive',
                                y: 35.0,
                                sliced: true,
                                selected: true
                            }
                        ]
                    }
                ]
            });
        });
    }
}
$(document).ready(function () {

    var user_msgs = null;
    $.get('/user_messages',function(data) {
        user_msgs = data;
        console.log("data was successfully received from the ajax request");
    }, 'json');

    if (user_msgs != null) {
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
                    min: 0,
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
    } else {
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
                    min: 0,
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
                    data: [0, 0, 0, 0, 0, 0, 0]
                }]
            });
        });
    }

    drawAdminPieChartIfAdmin();

    setCarouselToStopSpinning();

    removeStatusBarHandler();

    goBackToSettingsAfterFailedChange();

    clickingOnSettingsHandler();

    clickingOnBrandHandler();

    clickingOnHomeHandler();
});

