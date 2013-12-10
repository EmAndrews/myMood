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
        series: [
            {
                type: 'pie',
                name: 'Percent of Users',
                data: [
                    ['Yes', 73.2],
                    {
                        name: 'No',
                        y: 26.8,
                        sliced: true,
                        selected: true
                    }
                ]
            }
        ]
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

    if ($('#settings').length != 0) {
        $.get('/user_messages',function (messages) {
            // CHAT HISTORY
            console.log(messages.processed_messages);
            // add to #widget
            // sorting graph_data by date in ascending order
            var chat_history = [];
            $.extend(chat_history, messages.processed_messages);
            chat_history.sort(function (a, b) {
                a = new Date(a.date_processed);
                b = new Date(b.date_processed);
                return a < b ? -1 : a > b ? 1 : 0;
            });

            console.log(chat_history);

            var text;
            for (var chat = 0; chat < chat_history.length; chat++) {
                if (chat_history[chat].from_my_mood === 0) {
                    // give class chat-from-my-mood
                    text = $('<p class="chat-user well">' +
                        chat_history[chat].text +
                        '</p> ')
                } else {
                    // give class chat-user
                    text = $('<p class="chat-from-my-mood  well">' +
                        chat_history[chat].text +
                        '</p> ')
                }
                $('#widget').append(text);
                $('#widget').append($('<p style="clear: both"></p>'));

//                $('#widget').scrollTop = $('#widget').scrollHeight;
            }
//            $('#widget').scrollTop($('#widget')[0].scrollHeight);
            $('#widget').animate({ scrollTop: $('#widget')[0].scrollHeight}, 1000);


            // GRAPH
            //        console.log("data was successfully received from the ajax request");
            //        console.log(messages.processed_messages);
            //        console.log(messages.prefixes);
            // create dictionary {category, ratings (array[7]) to easily convert to how highcharts wants the data to be
            // convert the dates in data_graph to be indices for the last_seven_days
            //      (data_graph.date - 7th_day_ago) / 1000 / 60 / 60/ 24
            // use index to go into ratings array in dictionary

            // first create [[index into ratings array in dict, rating, category], ...]
            var graph_data = [];
            for (var i = 0; i < messages.processed_messages.length; i++) {
                // only checking for messages the user responded with and not twilio's response
                if (messages.processed_messages[i].data != null) {
                    graph_data[i] = [];
                    d = new Date();
                    d.setDate(d.getDate() - 6);
                    graph_data[i][0] = Math.ceil((new Date(messages.processed_messages[i].date_processed) - d) / 1000 / 60 / 60 / 24);
                    graph_data[i][1] = messages.processed_messages[i].data;
                    // need to parse prefix from text and then find the corresponding Category it belongs to
                    var prefix = messages.processed_messages[i].text.split(messages.processed_messages[i].data)[0];
                    for (var j = 0; j < messages.prefixes.length; j++) {
                        if (messages.prefixes[j].prefix == prefix) {
                            graph_data[i][2] = messages.prefixes[j].name;
                            break;
                        }
                    }
                }
            }

            // handling case where first message is from mymood
            if (graph_data[0] == null) {
                graph_data.shift();
            }

            // sorting graph_data by date in ascending order
            graph_data = graph_data.sort(function (a, b) {
                return a[0] - b[0];
            });

            // getting last 7 days for the x-axis
            var d = new Date();
            d.setDate(d.getDate() - 6);
            var last_seven_days = [];
            for (var k = 0; k < 7; k++) {
                last_seven_days[k] = (d.getMonth() + 1) + '/' + d.getDate() + '/' + d.getFullYear();
                d.setDate(d.getDate() + 1);
            }

            // setting up the dictionary to then easily convert to data for the graph
            var dict = {};
            for (var l = 0; l < graph_data.length; l++) {
                if (dict[graph_data[l][2]] == null) {
                    dict[graph_data[l][2]] = [null, null, null, null, null, null, null];
                } else {
                    dict[graph_data[l][2]][graph_data[l][0]] = parseInt(graph_data[l][1]);
                }
            }

            //if user just signed up or is inactive, make null graph for categories they are signed up for
            if (graph_data.length == 0) {
                for (var x = 0; x < messages.categories.length; x++) {
                    var cat_id = parseInt(messages.categories[x]);
                    for (var a = 0; a < messages.prefixes.length; a++) {
                        if (messages.prefixes[a].id === cat_id) {
                            dict[messages.prefixes[a].name] = [null, null, null, null, null, null, null];
                        }
                    }
                }
            }

            // converting dict into array of objects to pass into highcharts
            var data = [];
            var counter = 0;
            for (var h in dict) {
                data[counter++] = {
                    name: h,
                    data: dict[h]
                };
            }

            // using highcharts code to create graph
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
                        categories: last_seven_days
                    },
                    yAxis: {
                        title: {
                            text: 'Ratings'
                        },
                        max: 10,
                        min: 0,
                        tickInterval: 1,
                        plotLines: [
                            {
                                value: 0,
                                width: 1,
                                color: '#808080'
                            }
                        ]
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle',
                        borderWidth: 0
                    },
                    plotOptions: {
                        series: {
                            connectNulls: true
                        }
                    },
                    series: data
                });
            });
        }, 'json').fail(function () {
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
                                text: 'An unknown error occurred when fetching your data :('
                            },
                            max: 10,
                            min: 0,
                            tickInterval: 1,
                            plotLines: [
                                {
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }
                            ]
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            borderWidth: 0
                        },
                        series: [
                            {
                                name: 'Mood',
                                data: [null, null, null, null, null, null, null]
                            }
                        ]
                    });
                });
            });
    }

    // hack so that this ajax request only happens in admin page
    if ($('#category-table').length != 0) {
        $.get('/all_messages',function (messages) {
            // create dictionary {category, average ratings (array[7]) to easily convert to how highcharts wants the data to be
            // convert the dates in data_graph to be indices for the last_seven_days
            //      (data_graph.date - 7th_day_ago) / 1000 / 60 / 60/ 24
            // use index to go into ratings array in dictionary

            // first create [[[index into ratings array in dict, rating, category], ...], ....]
            //      basically an entry for each user


            var graph_data = [];
            for (var m = 0; m < messages.users.length; m++) {
                graph_data[m] = [];
                for (var i = 0; i < messages.processed_messages.length; i++) {
                    // only checking for messages the user responded with and not twilio's response
                    //      and that the message is from that user
                    if (messages.users[m].id === messages.processed_messages[i].user_id && messages.processed_messages[i].from_my_mood === 0) {
                        graph_data[m][i] = [];
                        d = new Date();
                        d.setDate(d.getDate() - 6);
                        graph_data[m][i][0] = Math.ceil((new Date(messages.processed_messages[i].date_processed) - d) / 1000 / 60 / 60 / 24);
                        graph_data[m][i][1] = messages.processed_messages[i].data;
                        // need to parse prefix from text and then find the corresponding Category it belongs to
                        var prefix = messages.processed_messages[i].text.split(messages.processed_messages[i].data)[0];
                        for (var j = 0; j < messages.prefixes.length; j++) {
                            if (messages.prefixes[j].prefix == prefix) {
                                graph_data[m][i][2] = messages.prefixes[j].name;
                                break;
                            }
                        }
                    }
                }
            }

            for (var data_idx = 0; data_idx < graph_data.length; data_idx++) {
                if (graph_data[data_idx][0] == null) {
                    graph_data[data_idx].shift();
                }
            }

            // sorting graph_data by date in ascending order for each user
            for (var user = 0; user < graph_data.length; user++) {
                graph_data[user] = graph_data[user].sort(function (a, b) {
                    return a[0] - b[0];
                });
            }

            // getting last 7 days for the x-axis
            var d = new Date();
            d.setDate(d.getDate() - 6);
            var last_seven_days = [];
            for (var k = 0; k < 7; k++) {
                last_seven_days[k] = (d.getMonth() + 1) + '/' + d.getDate() + '/' + d.getFullYear();
                d.setDate(d.getDate() + 1);
            }

            // for each day
            //  for each user
            //      for each entry
            //          if day == entry
            //              add 1 to the number of users for that day unless that user has been seen before
            // getting number of unique user responses for the last 7 days
            var number_of_responses = [];
            for (var day = 0; day < last_seven_days.length; day++) {
                number_of_responses[day] = 0;
                for (var user_idx = 0; user_idx < graph_data.length; user_idx++) {
                    // to make sure we don't count multiple messages per day
                    var seen_users = [];
                    for (var entry = 0; entry < graph_data[user_idx].length; entry++) {
                        if (graph_data[user_idx][entry] != null && graph_data[user_idx][entry][0] === day && seen_users.indexOf(user_idx) <= -1) {
                            seen_users.push(user_idx);
                            number_of_responses[day] += 1;
                        }
                    }
                }
            }

            // create
            // for each user
            //  for each entry
            //      add rating for specific day to dict
            // setting up the dictionary to then easily convert to data for the graph
            // create dictionary {category, average ratings (array[7]) to easily convert to how highcharts wants the data to be
            var dict = {};
            var keep_track_of_responses = number_of_responses;
            for (var u = 0; u < messages.users.length; u++) {
                for (var l = 0; l < graph_data[u].length; l++) {
                    if (graph_data[u][l] != undefined) {
                        if (dict[graph_data[u][l][2]] == null) {
                            dict[graph_data[u][l][2]] = [null, null, null, null, null, null, null];
                        } else {
                            if (dict[graph_data[u][l][2]][graph_data[u][l][0]] === null) {
                                dict[graph_data[u][l][2]][graph_data[u][l][0]] = parseInt(graph_data[u][l][1]);
                            } else if (keep_track_of_responses[graph_data[u][l][0]] > 1) {
                                // add multiple ratings together
                                keep_track_of_responses[graph_data[u][l][0]]--;
                                dict[graph_data[u][l][2]][graph_data[u][l][0]] += parseInt(graph_data[u][l][1]);
                            }
                        }
                    }
                }
            }

            // make sure writes average vs last rating
            for (var rating_for_day in dict) {
                for (var z = 0; z < dict[rating_for_day].length; z++) {
                    dict[rating_for_day][z] = dict[rating_for_day][z] / number_of_responses[z];
                }

            }

            //if user just signed up or is inactive, make null graph for categories they are signed up for
            // no user data:
            if (graph_data.length == 0) {
                dict['Mood'] = [null, null, null, null, null, null, null];
            }

            // converting dict into array of objects to pass into highcharts
            var data = [];
            var counter = 0;
            for (var h in dict) {
                data[counter++] = {
                    name: h,
                    data: dict[h]
                };
            }

            // using highcharts code to create graph
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
                        categories: last_seven_days
                    },
                    yAxis: {
                        title: {
                            text: 'Average Ratings'
                        },
                        max: 10,
                        min: 0,
                        tickInterval: 1,
                        plotLines: [
                            {
                                value: 0,
                                width: 1,
                                color: '#808080'
                            }
                        ]
                    },
                    legend: {
                        layout: 'vertical',
                        align: 'right',
                        verticalAlign: 'middle',
                        borderWidth: 0
                    },
                    plotOptions: {
                        series: {
                            connectNulls: true
                        }
                    },
                    series: data
                });
            });
        }, 'json').fail(function () {
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
                                text: 'An unknown error occurred when fetching your data :('
                            },
                            max: 10,
                            min: 0,
                            tickInterval: 1,
                            plotLines: [
                                {
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }
                            ]
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            borderWidth: 0
                        },
                        series: [
                            {
                                name: 'Mood',
                                data: [null, null, null, null, null, null, null]
                            }
                        ]
                    });
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

